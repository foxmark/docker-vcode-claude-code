# Use Node.js v20 (required by code-server)
FROM node:20.10.0-alpine

# Install security updates and required packages
RUN apk update && apk upgrade && \
    apk add --no-cache curl bash sudo

# Create non-root user
RUN addgroup -g 1001 -S developer && \
    adduser -S developer -u 1001 -G developer

# Set up npm global directory for non-root user
RUN mkdir -p /home/developer/.npm-global && \
    chown -R developer:developer /home/developer/.npm-global

# Install code-server globally as root (required for system-wide access)
RUN npm install -g code-server@4.100.3 --unsafe-perm

# Switch to non-root user and configure npm for user packages
USER developer
ENV NPM_CONFIG_PREFIX=/home/developer/.npm-global
ENV PATH=$PATH:/home/developer/.npm-global/bin

# Install Claude Code as non-root user
RUN npm install -g @anthropic-ai/claude-code

# Install extensions as non-root user
RUN code-server --install-extension ecmel.vscode-html-css && \
    code-server --install-extension esbenp.prettier-vscode && \
    code-server --install-extension ms-azuretools.vscode-containers && \
    code-server --install-extension devsense.composer-php-vscode && \
    code-server --install-extension xdebug.php-debug && \
    code-server --install-extension bmewburn.vscode-intelephense-client && \
    code-server --install-extension zobo.php-intellisense && \
    code-server --install-extension redhat.vscode-xml

# Create workspace with proper permissions
RUN mkdir -p /home/developer/workspace
WORKDIR /home/developer/workspace

# Only expose necessary port
EXPOSE 8000

# Set environment variables for security
# ENV PASSWORD=changeme123!
ENV SHELL=/bin/bash

# Run as non-root user with authentication
CMD ["code-server", "--bind-addr", "0.0.0.0:8000", "--auth", "password", "/home/developer/workspace"]