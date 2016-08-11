FROM centos:centos6

##Begin Agave

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

RUN yum install -y openssh-server openssh-clients which python-pip
RUN mkdir -p /var/run/sshd && \
    echo "root:root" | chpasswd

RUN adduser "testuser" -m && \
    echo "testuser:testuser" | chpasswd
USER testuser
RUN mkdir /home/testuser/.ssh
ADD id_rsa.pub /home/testuser/.ssh/authorized_keys

USER root

RUN service sshd start
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

RUN /bin/date

#Update
RUN yum update -y && yum upgrade -y &&  yum -y clean all
RUN yum install -y wget curl glibc-devel

#Install miniconda
RUN mkdir -p /tmp/conda-build &&  wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh  -b -p /anaconda
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
env PATH=/anaconda/bin:$PATH

#Subscripe to channels
RUN conda config --add channels bioconda
RUN conda config --add channels r

RUN conda install -y gcc perl-app-cpanminus perl-termreadkey r r-base r-essentials java-jdk
RUN cpanm MooseX::Getopt::Usage::Role::Man
RUN cpanm HPC::Runner HPC::Runner::Scheduler
RUN cpanm HPC::Runner::Slurm HPC::Runner::PBS
RUN cpanm HPC::Runner::MCE
RUN cpanm BioX::Workflow
RUN cpanm --notest Dist::Milla

EXPOSE 10389 22
