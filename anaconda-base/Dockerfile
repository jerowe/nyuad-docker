FROM centos:centos6

##TODO make this from centos base image
RUN yum update -y && yum upgrade -y
RUN yum install -y openssl-devel openssh openssh-devel openssh-client python-pip environment-modules vim curl wget glibc-devel
RUN yum -y clean all

#Install miniconda
RUN mkdir -p /tmp/conda-build && wget  http://repo.continuum.io/miniconda/Miniconda3-4.0.5-Linux-x86_64.sh
RUN bash Miniconda3-4.0.5-Linux-x86_64.sh -b -p /anaconda
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
env PATH=/anaconda/bin:$PATH

#Subscripe to channels
RUN conda config --add channels bioconda
RUN conda config --add channels r

#Lets install some base conda packages
RUN conda install -c conda conda-env
RUN conda install -y gcc libgcc zlib perl-app-cpanminus perl-termreadkey perl-dbi r r-base r-essentials java-jdk blast hmmer
RUN conda install -y anaconda-client conda-build
RUN conda install -y discovar discovardenovo
RUN conda install -y samtools bcftools
RUN conda install -y perl-bioperl perl-bioperl-core perl-bioperl-run
RUN conda install -y openssl graphviz circos
RUN conda install -y python=3
