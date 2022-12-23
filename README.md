# slurm-test-dev

## Overview

A [Docker Compose][docker-compose]-based solution for easing the testing of [Slurm][slurm] configs.

## Usage

You must have [Docker][get-docker] and [Docker Compose][docker-compose] installed.

To start, run:

```console
$ make up
```

This does a bit of one-time preparation:

- Creating the Docker Compose `.env` file
- Creating a munge key at `context/munge.key`
- Creating a pseudo-shared filesystem in the `cluster` subdirectory, mounted at `/cluster` in the containers.
- Create the `slurm.conf.d` subdirectory for your modified configs.

After which, it runs `docker-compose up`. As is normal with foreground Docker Compose sessions, hit `Ctrl-C` to
terminate. To start daemonized, run:

```console
$ make up-d
```

And to stop:

```console
$ make down
```

Once the one-time setup has been performed, you can forego the Makefile and run `docker-compose` commands directly, if
you prefer.

To reset to the initial state, run:

```console
$ make clean
```

This removes `.env` and the munge key, but does not remove the `cluster` directory. It also removes the Docker containers and images.

To change the Slurm configuration, copy the relevant config (e.g. `slurm.conf` from `context/` to `slurm.conf.d`, make
your changes, and then run:

```console
$ make restart
```

To submit jobs:

```console
$ cat > cluster/slurm.sh <<EOF
#!/bin/sh
uname -a
EOF
$ make submit
user@submit:~$ cd /cluster
user@submit:/cluster$ sbatch slurm.sh
Submitted batch job 1
user@submit:/cluster$ cat slurm-1.out
Linux slurmd 5.10.0-8-amd64 #1 SMP Debian 5.10.46-4 (2021-08-03) x86_64 x86_64 x86_64 GNU/Linux
user@submit:/cluster$ ^D
logout
$
```

[slurm]: https://slurm.schedmd.com/
[get-docker]: https://docs.docker.com/get-docker/
[docker-compose]: https://docs.docker.com/compose/
