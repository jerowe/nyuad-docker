
FROM centos:6.6

ENV LANG en_US.UTF-8

RUN yum install -y git wget tar make bzip2 patch which

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
    conda clean -tipy

#TODO make this base anaconda image

#Lets install some base conda packages
RUN conda install -y gcc libgcc zlib perl-app-cpanminus perl-termreadkey perl-dbi
RUN conda install -y anaconda-client conda-build conda
RUN conda install -y perl-moosex-app perl-moose
RUN conda install -y perl-biox-workflow perl-biox-workflow-plugin-fileexists perl-biox-workflow-plugin-filedetails

