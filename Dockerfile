# build stage
FROM mhart/alpine-node:latest as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

RUN chown -R 1001:0 /usr/share/nginx && chmod -R g+rwX /usr/share/nginx
RUN chown -R 1001:0 /var/cache/nginx && chmod -R g+rwX /var/cache/nginx

USER 1001

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]