# # Use an official Ubuntu base image
# FROM ubuntu:20.04

# # Install necessary packages
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     cmake \
#     ninja-build \
#     python3 \
#     llvm \
#     clang \
#     && rm -rf /var/lib/apt/lists/*

# # Set the working directory inside the container
# WORKDIR /

# # Copy the build artifacts from the host to the container
# COPY . .

# # Set the default command to run
# CMD ["clang", "--version"]


# Stage 1: Build LLVM
FROM ubuntu:20.04 AS build

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    git

# Set the working directory inside the container
WORKDIR /llvm-project

# Clone the LLVM project
RUN git clone https://github.com/llvm/llvm-project.git .

# Configure the build
RUN mkdir -p build && cd build && \
    cmake -G Ninja \
    -DLLVM_ENABLE_PROJECTS="clang" \
    -DLLVM_ENABLE_RUNTIMES="libunwind;libcxx;libcxxabi" \
    -DLLVM_TARGETS_TO_BUILD="AArch64;X86" \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    ../llvm

# Build the project
RUN cd build && ninja

# Stage 2: Create a minimal image using distroless
FROM gcr.io/distroless/cc

# Copy the necessary binaries from the build stage
COPY --from=build /llvm-project/build/bin/clang /usr/local/bin/clang
COPY --from=build /llvm-project/build/bin/clang++ /usr/local/bin/clang++
COPY --from=build /llvm-project/build/lib/ /usr/local/lib/

# Set the default command to run
CMD ["clang", "--version"]
