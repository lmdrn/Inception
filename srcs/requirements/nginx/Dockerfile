# Dockerfile for nginx

FROM nginx:1.10.1-alpine
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
