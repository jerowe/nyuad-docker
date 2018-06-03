### NYUAD CGSB EasyBuild Docker Image

FROM continuumio/miniconda3
ENV LANG en_US.UTF-8

RUN apt-get update -y
RUN apt-get install -y  build-essential
RUN apt-get install lmod -y

RUN conda config --set always_yes yes --set changeps1 no
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda config --add channels r
RUN conda config --add channels nyuad-cgsb
RUN mkdir -p $HOME/anaconda3/conda-bld

RUN conda update -n base conda
RUN conda update --all -y

RUN conda install python=3
RUN conda install -y conda conda-build anaconda-client pip setuptools && conda clean --all -y
#RUN conda install -y gosu tini

RUN pip uninstall gencore_app || echo "Gencore app is not installed"
RUN pip install git+https://github.com/nyuad-cgsb/gencore_app.git@master

RUN echo "source /usr/share/lmod/lmod/init/bash" >> /etc/bash.bashrc
RUN echo "export PATH=/usr/share/lmod/lmod/libexec:$PATH" >> /etc/bash.bashrc

##################################################################
## EasyBuild User Setup
##################################################################
RUN useradd -ms /bin/bash ebuser

USER ebuser
WORKDIR /home/ebuser

RUN echo "source /usr/share/lmod/lmod/init/bash" >> /home/ebuser/.bashrc
RUN echo "export PATH=/usr/share/lmod/lmod/libexec:$PATH" >> /home/ebuser/.bashrc 

ENV PATH=/usr/share/lmod/lmod/libexec:$PATH
ENV HOME=/home/ebuser
ENV EASYBUILD_PREFIX=$HOME/.eb
ENV EB_ENV=/home/ebuser/.eb/eb--3.6.0
ENV MODULEPATH=$EASYBUILD_PREFIX/modules/all

RUN mkdir -p $EASYBUILD_PREFIX/modules/all

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
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda config --add channels nyuad-cgsb && \
    conda config --add channels defaults && \
    conda config --add channels r && \
    conda config --set always_yes True && \
    conda config --set allow_softlinks False


#################################################################
# Install Easybuild and Lmod
# Create a conda env with easybuild and lmod - and nothing else
# Used to use conda to bootstrap LMOD, but now the conda lmod
# package isn't working, so its installed with apt-get
#################################################################
#RUN conda create -p $EB_ENV easybuild=3.5.0 lmod=7.3.16 luarocks=2.4.2
RUN conda create -p $EB_ENV easybuild=3.6.0

##################################################################
## Install an Easybuild Config
## Anaconda2 is a Core EB config
## --software-name is a way of telling EB to look for software
## from the repos instead of supplying a .eb file
##################################################################
#RUN bash -c "source activate $EB_ENV && \
#	eb --software-name Anaconda2"

##################################################################
## Add NYUAD Easybuild Configs
## These are custom configs outside of the Easybuild Main
##################################################################

RUN mkdir -p $HOME/.eb/custom_repos
WORKDIR $HOME/.eb/custom_repos
RUN git clone https://github.com/nyuad-cgsb/nyuad-hpc-module-configs

WORKDIR $HOME

#################################################################
# Add NYUAD Easybuild Configs to the Robot Path
# Robot will tell EB to automatically pull in deps
# Robot-path will tell EB where to look for configs
#################################################################

ENV ROBOT $HOME/.eb/custom_repos/nyuad-hpc-module-configs/_easybuild
ENV EASYBUILD_ROBOT_PATHS $ROBOT:

# Remove the --dry-run in order to actually install the module
RUN bash -c "source activate $EB_ENV && \
	eb --dry-run  --robot --robot-paths=$ROBOT   gencore_rnaseq-1.1.eb"

## Using --extended-dry-run will give you more information
RUN bash -c "source activate $EB_ENV && \
	eb --extended-dry-run  --robot --robot-paths=$ROBOT  gencore_rnaseq-1.1.eb"

#RUN bash -c "source activate $EB_ENV && \
#	module avail"

#RUN bash -c "source activate $EB_ENV && \
#	eb --dry-run  --robot --robot-paths=$ROBOT   gencore_anaconda3-5.0.1.eb"

#RUN bash -c "source activate $EB_ENV && \
#	eb  --robot --robot-paths=$ROBOT  {{ name }}-{{ version }}.eb && \
#       module avail"

RUN  echo  "source activate $EB_ENV" >> ~/.bashrc

#RUN bash -c "source activate $EB_ENV && \
#	eb  --robot --robot-paths=$ROBOT  gencore_rnaseq-1.1.eb && \
#        module avail"

WORKDIR /home/ebuser 
