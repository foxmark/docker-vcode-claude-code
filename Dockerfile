FROM alpine:3.19

# Install essential packages
RUN apk update && apk add --no-cache \
    bash \
    curl \
    wget \
    git \
    gnupg \
    ca-certificates \
    build-base \
    python3 \
    py3-pip \
    unzip \
    musl-locales \
    nodejs \ 
    npm

# Set up locales
# RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

# Install VS Code Server
# RUN curl -fsSL https://code-server.dev/install.sh | sh
COPY scripts/install-vscode.sh /tmp/install-vscode.sh
RUN bash /tmp/install-vscode.sh

# Install VS Code extensions
RUN code-server --install-extension ms-vscode.vscode-typescript-next && \
    code-server --install-extension dbaeumer.vscode-eslint && \
    code-server --install-extension esbenp.prettier-vscode && \
    code-server --install-extension bmewburn.vscode-intelephense-client && \
    code-server --install-extension ecmel.vscode-html-css && \
    code-server --install-extension xdebug.php-debug

# Expose ports for VS Code Server and other services
EXPOSE 8080 3000 8000

# Set environment variables
ENV PATH="/home/developer/.npm-global/bin:${PATH}"
ENV EDITOR=code-server

# Start VS Code Server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "."]
