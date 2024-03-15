#!/usr/bin/env bash

# C# development environment using .NET in Linux

# source https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
DN_SCRIPT="https://dot.net/v1/dotnet-install.sh"
DOTNET_ROOT="$HOME/.dotnet"

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

install() {
  curl -LO "$DN_SCRIPT"
  chmod +x ./dotnet-install.sh
  ./dotnet-install.sh --install-dir "$DOTNET_ROOT"

  {
  echo
  echo '# dotnet'
  echo 'export DOTNET_ROOT="$HOME/.dotnet"'
  echo 'export DOTNET_TOOLS="$HOME/.dotnet/tools"'
  echo 'export DOTNET_CLI_TELEMETRY_OPTOUT="true"'
  echo 'export PATH="$PATH:$DOTNET_ROOT:$DOTNET_TOOLS"'
  echo '# dotnet end'
  } >> "$RUNCOM_FILE"
}

remove() {
  rm -rf "$DOTNET_ROOT"
  sed -i '/dotnet/,/dotnet end/d' "$RUNCOM_FILE"
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
