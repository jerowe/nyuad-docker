### NYUAD CGSB base of bioconda builder image
### This is simply a copy of the condaforge/linux-anvil image, but with some conda packages precached to speed up building

FROM bioconda/bioconda-utils:latest

ENV PATH=/opt/rh/devtoolset-2/root/usr/bin:$PATH
ENV PATH=/opt/conda/bin:$PATH

##Subscripe to channels
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
RUN pip install git+https://github.com/bioconda/bioconda-utils.git

RUN conda index /opt/conda/conda-bld/linux-64 /opt/conda/conda-bld/osx-64
RUN conda config --add channels file://conda/conda-bld

CMD [ "/bin/bash" ]
