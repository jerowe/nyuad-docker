### NYUAD CGSB base of bioconda builder image
### This is simply a copy of the condaforge/linux-anvil image, but with some images precached to speed up building

FROM quay.io/condaforge/linux-anvil:latest

RUN . /opt/docker/bin/entrypoint_source
RUN . scl_source enable devtoolset-2

ENV PATH=/opt/conda/bin:$PATH

#Subscripe to channels
RUN conda config --add channels conda-forge
RUN conda config --add channels defaults
RUN conda config --add channels r
RUN conda config --add channels bioconda
RUN conda config --set always_yes True

#Lets install some base conda packages
RUN conda install  conda
RUN conda install -y openssl zlib perl-app-cpanminus perl-termreadkey perl-dbi r r-base r-essentials java-jdk
RUN conda install -y anaconda-client conda-build
RUN conda install -y python=3
RUN conda install -y click

#Install bioconda Utils
RUN pip install git+https://github.com/bioconda/conda-build.git@fix-build-skip-existing
RUN pip install git+https://github.com/bioconda/bioconda-utils.git
