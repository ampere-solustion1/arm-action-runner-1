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
