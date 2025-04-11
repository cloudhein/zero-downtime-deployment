FROM node:20-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

FROM node:20-alpine AS production

WORKDIR /usr/src/myapp

COPY --from=builder /usr/src/app/ /usr/src/myapp/

RUN addgroup -S reactgroup && adduser -S reactuser -G reactgroup

RUN chown -R reactuser:reactgroup /usr/src/myapp

USER reactuser

EXPOSE 80

CMD ["npm", "start", "&"]