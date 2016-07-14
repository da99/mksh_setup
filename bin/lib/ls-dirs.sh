
# === {{CMD}}
# === {{CMD}}  DIR  [DIR]  [DIR]
# === List directories, ignoring ./ , .git, lost+found, .Trash, .Trash-1000 , and maxdepth of 1, mindepth of 1
# === Source: find . -maxdepth 1 -mindepth 1 -type d -not -name ".git" -print
ls-dirs () {
  if [[ -z "$@" ]]; then
    ls-dirs "$PWD"
    return 0
  fi

  while [[ ! -z "$@" ]]; do
    find -L $1 -maxdepth 1 -mindepth 1 -type d \
      -not -name ".git"                    \
      -and -not -name "lost+found"         \
      -and -not -name ".Trash"             \
      -and -not -name ".Trash-1000"        \
      -print
    shift
  done
} # === end function
