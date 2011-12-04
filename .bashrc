for a in $(find $HOME/.site ! -type d | grep -v '.gitignore' | sort); do
  source $a
done

for a in $(find $HOME/.bash/profile.d ! -type d | sort); do
  source $a
done

_old_cwd=$(pwd)

if [[ -d /opt/infra ]]; then
  export PANCAKE_ROOT="/opt/infra"
  source $PANCAKE_ROOT/bin/profile

  for p in xmonad data virt dev infra noop; do
    pancake $p
  done
fi

cd $_old_cwd
