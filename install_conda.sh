#/bin/bash

# nohup install_conda.sh > /dev/null 2>&1 &

export CONDA_DIR="${HOME}/.miniconda3"

mkdir -p ~/tmp && cd ~/tmp
rm -fr $CONDA_DIR && mkdir -p $CONDA_DIR

wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

/bin/bash Miniconda3-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR
$CONDA_DIR/bin/conda config --system --add channels conda-forge
$CONDA_DIR/bin/conda config --system --set auto_update_conda false

echo "export PATH=$CONDA_DIR/bin/:\$PATH" >> ~/.bash_profile
source .bash_profile
# conda update conda

# conda env update -n myenv --file ENV.yml
