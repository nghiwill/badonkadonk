for a in $(find $HOME/.site ! -type d | grep -v '.gitignore' | sort); do
  source $a
done

for a in $(find $HOME/.bash/profile.d ! -type d | sort); do
  source $a
done

