#!/usr/bin/env bash

REQUIRED=(bash zip unzip curl sed awk)

for program in "${REQUIRED[@]}"; do
  if ! command -v "$program" &> /dev/null; then
    echo "$program command is required but does not exist on this system"
    exit 1;
  fi;
done

OS_RELEASE=$(cat /etc/os-release | awk -F'=' '/^ID/{print $2}')

# https://wiki.alpinelinux.org/wiki/Running_glibc_programs
# apk add gcompat libstdc++

if [ "$OS_RELEASE" = "alpine" ]; then
  echo "Unfortunately, SDKMAN has no support for Alpine Linux yet as it uses BusyBox and MUSL"
  echo "Please see this Github Issue https://github.com/sdkman/sdkman-cli/issues/1133"
  exit 1;
fi

SDKMAN_DIR="$HOME/.sdkman"
SHELL_NAME=$(echo "$SHELL" | awk -F'/' '{print $NF}')

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

usage() {
  echo "Usage: $0 <install/remove>";
}

install() {
  # source https://sdkman.io/install 
  curl -s "https://get.sdkman.io?rcupdate=false" | bash
}

remove() {
  rm -rf "$SDKMAN_DIR"
  sed -i '/sdkman/,/sdkman end/' "$RUNCOM_FILE"
}

case "$1" in 
  install)
    install
  ;;
  remove)
    remove
  ;;
  *)
    usage
  ;;
esac
