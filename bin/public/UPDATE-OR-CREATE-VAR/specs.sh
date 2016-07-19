
specs () {
  local TMP="/tmp/mksh_setup_specs/vars"

  reset-fs () {
    rm -rf "$TMP"
    mkdir -p $TMP/config/DEV
    cd $TMP
  }

  # ===============================================================
  reset-fs
  echo -n "=== Create var: "
  should-create-file-with-content "config/DEV/port" 4567 'mksh_setup UPDATE-OR-CREATE-VAR config/DEV port 4567'
  # ===============================================================

  # ===============================================================
  reset-fs
  mksh_setup CREATE-VAR config/DEV port 9000 >/dev/null
  echo -n "=== Updates var: "
  should-create-file-with-content "config/DEV/port" 8000 'mksh_setup UPDATE-OR-CREATE-VAR config/DEV port 8000'
  # ===============================================================

} # specs()

specs
