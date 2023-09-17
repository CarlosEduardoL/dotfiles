#!/usr/bin/env bash

set -e
# DEBUG
# set -x

# Obtained from https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
DOT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# For security reasons I'll restrict all the files on dot folder to be RW to the user
chown -R "$USER" "$DOT_DIR"
chmod -R 700 "$DOT_DIR"

# Install required Software at global level
if ! bash "$DOT_DIR/software.sh"; then
  exit 1
fi

# Try to install dependencies at user level as posible
LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"

source "$DOT_DIR/utils.sh"

if ! [[ :$PATH: == *:"$LOCAL_BIN":* ]]; then
  export PATH="$LOCAL_BIN:$PATH"
fi

# Curl is required to download most of the software
if ! cmd curl; then 
   echo >&2 "Curl is required. Please install it"
   exit 1;
fi

source "$DOT_DIR/langs.sh"
source "$DOT_DIR/tools.sh"
source "$DOT_DIR/shell.sh"

set +e
