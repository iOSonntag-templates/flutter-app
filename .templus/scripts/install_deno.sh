#!/bin/bash


available()
{
  if hash "$1" 2>/dev/null; then
    echo true
  else
    echo false
  fi
}

echo "Checking if deno is installed..."

if [ $(available "deno") = false ] ; then

  echo "deno is missing, installing..."

  INSTALL_OUTPUT=$(curl -fsSL https://deno.land/x/install/install.sh | sh)
  INSTALLED_AT=$(echo "$INSTALL_OUTPUT" | awk -F= '/export DENO_INSTALL/{print $2}' | tr -d '"')
  export DENO_INSTALL="$INSTALLED_AT"
  export PATH="$DENO_INSTALL/bin:$PATH"

  # check if zsh is used or bash
  if [ -n "$ZSH_VERSION" ]; then
    echo "export DENO_INSTALL=\"$INSTALLED_AT\"" >> ~/.zshrc
    echo "export PATH=\"$DENO_INSTALL/bin:$PATH\"" >> ~/.zshrc
    source ~/.zshrc
  else
    echo "export DENO_INSTALL=\"$INSTALLED_AT\"" >> ~/.bashrc
    echo "export PATH=\"$DENO_INSTALL/bin:$PATH\"" >> ~/.bashrc
    source ~/.bashrc
  fi
  echo "deno installed"

fi

deno --version

