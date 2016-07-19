
# === {{CMD}}
# === {{CMD}}  name
new-bin () {
  local file_name

  if [[ -z "$@" ]]; then
    file_name="$(basename $PWD)"
  else
    file_name=$1
    shift
  fi

  if [[ -f "bin/${file_name}" ]]; then
    echo "=== File already exists."
  else
    mkdir -p bin

    cp -i "$THIS_DIR/templates/bin.sh" "bin/${file_name}"
    bash_setup GREEN "=== Wrote: {{bin/${file_name}}}"
  fi

  chmod +x bin/${file_name}
} # === end function
