FROM node:20-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

FROM node:20-alpine AS production

WORKDIR /usr/src/myapp

# COPY --from=builder /usr/src/app/ /usr/src/myapp/

RUN addgroup -S expressgroup && adduser -S expressuser -G expressgroup

COPY --from=builder --chown=expressuser:expressgroup /usr/src/app/ /usr/src/myapp/

# made via `RUN chown` forces a full copy of each file into a new layer which increases the image size #
# RUN chown -R expressuser:expressgroup /usr/src/myapp

USER expressuser

EXPOSE 3000

CMD ["node", "index.js"]
