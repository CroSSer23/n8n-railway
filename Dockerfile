FROM node:22-alpine
ARG N8N_VERSION=1.81.0
RUN apk add --no-cache graphicsmagick tzdata \
 && apk add --no-cache --virtual build-dependencies python3 build-base \
 && npm_config_user=root npm i -g n8n@${N8N_VERSION} \
 && apk del build-dependencies

# Install community nodes
RUN cd /usr/local/lib/node_modules/n8n \
 && npm install @devlikeapro/n8n-nodes-waha n8n-nodes-tallyforms

WORKDIR /data
ENV N8N_HOST=0.0.0.0
EXPOSE 8080
CMD ["sh", "-lc", "export N8N_PORT=${PORT:-8080} ; n8n start"]
