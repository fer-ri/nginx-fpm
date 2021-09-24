# Docker Nginx + PHP FPM

Nginx and PHP FPM service in one image, based on Alpine and S6 Overlay.

## Usage

```bash
docker run --rm -it -v ~/my/workspace:/var/www/public -p 80:8080 ferri/nginx-fpm:8.0
```

For laravel or another framework that serve from `public` subfolder, then you just mount to `/var/www`

```bash
docker run --rm -it -v ~/my/laravel-project:/var/www -p 80:8080 ferri/nginx-fpm:8.0
```

## Tags

| Tag | Alpine      | Image Tag           |
| --- | ----------- | ------------------- |
| 7.4 | alpine:3.14 | ferri/nginx-fpm:7.4 |
| 8.0 | alpine:3.14 | ferri/nginx-fpm:8.0 |

## PHP Packages

These packages already included inside the image

- fpm
- bcmath
- ctype
- fileinfo
- json
- mbstring
- openssl
- pdo_mysql
- tokenizer
- xml
- session
- curl

## Production

For production, consider to extend this image and adding `php-opcache` and enable the setting `opcache.*` from `00-docker.ini`

```Dockerfile
FROM ferri/nginx-fpm:8.0

RUN apk add --no-cache php8-opcache

# Copy the newer setting that enabled opcache
COPY files/php8 /
```
