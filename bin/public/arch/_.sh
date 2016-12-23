
# === {{CMD}}
arch () {
  local +x LINK_LIB="$((ldd --version || : ) 2>&1 | grep libc | cut -d' ' -f1)"
  local +x CODENAME="$(lsb_release -c | cut -f2)"
  local +x CPU_ARCH="$(lscpu | grep "Architecture" | tr -d ' ' | cut -d':' -f2)"

  echo ${CODENAME}.${CPU_ARCH}.${LINK_LIB}
} # === end function
