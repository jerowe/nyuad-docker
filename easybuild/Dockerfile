### NYUAD CGSB EasyBuild Docker Image 


##################################################################
## Base Image Setup 
##################################################################
FROM quay.io/condaforge/linux-anvil

ENV LANG en_US.UTF-8

RUN yum install -y git
RUN . /opt/docker/bin/entrypoint_source

##################################################################
## Anaconda Setup
## We are using miniconda3/python3 from anaconda
##################################################################
ENV ANACONDA3_BASE /opt/anaconda3 

RUN curl -s -L https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh  > miniconda.sh && \
    openssl md5 miniconda.sh | grep d0c7c71cc5659e54ab51f2005a8d96f3

RUN mkdir -p /opt/
RUN chmod 777 miniconda.sh ; bash miniconda.sh -b -p $ANACONDA3_BASE 
RUN rm miniconda.sh && \
    export PATH=${ANACONDA3_BASE}/bin:$PATH && \
    conda config --set show_channel_urls True && \
    conda config --add channels conda-forge && \
    conda config --add channels defaults && \
    conda update --all --yes && \
    conda install --yes anaconda-client nbformat && \
    conda clean -tipy

##################################################################
## EasyBuild User Setup 
##################################################################
RUN useradd -ms /bin/bash ebuser

USER ebuser
WORKDIR /home/ebuser

ENV HOME=/home/ebuser
ENV PATH=${ANACONDA3_BASE}/bin:$PATH
ENV EASYBUILD_PREFIX=$HOME/.eb
ENV EB_ENV=/home/ebuser/.eb/eb--3.1.10_lmod--7.3.16
ENV MODULEPATH=$EASYBUILD_PREFIX/modules/all

##################################################################
## Add Easybuild Config 
## For now the config doesn't have anything except some commented
## out sections for the modules-tool and modules-syntax 
##################################################################
RUN mkdir -p $HOME/.config/easybuild
ADD config.cfg $HOME/.config/easybuild/config.cfg
 
##################################################################
## Conda config for ebuser
## Setup the initial conda configuration for the ebuser 
##################################################################
RUN conda config --set show_channel_urls True && \
    conda config --add channels nyuad-cgsb && \ 
    conda config --add channels conda-forge && \
    conda config --add channels defaults && \
    conda config --add channels r && \
    conda config --add channels bioconda && \
    conda config --set always_yes True && \
    conda config --set allow_softlinks False


##################################################################
## Install Easybuild and Lmod
## Create a conda env with easybuild and lmod - and nothing else  
##################################################################
RUN conda create -p $EB_ENV easybuild lmod 

##################################################################
## Install an Easybuild Config 
## Anaconda2 is a Core EB config  
## --software-name is a way of telling EB to look for software 
## from the repos instead of supplying a .eb file 
##################################################################
RUN source activate $EB_ENV && \
	eb --software-name Anaconda2 

##################################################################
## Add NYUAD Easybuild Configs 
## These are custom configs outside of the Easybuild Main  
##################################################################
RUN mkdir -p $HOME/.eb/custom_repos
WORKDIR $HOME/.eb/custom_repos 
RUN git clone https://github.com/nyuad-cgsb/nyuad-hpc-module-configs

WORKDIR $HOME 

##################################################################
## Add NYUAD Easybuild Configs to the Robot Path 
## Robot will tell EB to automatically pull in deps
## Robot-path will tell EB where to look for configs  
##################################################################
ENV ROBOT $HOME/.eb/custom_repos/nyuad-hpc-module-configs/_easybuild
ENV EASYBUILD_ROBOT_PATHS $ROBOT: 

## Remove the --dry-run in order to actually install the module
RUN source activate $EB_ENV && \
	eb --dry-run  --robot --robot-paths=$ROBOT   gencore_rnaseq-1.0-0.eb

## Using --extended-dry-run will give you more information
RUN source activate $EB_ENV && \
	eb --extended-dry-run  --robot --robot-paths=$ROBOT  gencore_rnaseq-1.0-0.eb

RUN source activate $EB_ENV && \
	module avail

#RUN source activate $EB_ENV && \
#	eb  --robot --robot-paths=$ROBOT  gencore_rnaseq-1.0.eb && \
#        module avail
#
#ENTRYPOINT [ "source activate /home/ebuser/.eb/eb--3.1.10_lmod--7.3.16" ]

# Alternately, we could just load and source the modules ourselves
# ENV BASE="/home/ebuser/.eb/eb--3.1.10_lmod--7.3.16"
# ENV PATH=${BASE}/bin:$PATH
# RUN source ${BASE}/Modules/3.2.10/init/bash && eb --help

