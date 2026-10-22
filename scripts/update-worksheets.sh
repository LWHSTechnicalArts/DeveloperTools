#!/usr/bin/env bash
# ^ The first line is called a "shebang." It tells the computer which program
#   should run this file. "/usr/bin/env bash" means "find bash and use it."
#
# update-worksheets.sh
# --------------------
# This script downloads the class worksheets, which are Google Docs, as
# Markdown files into copilot/worksheets/. The list of worksheets is
# copilot/worksheets.txt: one Google Doc share address per line, in class
# order. For each worksheet, the script also:
#
#   - names the downloaded file after the Doc's title, such as
#     02-functions.md,
#   - writes the title after the address in worksheets.txt, so people can
#     tell the lines apart, and
#   - rewrites the worksheet list in copilot/copilot-instructions.md, so
#     Copilot has a link to every worksheet.
#
# Students do not run this script. A GitHub Actions workflow,
# .github/workflows/update-worksheets.yml, runs it every hour on GitHub and
# commits any changes, and each student's launch agent then copies them down
# (see refresh-copilot.sh). The teacher can also run it by hand, read the
# changes with "git diff", and commit them.
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

# get_document_title prints a Doc's title from the headers Google sent with
# the download. One header names the file, with spaces and other characters
# written as "%" codes:
#     content-disposition: attachment; filename*=UTF-8''Functions%20.md
#   $1 = the file holding the headers
get_document_title() {
    local encoded_name decoded_name
    # tr -d '\r' removes the invisible carriage returns at the end of header
    # lines. sed -n '.../p' prints only the part between UTF-8'' and the next
    # ";". tail -n 1 keeps the last match, from the last redirect.
    encoded_name="$(tr -d '\r' < "$1" | sed -n "s/.*filename\*=UTF-8''\([^;]*\).*/\1/p" | tail -n 1)"
    # Turn each "%20" into "\x20", which printf %b prints as the character
    # with that code (here, a space).
    decoded_name="$(printf '%b' "${encoded_name//\%/\\x}")"
    # Remove the ".md" at the end, then any spaces at either end.
    echo "${decoded_name%.md}" | sed -E 's/^ +//; s/ +$//'
}

# get_file_name prints a lowercase, dash-separated file name for a worksheet.
#   $1 = the worksheet's number, such as 2
#   $2 = its title, such as "Functions"
get_file_name() {
    local slug
    # tr changes capital letters to small ones. sed replaces every run of
    # characters that are not letters or digits with one "-", then removes
    # any "-" at the start or end.
    slug="$(echo "$2" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
    # printf %02d writes the number with two digits, such as 02.
    printf '%02d-%s.md' "$1" "$slug"
}


# --- Settings ---------------------------------------------------------------
repository_directory="$(get_repository_directory)"
worksheet_list_file="$repository_directory/copilot/worksheets.txt"
worksheet_directory="$repository_directory/copilot/worksheets"
instructions_file="$repository_directory/copilot/copilot-instructions.md"

# The script rewrites only the lines between these two markers in the
# instructions file. Markdown hides text inside <!-- and -->.
list_start_marker="<!-- worksheet list: written by scripts/update-worksheets.sh -->"
list_end_marker="<!-- end of worksheet list -->"


# --- Read the list ----------------------------------------------------------
# Read worksheets.txt one line at a time. Every line goes into all_lines, so
# the file can be written back with its comments in place. The addresses also
# go into document_addresses.
# "IFS=" keeps spaces at the ends of lines, and "|| [ -n "$line" ]" keeps the
# last line even when the file does not end with a newline character.
all_lines=()
document_addresses=()
while IFS= read -r line || [ -n "$line" ]; do
    all_lines+=("$line")
    # "read -r address title" splits the line at the first space: the first
    # word goes into address and the rest into title. "<<<" feeds it text.
    read -r address title <<< "$line" || true
    # Skip blank lines and lines that start with "#".
    #   -z  true if the text is empty
    if [ -z "${address:-}" ] || [ "${address:0:1}" = "#" ]; then
        continue
    fi
    document_addresses+=("$address")
done < "$worksheet_list_file"


# --- Download the worksheets ------------------------------------------------
# Download into a new, empty scratch folder first. If any download fails,
# "set -e" stops the script and the old worksheets stay as they were.
staging_directory="$(mktemp -d)"
header_file="$(mktemp)"
document_titles=()
file_names=()

worksheet_count="${#document_addresses[@]}"
for (( index = 0; index < worksheet_count; index++ )); do
    document_id="$(get_document_id "${document_addresses[index]}")"
    # Google Docs gives a copy of any Doc shared as "anyone with the link can
    # view" at this address, in the format named after "format=".
    export_address="https://docs.google.com/document/d/$document_id/export?format=md"
    download_path="$staging_directory/download.md"

    # curl downloads an address.
    #   -f  fail (instead of saving an error page) if the server reports an error
    #   -s  silent: no progress bar
    #   -S  still show an error message when something fails
    #   -L  follow redirects to the address where the file really is
    #   -D  save the headers Google sends, which hold the Doc's title
    #   -o  save to this file instead of printing to the screen
    curl -fsSL -D "$header_file" "$export_address" -o "$download_path"

    document_title="$(get_document_title "$header_file")"
    # Lists are numbered from 1 for people, while index counts from 0.
    worksheet_number=$(( index + 1 ))
    file_name="$(get_file_name "$worksheet_number" "$document_title")"
    mv "$download_path" "$staging_directory/$file_name"
    document_titles+=("$document_title")
    file_names+=("$file_name")

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
        "$staging_directory/$file_name"
    echo "Downloaded:     $file_name ($document_title)"
done

# Every download worked, so replace the old worksheets folder with the new
# one. This also removes worksheets that are no longer on the list.
rm -rf "$worksheet_directory"
mv "$staging_directory" "$worksheet_directory"
# mktemp makes folders only you can open. chmod 755 sets the usual folder
# permissions: you can change it, and everyone can open it.
chmod 755 "$worksheet_directory"
rm "$header_file"


# --- Write the titles into worksheets.txt -----------------------------------
# Write each address back with its title after it, and copy every other line
# as it was. "printf '%s\n'" prints the text followed by a new line.
new_list_file="$(mktemp)"
address_index=0
line_count="${#all_lines[@]}"
for (( index = 0; index < line_count; index++ )); do
    line="${all_lines[index]}"
    read -r address title <<< "$line" || true
    if [ -z "${address:-}" ] || [ "${address:0:1}" = "#" ]; then
        printf '%s\n' "$line" >> "$new_list_file"
        continue
    fi
    printf '%s  %s\n' "$address" "${document_titles[address_index]}" >> "$new_list_file"
    address_index=$(( address_index + 1 ))
done
# "cat NEW > OLD" copies the new text over the old file. Unlike mv, it keeps
# the old file's permissions.
cat "$new_list_file" > "$worksheet_list_file"
rm "$new_list_file"


# --- Write the worksheet list into the instructions -------------------------
# grep -F looks for the exact text, and -q prints nothing. Stop with a
# message if either marker is missing, rather than guess where the list goes.
if ! grep -qF "$list_start_marker" "$instructions_file" || ! grep -qF "$list_end_marker" "$instructions_file"; then
    echo "Error: $instructions_file needs these two lines around the worksheet list:" >&2
    echo "$list_start_marker" >&2
    echo "$list_end_marker" >&2
    exit 1
fi

list_text_file="$(mktemp)"
for (( index = 0; index < worksheet_count; index++ )); do
    worksheet_number=$(( index + 1 ))
    printf '%d. [%s](worksheets/%s) — Google Doc: %s\n' \
        "$worksheet_number" "${document_titles[index]}" "${file_names[index]}" \
        "${document_addresses[index]}" >> "$list_text_file"
done

# awk reads the instructions one line at a time. It prints every line except
# the old list: at the start marker it prints the marker and the new list,
# then skips lines until the end marker.
new_instructions_file="$(mktemp)"
awk -v start="$list_start_marker" -v end="$list_end_marker" -v list_file="$list_text_file" '
    $0 == start { print; while ((getline list_line < list_file) > 0) print list_line; skipping = 1; next }
    $0 == end   { skipping = 0 }
    !skipping   { print }
' "$instructions_file" > "$new_instructions_file"
cat "$new_instructions_file" > "$instructions_file"
rm "$new_instructions_file" "$list_text_file"

echo
echo "Done. Review the changes with: git diff copilot"
