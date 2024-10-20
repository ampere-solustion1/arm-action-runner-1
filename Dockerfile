# Use an official LLVM base image
FROM llvm/llvm:latest

# Set the working directory inside the container
WORKDIR /llvm-project

# Copy the build artifacts from the host to the container
COPY . .

# Example command to run LLVM (this will vary based on your use case)
CMD ["clang", "--version"]
