FROM condaforge:linux-anvil

#Subscripe to channels
RUN conda config --add channels bioconda
RUN conda config --add channels r
RUN conda config --set always_yes True

#Lets install some base conda packages
RUN conda install -c conda conda-env
RUN conda install -y gcc libgcc zlib perl-app-cpanminus perl-termreadkey perl-dbi r r-base r-essentials java-jdk blast hmmer
RUN conda install -y anaconda-client conda-build
RUN conda install -y discovar discovardenovo
RUN conda install -y samtools bcftools
RUN conda install -y perl-bioperl perl-bioperl-core perl-bioperl-run
RUN conda install -y perl-moose perl-hpc-runner perl-hpc-runner-scheduler perl-hpc-runner-mce perl-hpc-runner-slurm
RUN conda install -y perl-biox-workflow perl-biox-workflow-plugin-fileexists perl-biox-workflow-plugin-filedetails
RUN conda install -y soapdenovo2 soapdenovo2-prepare
RUN conda install -y openssl graphviz circos
RUN conda install -y python=3
RUN conda install -y click

#Install bioconda Utils
RUN pip install git+https://github.com/bioconda/bioconda-utils.git
RUN pip install git+https://github.com/bioconda/conda-build.git@fix-build-skip-existing
