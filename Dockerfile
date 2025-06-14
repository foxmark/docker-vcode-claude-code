FROM node:lts

# Install VS Code Server
# RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN mkdir /workspace
WORKDIR /workspace

RUN npm install -g @anthropic-ai/claude-code

# Set up VS Code extensions directory
# RUN mkdir -p /home/developer/.local/share/code-server/extensions


# Setup basic Claude Code directory
# RUN mkdir -p /home/developer/.claudecode

# Install VS Code extensions
# RUN code-server --install-extension ecmel.vscode-html-css  && \
#    code-server --install-extension esbenp.prettier-vscode && \
#    code-server --install-extension ms-azuretools.vscode-containers && \
#    code-server --install-extension devsense.composer-php-vscode && \
##    code-server --install-extension xdebug.php-debug && \
#    code-server --install-extension bmewburn.vscode-intelephense-client && \
#    code-server --install-extension zobo.php-intellisense && \
#    code-server --install-extension redhat.vscode-xml

# Expose VS Code Server port
# EXPOSE 8080 3000 8000

# Start VS Code Server
# CMD ["code-server", "--bind-addr", "0.0.0.0:8000", "--auth", "none", "/workspace"]
