UID	:= $(shell id -u)
GID	:= $(shell id -g)


up: .env context/munge.key cluster slurm.conf.d
	docker-compose build
	docker-compose up

up-d: .env context/munge.key cluster slurm.conf.d
	docker-compose build
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose restart slurmdbd slurmctld slurmd submit

submit:
	docker-compose exec submit su - user

.env: .env.in
	sh ./.env.in

context/munge.key:
	mungekey -c -k context/munge.key -v

cluster:
	mkdir cluster

slurm.conf.d:
	mkdir slurm.conf.d

clean:
	docker-compose rm -sf
	docker rmi -f slurm-dev
	rm -f .env

.PHONY: clean up up-d down submit
