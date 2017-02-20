### NYUAD CGSB EasyBuild Docker Image 

FROM centos:6.6

# Set an encoding to make things work smoothly.
ENV LANG en_US.UTF-8

RUN yum install -y git wget tar make bzip2 patch which

# Install the latest Miniconda with Python 3 and update everything.
RUN curl -s -L https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh  > miniconda.sh && \
    openssl md5 miniconda.sh | grep d0c7c71cc5659e54ab51f2005a8d96f3

RUN mkdir -p /opt/
RUN chmod 777 miniconda.sh ; bash miniconda.sh -b -p /opt/conda
RUN rm miniconda.sh && \
    export PATH=/opt/conda/bin:$PATH && \
    conda config --set show_channel_urls True && \
    conda config --add channels conda-forge && \
    conda update --all --yes && \
    conda clean -tipy

RUN useradd -ms /bin/bash ebuser

USER ebuser
WORKDIR /home/ebuser

ENV HOME=/home/ebuser
ENV PATH=/opt/conda/bin:$PATH
ENV EASYBUILD_PREFIX=$HOME/.eb
 
RUN conda config --set show_channel_urls True && \
    conda config --add channels nyuad-cgsb && \ 
    conda config --add channels conda-forge && \
    conda config --add channels defaults && \
    conda config --add channels r && \
    conda config --add channels bioconda && \
    conda config --set always_yes True && \
    conda config --set allow_softlinks False

RUN conda create -p /home/ebuser/.eb/eb--3.1.10_environment-modules--3.2.10 easybuild lmod 

RUN mkdir -p $HOME/.config/easybuild

# Here is how you add a file from the main repo
# RUN source activate /home/ebuser/.eb/eb--3.1.10_environment-modules--3.2.10 && \
#	eb --try-software-name Anaconda2 

RUN mkdir -p $HOME/.eb/custom_repos
WORKDIR $HOME/.eb/custom_repos 
RUN git clone https://github.com/nyuad-cgsb/nyuad-hpc-module-configs

ENV ROBOT=/home/ebuser/.eb/custom_repos/nyuad-hpc-modules-configs/_easybuild

ADD config.cfg $HOME/.config/easybuild/config.cfg

# There is also a way to use --robot-paths instead of adding it to the config file

RUN source activate /home/ebuser/.eb/eb--3.1.10_environment-modules--3.2.10 && \
	eb --dry-run  --robot  gencore_rnaseq-1.0.eb && \
        module list

ENTRYPOINT [ "source activate /home/ebuser/.eb/eb--3.1.10_environment-modules--3.2.10" ]
# Alternately, we could just load and source the modules ourselves
# ENV BASE="/home/ebuser/.eb/eb--3.1.10_environment-modules--3.2.10"
# ENV PATH=${BASE}/bin:$PATH
# RUN source ${BASE}/Modules/3.2.10/init/bash && eb --help

