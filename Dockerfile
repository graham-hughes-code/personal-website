# nginx state for serving content
FROM nginx:alpine
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html
# adding default conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
# Remove default nginx static assets
RUN rm -rf ./*
# Copy static assets over
COPY ./site ./
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
