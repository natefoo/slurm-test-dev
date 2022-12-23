UID	:= $(shell id -u)
GID	:= $(shell id -g)


up: .env context/munge.key cluster
	docker-compose build
	docker-compose up

up-d: .env context/munge.key cluster
	docker-compose build
	docker-compose up -d

down:
	docker-compose down

submit:
	docker-compose exec submit su - user

.env: .env.in
	sh ./.env.in

context/munge.key:
	mungekey -c -k context/munge.key -v

cluster:
	mkdir cluster

clean:
	docker-compose rm -sf
	docker rmi -f slurm-dev
	rm -f .env

.PHONY: clean up up-d down submit
