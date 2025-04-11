FROM node:20-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

FROM node:20-alpine AS production

WORKDIR /usr/src/myapp

COPY --from=builder /usr/src/app/ /usr/src/myapp/

RUN addgroup -S expressgroup && adduser -S expressuser -G expressgroup

RUN chown -R expressuser:expressgroup /usr/src/myapp

USER expressuser

EXPOSE 3000

CMD ["node", "index.js"]
