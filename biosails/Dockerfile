
#FROM centos:7
FROM continuumio/miniconda3

ENV LANG en_US.UTF-8

#RUN yum update -y && yum upgrade -y
#RUN yum install -y gcc git curl wget tar make bzip2 patch which glibc-devel
#RUN yum -y clean all

##################################################################
## Anaconda Setup
## We are using miniconda3/python3 from anaconda
##################################################################
#ENV ANACONDA3_BASE /opt/anaconda3

#RUN yum install -y openssl

#RUN curl -s -L https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh  > miniconda.sh && \
#    openssl md5 miniconda.sh | grep d0c7c71cc5659e54ab51f2005a8d96f3


#RUN mkdir -p /opt/
#RUN chmod 777 miniconda.sh ; bash miniconda.sh -b -p $ANACONDA3_BASE && rm miniconda.sh

#ENV PATH ${ANACONDA3_BASE}/bin:$PATH

RUN conda config --set show_channel_urls True && \
    conda config --add channels defaults && \
    conda config --add channels r && \
    conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda update --all --yes && \
    conda clean -tipy

#TODO make this base anaconda image

#Lets install some base conda packages

#RUN yum install -y gcc

#RUN conda install -y libgcc zlib perl-app-cpanminus perl-termreadkey perl-dbi
#RUN conda install -y anaconda-client conda-build conda
#RUN conda install -y perl-moosex-app perl-moose
RUN apt-get update -y
RUN apt-get install -y build-essential
RUN conda install -y perl-app-cpanminus perl-biox-workflow-command

WORKDIR /tmp

RUN cpanm --notest Log::Dispatch Clone File::Find::Rule

#RUN wget https://github.com/jerowe/BioX-Workflow-Command/archive/v2.0.1-beta.tar.gz && \
#	tar -xvf v2.0.1-beta.tar.gz && \
#	cd BioX-Workflow-Command-2.0.1-beta  && \
#	cpanm --force --notest  --installdeps . && \
#	perl ./Build.PL       && \
#	perl ./Build          && \
#	perl ./Build test     && \
#	perl ./Build install --installdirs site

WORKDIR /tmp

ENV RELEASE '0.0.6-beta'
#RUN wget https://github.com/jerowe/BioX-Workflow-Command-REST/archive/v${RELEASE}.tar.gz && \
	#tar -xvf v${RELEASE}.tar.gz && \
	#cd  BioX-Workflow-Command-REST-${RELEASE} && \
RUN cpanm Devel::StackTrace
RUN git clone https://github.com/jerowe/BioX-Workflow-Command-REST && \
	cd BioX-Workflow-Command-REST && \
	git checkout release/1.0 && \
	cpanm --force --notest  --installdeps . && \
	perl ./Build.PL       && \
	perl ./Build          && \
	perl ./Build test     && \
	perl ./Build install --installdirs site


WORKDIR /tmp

RUN cpanm --notest Plack::Handler::Starman

CMD plackup -E deployment -s Starman -p 3001 -r -R $(pwd)/lib -a BioX-Workflow-Command-REST-${RELEASE}/script/biox-app.psgi

#RUN curl -X POST  -d @rest-test-data-new.json http://localhost:3001/api/run --header "Content-Type: application/json"
