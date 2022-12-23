ARG SLURM_IMAGE
FROM $SLURM_IMAGE

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y slurmdbd slurmctld slurmd slurm-client

COPY munge.key /etc/munge/munge.key
RUN chown munge:munge /etc/munge/munge.key
RUN chmod 0400 /etc/munge/munge.key

COPY slurm-docker-exec /usr/sbin/slurm-docker-exec
RUN chown root:root /usr/sbin/slurm-docker-exec
RUN chmod 0755 /usr/sbin/slurm-docker-exec

ARG UID GID
RUN groupadd -f -g $GID user
RUN useradd -u $UID -g $GID -s /bin/bash -m -d /home/user user

COPY slurmdbd.conf /etc/slurm/slurmdbd.conf
COPY slurm.conf /etc/slurm/slurm.conf
COPY cgroup.conf /etc/slurm/cgroup.conf
RUN chmod 0600 /etc/slurm/slurmdbd.conf
RUN chown slurm:slurm /etc/slurm/*

VOLUME /cluster

ENTRYPOINT /usr/sbin/slurm-docker-exec
