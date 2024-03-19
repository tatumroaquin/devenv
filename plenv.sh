#!/usr/bin/env bash

# Perl development environment install script using `plenv`
# You can change the path of plenv via `PLENV_ROOT` variable
# If you don't use `bash` or `zsh` as your shell you need 
# to modify this script to point it to your runcom file.

REQUIRED=(sed awk make git)

for program in "${REQUIRED[@]}"; do
  if ! command -v "$program" &> /dev/null; then
    echo "$program command is required but does not exist on this system"
    exit 1;
  fi;
done

PLENV_ROOT="$HOME/.plenv"

SHELL_NAME=$(echo "$SHELL" | awk -F'/' '{print $NF}')

PLENV_URL="https://github.com/tokuhirom/plenv.git"
PERL_BUILD_URL="https://github.com/tokuhirom/Perl-Build.git"
PLENV_CONTRIB_URL="https://github.com/miyagawa/plenv-contrib.git"

case "$SHELL_NAME" in
  zsh)
    if [ -e "$XDG_CONFIG_HOME/$SHELL_NAME/.zshrc" ]; then
      RUNCOM_FILE="$XDG_CONFIG_HOME/$SHELL_NAME/.zshrc"
    else
      RUNCOM_FILE="$HOME/.zshrc"
    fi
  ;;
  bash)
    if [ -e "$XDG_CONFIG_HOME/$SHELL_NAME/.bashrc" ]; then
      RUNCOM_FILE="$XDG_CONFIG_HOME/$SHELL_NAME/.bashrc"
    else
      RUNCOM_FILE="$HOME/.bashrc"
    fi
  ;;
  ash)
    if [ -e "$XDG_CONFIG_HOME/$SHELL_NAME/.ashrc" ]; then
      RUNCOM_FILE="$XDG_CONFIG_HOME/$SHELL_NAME/.ashrc"
    else
      RUNCOM_FILE="$HOME/.ashrc"
    fi
  ;;
esac

install() {
  git clone $PLENV_URL "$PLENV_ROOT"
  git clone $PERL_BUILD_URL "$PLENV_ROOT/plugins/perl-build"
  git clone $PLENV_CONTRIB_URL "$PLENV_ROOT/plugins/plenv-contrib"

  {
  echo
  echo '# plenv'
  echo 'export PATH="$PATH:$HOME/.plenv/bin"'
  echo 'eval "$(plenv init - $SHELL_NAME)"'
  echo '# plenv end'
  } >> "$RUNCOM_FILE"
}

remove() {
  rm -rf "$PLENV_ROOT"
  sed -i '/^# plenv/,/^# plenv end/d' "$RUNCOM_FILE"
}

case "$1" in
  install)
    install
    ;;
  remove)
    remove
    ;;
  *)
    echo "Usage: $0 <install/remove>"
    ;;
esac
