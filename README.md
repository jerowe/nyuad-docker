# README

These are the docker images used in NYUAD's analysis.

Build any of the images with docker build .

# Run the slurm image

docker run --rm -i -t -v /home/jillian/projects/nyuad-docker-data/resequencing:/data:Z -h docker.example.com -p 10022:22 nyuad-docker/slurm /bin/bash
#docker run -it -h docker.example.com -p 10022:22 --name slurm jerowe/nyuad-cgsb-slurm /bin/bash
/etc/init.d/munge start
/usr/bin/supervisord &

cd /home/testuser
sbatch slurm.submit
