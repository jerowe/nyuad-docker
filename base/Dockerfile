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

# Update
RUN yum update -y && yum upgrade -y &&  yum -y clean all
RUN yum install -y wget curl glibc-devel

# Install miniconda
RUN mkdir -p /tmp/conda-build &&  wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh  -b -p /opt/anaconda3
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
env PATH=/opt/anaconda3/bin:$PATH

# Subscripe to channels
RUN conda config --add channels bioconda
RUN conda config --add channels r

# Do some base installs
RUN conda install -y gcc perl-app-cpanminus perl-termreadkey r r-base r-essentials java-jdk
RUN cpanm --quiet Task::Moose MooseX::Getopt::Usage::Role::Man
RUN cpanm --quiet HPC::Runner HPC::Runner::Scheduler
RUN cpanm --quiet HPC::Runner::Slurm HPC::Runner::PBS
RUN cpanm --quiet HPC::Runner::MCE
RUN cpanm --quiet BioX::Workflow
#RUN cpanm --notest --quiet --skip-satisfied Dist::Milla

# Now lets install Easybuild!
RUN mkdir -p /opt/easybuild
RUN yum install -y environment-modules curl
ENV EASYBUILD_PREFIX=/opt/easybuild
RUN curl -O https://raw.githubusercontent.com/hpcugent/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py
RUN python bootstrap_eb.py $EASYBUILD_PREFIX
RUN module use $EASYBUILD_PREFIX/modules/all
RUN module load EasyBuild

# I don't know what this is for
EXPOSE 10389 22
