#!/usr/bin/env bash
# ^ The first line is called a "shebang." It tells the computer which program
#   should run this file. "/usr/bin/env bash" means "find bash and use it."
#
# update-worksheets.sh
# --------------------
# This script downloads the class worksheets, which are Google Docs, as
# Markdown files into copilot/worksheets/. Copilot reads them through links in
# copilot/copilot-instructions.md. The list of worksheets is in
# copilot/worksheets.txt.
#
# Students do not run this script. The teacher runs it after changing a
# worksheet, reads the changes with "git diff", and commits them; students get
# the new files the next time they run the setup command.
#
# How to run it (from inside the DeveloperTools folder):
#
#     bash scripts/update-worksheets.sh
#
# Every line that starts with "#" is a comment. Bash skips comments; they are
# only there for people reading the file.


# --- Safety settings --------------------------------------------------------
# "set" changes how bash behaves while this script runs:
#   -e  stop the script as soon as any command fails
#   -u  stop if the script uses a variable that was never given a value
#   -o pipefail  count a failure anywhere in a pipeline (a | b | c) as a failure
set -euo pipefail


# --- Functions --------------------------------------------------------------
# A function is a named group of commands that you can run again and again.
# You define it once with "name() { ... }" and then run it by typing its name.
# Inside a function, "$1" is the first thing passed to it, "$2" the second,
# and so on.

# get_repository_directory prints the full path of the repository: the
# folder one level above the scripts folder this file is in.
get_repository_directory() {
    (cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
}

# get_document_id prints the ID part of a Google Doc address.
#   $1 = an address such as https://docs.google.com/document/d/ID/edit
get_document_id() {
    local document_address="$1"
    # ${variable#pattern} removes the shortest match of pattern from the
    # front. This removes everything up to and including "/document/d/".
    local after_prefix="${document_address#*/document/d/}"
    # ${variable%%pattern} removes the longest match of pattern from the end.
    # This removes the first "/" and everything after it, leaving the ID.
    echo "${after_prefix%%/*}"
}


# --- Settings ---------------------------------------------------------------
repository_directory="$(get_repository_directory)"
worksheet_list_file="$repository_directory/copilot/worksheets.txt"
worksheet_directory="$repository_directory/copilot/worksheets"


# --- Main work --------------------------------------------------------------
mkdir -p "$worksheet_directory"

# Read the list one line at a time into two lined-up arrays: item 0 in
# file_names belongs with item 0 in document_addresses, and so on.
# "read -r name address" splits each line at the first space: the first word
# goes into name and the rest of the line into address.
file_names=()
document_addresses=()
while read -r name address; do
    # Skip blank lines and lines that start with "#".
    #   -z  true if the text is empty
    if [ -z "$name" ] || [ "${name:0:1}" = "#" ]; then
        continue
    fi
    # "+=" adds one item to the end of an array.
    file_names+=("$name")
    document_addresses+=("$address")
done < "$worksheet_list_file"

worksheet_count="${#file_names[@]}"

for (( index = 0; index < worksheet_count; index++ )); do
    file_path="$worksheet_directory/${file_names[index]}.md"
    document_id="$(get_document_id "${document_addresses[index]}")"
    # Google Docs gives a copy of any Doc shared as "anyone with the link can
    # view" at this address, in the format named after "format=".
    export_address="https://docs.google.com/document/d/$document_id/export?format=md"

    # curl downloads an address.
    #   -f  fail (instead of saving an error page) if the server reports an error
    #   -s  silent: no progress bar
    #   -S  still show an error message when something fails
    #   -L  follow redirects to the address where the file really is
    #   -o  save to this file instead of printing to the screen
    curl -fsSL "$export_address" -o "$file_path"

    # Google puts each picture inside the Markdown file as a long line of
    # text, which made the nine worksheets about 5 megabytes. Copilot reads
    # only the words, so sed removes the pictures.
    #   -i ''  change the file in place (macOS sed needs the empty '')
    #   -e '/PATTERN/d'  delete each line that matches PATTERN: a picture's
    #                    "[image1]: <data:image..." line at the end of the file
    #   -e 's/PATTERN//g'  remove every "![][image1]" where a picture was shown
    sed -i '' \
        -e '/^\[image[0-9]*\]: <data:image/d' \
        -e 's/!\[\]\[image[0-9]*\]//g' \
        "$file_path"
    echo "Downloaded:     $file_path"
done

echo
echo "Done. Review the changes with: git diff copilot/worksheets"
