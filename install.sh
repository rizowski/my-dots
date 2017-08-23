source ./scripts/helpers.sh

echo "installing brew"
./scripts/brew.sh

echo "installing personal files"
./scripts/personal-settings.sh

echo "installing zsh"
./scripts/zsh.sh

echo "installing mac settings"
./scripts/mac-settings.sh

echo "installing nvm"
./scripts/nvm.sh

echo "setting up npm"
./scripts/npm.sh
