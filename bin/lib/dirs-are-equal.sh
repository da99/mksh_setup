
# === {{CMD}}                     dir1  dir2
# === {{CMD}}  ignore-whitespace  dir1 dir2
dirs-are-equal () {
  if [[ "$1" == "ignore-whitespace" ]]; then
    shift
    diff --suppress-blank-empty --ignore-blank-lines --ignore-space-change "$@"
    return 0
  fi

  diff "$@"
} # === end function
