#!/bin/sh

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

append_to_bashrc() {
  local text="$1" bashrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.bashrc.local" ]; then
    bashrc="$HOME/.bashrc.local"
  else
    bashrc="$HOME/.bashrc"
  fi

  if ! grep -Fqs "$text" "$bashrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$bashrc"
    else
      printf "\n%s\n" "$text" >> "$bashrc"
    fi
  fi
}

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

if [ ! -f "$HOME/.bashrc" ]; then
  touch "$HOME/.bashrc"
fi

# shellcheck disable=SC2016
append_to_bashrc 'export PATH="$HOME/.bin:$PATH"'

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    sudo chown -R "$LOGNAME:admin" /usr/local
  fi
else
  sudo mkdir "$HOMEBREW_PREFIX"
  sudo chflags norestricted "$HOMEBREW_PREFIX"
  sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
    rbenv rehash
  fi
}

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    append_to_bashrc '# recommended by brew doctor'

    # shellcheck disable=SC2016
    append_to_bashrc 'export PATH="/usr/local/bin:$PATH"' 1

    export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew update
brew bundle --file=- <<EOF
tap "thoughtbot/formulae"
tap "homebrew/services"
tap "universal-ctags/universal-ctags"
tap "caskroom/cask"

# Unix
brew "ack"
brew "awscli"
brew "bash"
brew "bash-completion"
brew "bash-git-prompt"
brew "binutils"
brew "cmake"
brew "coreutils"
brew "diffutils"
brew "fd"
brew "findutils", args: ["with-default-names"]
brew "fswatch"
brew "fzf"
brew "gawk"
brew "git"
brew "git-cola"
brew "gnu-indent", args: ["with-default-names"]
brew "gnu-sed", args: ["with-default-names"]
brew "gnu-tar", args: ["with-default-names"]
brew "gnu-which", args: ["with-default-names"]
brew "grep", args: ["with-default-names"]
brew "htop"
brew "hub"
brew "iftop"
brew "imagemagick"
brew "ipcalc"
brew "jq"
brew "libyaml"
brew "make"
brew "mosh"
brew "mysql"
brew "mplayer"
brew "mtr"
brew "nethogs"
brew "nmap"
brew "openssh"
brew "openssl"
brew "pssh"
brew "pwgen"
brew "python3"
brew "rbenv"
brew "rcm"
brew "reattach-to-user-namespace"
brew "rsync"
brew "screen"
brew "socat"
brew "ssh-copy-id"
brew "the_silver_searcher"
brew "terminal-notifier"
brew "tig"
brew "tmux"
brew "universal-ctags", args: ["HEAD"]
brew "vagrant-completion"
brew "vim", args: ["with-lua"]
brew "watch"
brew "watchman"
brew "wget"
brew "wireshark"
brew "yarn"

# Applications
cask "adium"
cask "avidemux"
cask "caffeine"
cask "cyberduck"
cask "docker"
cask "emacs"
cask "gimp"
cask "google-chrome"
cask "gpg-suite"
cask "haroopad"
cask "hipchat"
cask "iterm2"
cask "libreoffice"
cask "lisanet-gimp"
cask "yujitach-menumeters"
cask "simplenote"
cask "skype"
cask "slack"
cask "spotify"
cask "thunderbird"
cask "vagrant"
cask "vanilla"
cask "viber"
cask "virtualbox"
cask "vlc"
cask "vox"
cask "xquartz"

# Testing
brew "qt@5.5" if MacOS::Xcode.installed?

EOF

fancy_echo "Configuring Ruby ..."
find_latest_ruby() {
  rbenv install -l | grep -v - | tail -1 | sed -e 's/^ *//'
}

ruby_version="$(find_latest_ruby)"
# shellcheck disable=SC2016
append_to_bashrc 'eval "$(rbenv init - --no-rehash)"' 1
eval "$(rbenv init -)"

if ! rbenv versions | grep -Fq "$ruby_version"; then
  RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/local/opt/openssl rbenv install -s "$ruby_version"
fi

rbenv global "$ruby_version"
rbenv shell "$ruby_version"
gem update --system
gem_install_or_update 'bundler'
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))

if [ -f "$HOME/.laptop.local" ]; then
  fancy_echo "Running your customizations from ~/.laptop.local ..."
  # shellcheck disable=SC1090
  . "$HOME/.laptop.local"
fi

# Install prelude emacs
wget https://github.com/bbatsov/prelude/raw/master/utils/installer.sh -O - | sh

case "$SHELL" in
  */bash) : ;;
  *)
    fancy_echo "Changing your shell to bash ..."
    BASH_BIN_PATH=$(which bash)
    echo $BASH_BIN_PATH >> /etc/shells
      chsh -s "$BASH_BIN_PATH"
    ;;
esac

# Fix libffi gem compilation
brew link libffi --force

append_to_bashrc "source /usr/local/share/gitprompt.sh"

fancy_echo "Don't forget to install your dotfiles!"
