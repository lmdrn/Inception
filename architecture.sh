#!/bin/bash

# Define project root directory
PROJECT_ROOT="."

# Create main directories and subdirectories
mkdir -p $PROJECT_ROOT/{secrets,srcs,srcs/requirements/{mariadb,nginx,wordpress,bonus,tools}}
mkdir -p $PROJECT_ROOT/srcs/requirements/mariadb/{conf,tools}
mkdir -p $PROJECT_ROOT/srcs/requirements/nginx/{conf,tools}
mkdir -p $PROJECT_ROOT/srcs/requirements/wordpress/{conf,tools}

# Create Docker-related files with placeholders
touch $PROJECT_ROOT/Makefile
echo "# Makefile for building Docker containers" > $PROJECT_ROOT/Makefile

# Populate the secrets directory with placeholder files
touch $PROJECT_ROOT/secrets/{credentials.txt,db_password.txt,db_root_password.txt}
echo "Your credentials will go here." > $PROJECT_ROOT/secrets/credentials.txt
echo "Your DB password here." > $PROJECT_ROOT/secrets/db_password.txt
echo "Your DB root password here." > $PROJECT_ROOT/secrets/db_root_password.txt

# Create docker-compose.yml with a basic structure
cat <<EOL > $PROJECT_ROOT/srcs/docker-compose.yml
version: '3.3'

services:
  db:
    build:
      context: ./requirements/mariadb
    environment:
      MYSQL_USER: \${MYSQL_USER}
      MYSQL_PASSWORD: \${MYSQL_PASSWORD}
      MYSQL_DATABASE: \${MYSQL_DATABASE}
      MYSQL_ROOT_PASSWORD: \${MYSQL_ROOT_PASSWORD}
    volumes:
      - db_data:/var/lib/mysql

  wordpress:
    build:
      context: ./requirements/wordpress
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: \${MYSQL_USER}
      WORDPRESS_DB_PASSWORD: \${MYSQL_PASSWORD}
      WORDPRESS_DB_NAME: \${MYSQL_DATABASE}
    volumes:
      - wordpress_data:/var/www/html
    ports:
      - "8080:80"

  nginx:
    build:
      context: ./requirements/nginx
    ports:
      - "443:443"

volumes:
  db_data: {}
  wordpress_data: {}

EOL

# Create .env file with placeholders
cat <<EOL > $PROJECT_ROOT/srcs/.env
# Environment variables for docker-compose

DOMAIN_NAME=wil.42.fr

# MySQL setup
MYSQL_USER=your_user
MYSQL_PASSWORD=your_password
MYSQL_DATABASE=wordpress
MYSQL_ROOT_PASSWORD=your_root_password

EOL

# Dockerfiles for each service with basic content
for service in mariadb nginx wordpress; do
  cat <<EOL > $PROJECT_ROOT/srcs/requirements/$service/Dockerfile
# Dockerfile for $service

# Use Alpine as a base image
FROM alpine:latest

# Install necessary packages (placeholder)
RUN apk update && apk add --no-cache some-package

# Placeholder for service-specific configurations
COPY conf /etc/$service

# Entrypoint and/or CMD (replace as needed)
CMD ["your_command"]
EOL
done

# Create .dockerignore files with basic content for each service
for service in mariadb nginx wordpress; do
  cat <<EOL > $PROJECT_ROOT/srcs/requirements/$service/.dockerignore
# Ignore temporary files and secrets
*.tmp
*.log
secrets/
EOL
done

# Print structure for verification
echo "Project structure created under $PROJECT_ROOT:"
ls -R "$PROJECT_ROOT"

