echo "Current PATH: $PATH"

new_directory=$1
export PATH="$new_directory:$PATH"

echo "New PATH: $PATH"
