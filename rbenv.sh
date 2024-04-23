#!/usr/bin/env bash

# Ruby development environment install script using `rbenv`
# You can change the path of rbenv via `RBENV_ROOT` variable
# If you don't use `bash` or `zsh` as your shell you need 
# to modify this script to point it to your runcom file.

REQUIRED=(sed awk make git)

for program in "${REQUIRED[@]}"; do
  if ! command -v "$program" &> /dev/null; then
    echo "$program command is required but does not exist on this system"
    exit 1;
  fi;
done

RBENV_ROOT="$HOME/.rbenv"

SHELL_NAME=$(echo "$SHELL" | awk -F'/' '{print $NF}')

RBENV_URL="https://github.com/rbenv/rbenv.git"

case "$SHELL_NAME" in
  bash | zsh)
    if [ -e "$XDG_CONFIG_HOME/$SHELL_NAME/.${SHELL_NAME}rc" ]; then
      RUNCOM_FILE="$XDG_CONFIG_HOME/$SHELL_NAME/.${SHELL_NAME}rc"
    fi
    echo "trigger"
  ;;
  *)
    echo "Only bash and zsh shells are suppported"
    exit 1;
  ;;
esac

install() {
  git clone $RBENV_URL "$RBENV_ROOT"

  {
  echo
  echo '# rbenv'
  echo 'export PATH="$PATH:$HOME/.rbenv/bin"'
  echo 'eval "$(rbenv init - ${SHELL##*/})"'
  echo '# rbenv end'
  } >> "$RUNCOM_FILE"
}

remove() {
  rm -rf "$RBENV_ROOT"
  sed -i '/^# rbenv/,/^# rbenv end/d' "$RUNCOM_FILE"
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
