### NYUAD CGSB base of bioconda builder image
### This is simply a copy of the condaforge/linux-anvil image, but with some images precached to speed up building

FROM quay.io/condaforge/linux-anvil:latest

ENV PATH=/opt/conda/bin:$PATH

#Subscripe to channels
RUN conda config --add channels conda-forge
RUN conda config --add channels defaults
RUN conda config --add channels r
RUN conda config --add channels bioconda
RUN conda config --set always_yes True

#Lets install some base conda packages
RUN conda install  conda
RUN conda install -y gcc libgcc zlib perl-app-cpanminus perl-termreadkey perl-dbi r r-base r-essentials java-jdk blast hmmer
RUN conda install -y anaconda-client conda-build
RUN conda install -y samtools bcftools
RUN conda install -y perl-bioperl perl-bioperl-core perl-bioperl-run
RUN conda install -y perl-moose perl-hpc-runner perl-hpc-runner-scheduler perl-hpc-runner-mce perl-hpc-runner-slurm
RUN conda install -y perl-biox-workflow perl-biox-workflow-plugin-fileexists perl-biox-workflow-plugin-filedetails
RUN conda install -y soapdenovo2 soapdenovo2-prepare
RUN conda install -y openssl graphviz circos
RUN conda install -y python=3
RUN conda install -y click

#Install bioconda Utils
RUN pip install git+https://github.com/bioconda/conda-build.git@fix-build-skip-existing
RUN pip install git+https://github.com/bioconda/bioconda-utils.git
