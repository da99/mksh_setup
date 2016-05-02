
# === {{CMD}}
# === List directories, ignoring ./ , .git , and maxdepth of 1, mindepth of 1
# === Source: find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -print
ls-dirs () {
  find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -print
} # === end function
