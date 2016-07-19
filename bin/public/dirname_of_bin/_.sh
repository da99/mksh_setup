
# === {{CMD}}  partial/or/full/path
dirname_of_bin () {
  dirname "$(dirname "$(readlink -m "$@")")"
} # === end function
