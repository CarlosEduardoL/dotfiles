count() {
    local DIR="$(pwd)"
    if [[ "$1" != "" ]]; then
        DIR="$1"
    fi
    find "$DIR" -type f | wc -l
}