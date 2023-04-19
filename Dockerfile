FROM ubuntu:20.04

# Install nginx and other required packages
RUN apt-get update && \
    apt-get install -y nginx apache2-utils python3-passlib && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy nginx site.conf and set ownership and permissions
COPY nginx.conf /etc/nginx/nginx.conf
RUN chown root:root /etc/nginx/nginx.conf && \
    chmod 0644 /etc/nginx/nginx.conf

# Add a user to a password file
RUN htpasswd -b -c /etc/nginx/.htpasswd softServe 12345

# Reload nginx with new config
CMD ["nginx", "-g", "daemon off;"]

