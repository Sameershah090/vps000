# Use the GitHub Codespaces base image
FROM mcr.microsoft.com/vscode/devcontainers/base:0-buster

# Install OpenSSH server
RUN apt-get update && apt-get install -y openssh-server sudo

# Create the SSH directory
RUN mkdir /var/run/sshd

# Set the password for the root user or another user (use with caution)
RUN echo 'root:password' | chpasswd

# Enable SSH
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose the SSH port
EXPOSE 22

# Start the SSH service
CMD ["/usr/sbin/sshd", "-D"]
