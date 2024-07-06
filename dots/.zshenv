case $(uname) in
Darwin)
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
  # Added by OrbStack: command-line tools and integration
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
  export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
  export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
  ;;
Linux)
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export PATH="$HOMEBREW_PREFIX/.linuxbrew/bin:$PATH"
  export PATH="$HOMEBREW_PREFIX/.linuxbrew/sbin:$PATH"
  ;;
esac

test -e "${HOME}/.rover/env" && source "/Users/rizowski/.rover/env"

export PATH="$HOMEBREW_PREFIX/opt/openjdk@11/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/ruby@2.7/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
