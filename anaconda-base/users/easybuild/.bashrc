# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

case "$0" in
    -sh|sh|*/sh)  modules_shell=sh ;;
    -ksh|ksh|*/ksh)  modules_shell=ksh ;;
    -zsh|zsh|*/zsh)  modules_shell=zsh ;;
    -bash|bash|*/bash)  modules_shell=bash ;;
esac

module() { eval `/usr/bin/modulecmd $modules_shell $*`;  }

export PATH="/anaconda/bin:$PATH"
export EASYBUILD_PREFIX=/home/easybuild/.local/easybuild
module use $EASYBUILD_PREFIX/modules/all
module load EasyBuild

#export EASYBUILD_INCLUDE_EASYBLOCKS=/home/jillian/Dropbox/projects/python/jerowe-easybuild-easyblocks/easybuild/easyblocks/\*/\*.py
