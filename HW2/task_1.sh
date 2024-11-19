echo "File list:"

for item in *; do
    if [ -d "$item" ]; then
        echo "$item - Folder"
    else; then
        permissions=$(ls -l "$item" | awk '{print $1}')
        echo "$item - File, permisions: $permissions"
    fi
done

if [ -e "$file_to_search" ]; then
    echo "File '$file_to_search' exist."
else
    echo "File '$file_to_search' does not exist."
fi
