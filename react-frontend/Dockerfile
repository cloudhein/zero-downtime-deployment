FROM node:20-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm ci --omit=dev 

COPY . .

FROM node:20-alpine AS production

WORKDIR /usr/src/myapp

# COPY --from=builder /usr/src/app/ /usr/src/myapp/

RUN addgroup reactgroup && adduser -D reactuser -G reactgroup 

# made via `RUN chown` forces a full copy of each file into a new layer which increases the image size #
# RUN chown -R expressuser:expressgroup /usr/src/myapp 

COPY --from=builder --chown=reactuser:reactgroup /usr/src/app/ /usr/src/myapp/

USER reactuser

EXPOSE 80

CMD ["npm", "start", "&"]