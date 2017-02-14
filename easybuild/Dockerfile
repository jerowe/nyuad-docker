### NYUAD CGSB EasyBuild Docker Image 

FROM centos:6.6

# Set an encoding to make things work smoothly.
ENV LANG en_US.UTF-8

RUN yum install -y wget tar make bzip2 patch which

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

RUN echo "export PATH=/opt/conda/bin:$PATH" >> /home/ebuser/.bashrc
RUN conda config --set show_channel_urls True && \
    conda config --add channels conda-forge && \
    conda update --all --yes && \
    conda clean -tipy
