# Use an official Ubuntu base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    llvm \
    clang \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /

# Copy the build artifacts from the host to the container
COPY . .

# Set the default command to run
CMD ["clang", "--version"]
