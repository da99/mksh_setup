
# === {{CMD}}  starting/file/path   file/path
# === This function was written because
# === MKSH has a shell builtin for realpath that is far simpler than GNU realpath.
relative-to () {
  local +x FROM="$(realpath "$1")"; shift
  local +x PATH=$(realpath "$1"); shift
  echo "${PATH/"$FROM"/}"
} # === end function
