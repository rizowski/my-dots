case $(uname) in
Darwin)
  export PATH=$PATH:$HOME/.cargo/bin
  export ONEPASS_SSH_AGENT_PATH="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
  # Added by OrbStack: command-line tools and integration
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
  export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
  export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
  export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
  ;;
Linux)
  export ONEPASS_SSH_AGENT_PATH="$HOME/.1password/agent.sock"
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
. "$HOME/.cargo/env"
