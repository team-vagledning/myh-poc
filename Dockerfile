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

RUN touch /var/run/nginx.pid
RUN chown -R 1001:0 /var/run/nginx.pid && chmod -R g+rwX /var/run/nginx.pid

## Make a copy of default configuration file and change listen port to 8080
RUN cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.orig && \
    sed -i 's/listen[[:space:]]*80;/listen 8080;/g' /etc/nginx/conf.d/default.conf

USER 1001

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]