for a in $(find $HOME/.site ! -type d | grep -v '.gitignore' | sort); do
  source $a
done

for a in $(find $HOME/.bash/profile.d ! -type d | sort); do
  source $a
done

if [[ -d "$HOME/.pancake" ]]; then
  _old_cwd=$(pwd)

  export PANCAKE_ROOT="$HOME/.pancake"
  cd $PANCAKE_ROOT
  source $PANCAKE_ROOT/bin/profile

  cd $_old_cwd
fi

