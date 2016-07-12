# README

These are the docker images used in NYUAD's analysis.

Build any of the images with docker build .

# Run the slurm image

## To Mount Volumes
docker run --rm -i -t -v /home/jillian/projects/nyuad-docker-data/resequencing:/data:Z -h docker.example.com -p 10022:22 nyuad-docker/slurm /bin/bash

## Without Mounting
docker run --rm -i -t -h docker.example.com -p 10022:22 nyuad-docker/slurm /bin/bash

#docker run -it -h docker.example.com -p 10022:22 --name slurm jerowe/nyuad-cgsb-slurm /bin/bash

/etc/sbin/munge
/usr/sbin/slurmctld
/usr/sbin/slurmd start

cd /home/testuser
sbatch slurm.submit
