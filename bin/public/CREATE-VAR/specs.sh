

specs () {
  local +x TMP="/tmp/mksh_setup_specs/vars"

  reset-fs () {
    cd /tmp
    rm -rf "$TMP"
    mkdir -p "$TMP/config/DEV"
    mkdir -p "$TMP/config/PROD"
    cd "$TMP"
  }

  # ===============================================================
  reset-fs
  should-create-file-with-content "config/DEV/port" "4567" "mksh_setup CREATE-VAR config/DEV port 4567"
  # ===============================================================

  # ===============================================================
  reset-fs
  should-create-file-with-content "config/PROD/port" "4567" "mksh_setup CREATE-VAR config/PROD port 4567"
  # ===============================================================

  # ===============================================================
  reset-fs
  should-exit 1 "mksh_setup CREATE-VAR config/stag port 4567"
  # ===============================================================

  # ===============================================================
  reset-fs
  mkdir -p $TMP/config/stag
  should-create-file-with-content  "config/stag/port" "4567" "mksh_setup CREATE-VAR config/stag port 4567"
  # ===============================================================

} # === function specs

specs
