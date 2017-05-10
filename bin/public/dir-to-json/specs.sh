

specs () {
  local TMP="/tmp/my_bash/dir-to-json"
  reset-fs () {
    rm -rf "$TMP"
    mkdir -p "$TMP"
    cd $TMP
  }

  # =================================================================================================
  reset-fs
  echo "ted" > NAME
  echo "General Creative" > CORP
  should-match '{"CORP":"General Creative","NAME":"ted"}'  "my_bash dir-to-json"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  echo "ted" > NAME
  echo "General Creative" > CORP
  cd /tmp
  should-match '{"CORP":"General Creative","NAME":"ted"}'  "my_bash dir-to-json  $TMP"
  # =================================================================================================
} # === specs


specs
