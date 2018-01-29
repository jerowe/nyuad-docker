FROM continuumio/miniconda3

apt-get install -y  build-essential

conda config --set always_yes yes --set changeps1 no
conda config --add channels r
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --add channels nyuad-cgsb

mkdir -p $HOME/anaconda3/conda-bld

conda update --all -y

##These are all added to the travis cache

conda install python=3.5
conda install -y conda conda-build anaconda-client pip setuptools
conda install -y r-base r-essentials nodejs r-ggplot2
conda install -y gnuplot samtools bamtools bcftools freebayes gatk
conda install -y openjdk perl bioconductor-biobase blast bedtools
npm install -g marked-man

pip uninstall gencore_app || echo "Gencore app is not installed"
pip install git+https://github.com/nyuad-cgsb/gencore_app.git@master
