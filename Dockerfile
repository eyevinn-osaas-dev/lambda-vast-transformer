FROM node:18-alpine3.18
RUN apk add python3 make g++ wget
ENV NODE_ENV=production
ENV PORT=8080
RUN mkdir /app
RUN chown node:node /app
RUN npm install -g npm@10.4.0
WORKDIR /app
USER node
COPY --chown=node:node ["./", "./"]
RUN NODE_ENV="" npm ci || npm install --include=dev --production=false
RUN npm run build
CMD ["node", "dev.server.js"]
