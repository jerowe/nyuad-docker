# README

These are the docker images used in NYUAD's analysis.

Build any of the images with docker build .

# Run the slurm image

## With Mounting
docker run --rm -it -v `pwd`:/data:Z -h docker.example.com -p 10022:22 --name slurm --entrypoint /bin/bash jerowe/nyuad-cgsb-slurm 

## Without Mounting
docker run --rm -it -h docker.example.com -p 10022:22 --name slurm --entrypoint /bin/bash jerowe/nyuad-cgsb-slurm

/usr/sbin/munged
/usr/sbin/slurmctld
/usr/sbin/slurmd start

cd /home/testuser
sbatch slurm.submit
