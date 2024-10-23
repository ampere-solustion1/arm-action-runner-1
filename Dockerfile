# Use the official NGINX base image
FROM nginx:latest

# Copy custom configuration file from the current directory to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the static website files to the nginx HTML directory
COPY html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]


# # Use an appropriate base image
# FROM ubuntu:22.04

# # Install required packages
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     cmake \
#     ninja-build \
#     python3 \
#     git \
#     sudo \
#     lsb-release \
#     && apt-get clean

# # Create a non-root user and switch to it
# RUN useradd -m llvmuser && echo "llvmuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# USER llvmuser
# WORKDIR /home/llvmuser

# # Clone the LLVM project
# RUN git clone https://github.com/llvm/llvm-project.git

# # Set environment variables
# ENV LLVM_ENABLE_PROJECTS="clang"
# ENV LLVM_ENABLE_RUNTIMES="libunwind;libcxx;libcxxabi"
# ENV LLVM_TARGETS_TO_BUILD="AArch64;X86"
# ENV CMAKE_BUILD_TYPE=Release
# ENV LLVM_ENABLE_ASSERTIONS=ON

# # Configure and build LLVM
# RUN mkdir -p llvm-project/build && \
#     cd llvm-project/build && \
#     cmake -G Ninja \
#         -DLLVM_ENABLE_PROJECTS=$LLVM_ENABLE_PROJECTS \
#         -DLLVM_ENABLE_RUNTIMES=$LLVM_ENABLE_RUNTIMES \
#         -DLLVM_TARGETS_TO_BUILD=$LLVM_TARGETS_TO_BUILD \
#         -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
#         -DLLVM_ENABLE_ASSERTIONS=$LLVM_ENABLE_ASSERTIONS \
#         ../llvm && \
#     ninja

# # Display build information
# RUN echo "Build completed on $(date)"

# # Set the entrypoint (optional)
# ENTRYPOINT ["/bin/bash"]
