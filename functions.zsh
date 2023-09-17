# This function counts the number of files in the current directory or in the directory provided as an argument
count() {
    # Store the current directory in a local variable
    local DIR="$(pwd)"
    # If an argument is provided, update DIR to the provided directory
    if [[ "$1" != "" ]]; then
        DIR="$1"
    fi
    # Find all files in the directory and count them
    find "$DIR" -type f | wc -l
}

# This function creates a new directory and navigates into it
mkcd() {
    # Check if an argument is provided. If not, print a message and return with an error code.
    if [ -z "$1" ]; then
        echo "Please provide a directory name"
        return 1
    fi

    # Try to make the directory and navigate into it. If either operation fails (due to, for example, insufficient permissions), print an error message and return with a different error code.
    mkdir -p "$1" && cd "$1" || {
        echo "Unable to create or navigate to directory $1"
        return 2
    }
}
