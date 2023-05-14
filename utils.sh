# Utility to check if a command exist
cmd() {
  command -v "$1" >/dev/null 2>&1;
}

