source ./helpers.sh

if ! command_exists zsh ; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
fi
