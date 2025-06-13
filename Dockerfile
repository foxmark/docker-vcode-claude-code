FROM node:lts

# Install VS Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN mkdir /workspace
WORKDIR /workspace

# Expose VS Code Server port
EXPOSE 8000

# Start VS Code Server
CMD ["code-server", "--bind-addr", "0.0.0.0:8000", "--auth", "none", "/workspace"]
