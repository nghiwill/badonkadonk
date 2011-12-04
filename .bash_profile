source $HOME/.bashrc
source $HOME/.rvm/scripts/rvm

if [[ -z $NOTTY ]] && tty >/dev/null; then
  for a in $(find $HOME/.cue ! -type d -name '_*' | sort); do
    source $a
  done
fi
