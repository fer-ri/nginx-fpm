REPOSITORY=ferri/nginx-fpm
TAG=UNDEF

build:
	if [ "$(TAG)" = "UNDEF" ]; then echo "Please provide a valid TAG" && exit 1; fi
	docker build -t $(REPOSITORY):$(TAG) -f Dockerfile-$(TAG) .

push:
	if [ "$(TAG)" = "UNDEF" ]; then echo "Please provide a valid TAG" && exit 1; fi
	docker push $(REPOSITORY):$(TAG)

start:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi
	docker run -d -p 8080:8080 --name ferri_nginx_fpm $(REPOSITORY):$(TAG)

test:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi
	docker ps | grep ferri_nginx_fpm | grep -q "(healthy)"
	docker exec -t ferri_nginx_fpm php-fpm --version | grep -q "PHP $(TAG)"
	wget -q localhost:8080 -O- | grep -q "PHP Version $(TAG)"

publish: build push