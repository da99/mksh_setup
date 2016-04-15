
# === {{CMD}}                     dir1  dir2
# === {{CMD}}  ignore-whitespace  dir1 dir2
dirs-are-equal () {
  if [[ "$1" == "ignore-whitespace" ]]; then
    shift
    diff                          \
      --side-by-side              \
      --suppress-blank-empty      \
      --ignore-trailing-space     \
      --ignore-space-change       \
      --ignore-all-space          \
      --ignore-blank-lines        \
      --suppress-common-lines     \
      "$@"
    return 0
  fi

  diff "$@"
} # === end function
