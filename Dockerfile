FROM node:lts

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# USER node

# Install VS Code Server
RUN curl -fsSL https://code-server.dev/install.sh | sh

#RUN mkdir -p /home/developer/.local/share/code-server/extensions
#RUN mkdir -p /home/developer/.claudecode

# Install VS Code extensions
RUN code-server --install-extension ecmel.vscode-html-css && \
    code-server --install-extension esbenp.prettier-vscode && \
    code-server --install-extension ms-azuretools.vscode-containers && \
    code-server --install-extension devsense.composer-php-vscode && \
    code-server --install-extension xdebug.php-debug && \
    code-server --install-extension bmewburn.vscode-intelephense-client && \
    code-server --install-extension zobo.php-intellisense && \
    code-server --install-extension redhat.vscode-xml

RUN mkdir /workspace
WORKDIR /workspace

EXPOSE 8080 3000 8000

CMD ["code-server", "--bind-addr", "0.0.0.0:8000", "--auth", "none", "/workspace"]
