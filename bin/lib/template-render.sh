
# === {{CMD}}  data.json  template.html
# === {{CMD}}  path/2/dir template.html  # Gets VARs from filenames and content.
# === {{CMD}}             template.html  # Uses ENV variables.
template-render () {

  local +x  DIR="$PWD"

  # === Install Handlebars:
  if [[ ! -d "$THIS_DIR/node_modules/handlebars" ]]; then
    cd $THIS_DIR
    mksh_setup BOLD "=== Installing: {{handlebars}}" 1>&2
    set -x
    npm install handlebars >&2
    cd "$DIR"
  fi

  # === Generate the template:
  node $THIS_DIR/bin/lib/template-render.js "$@"

} # === end function ================================================================================

specs () {
  local TMP="/tmp/bash_setup/template-render"
  reset-fs () {
    rm -rf "$TMP"
    mkdir -p "$TMP"
    cd $TMP
  }

  # =================================================================================================
  reset-fs
  mksh_setup BOLD "-n" "=== Renders: {{data.json  template.txt}}: "
  echo '{"name":"ted","corp":"General Creative"}' > data.json
  echo "RESULT: {{name}}  {{corp}}"               > template.txt
  should-match "RESULT: ted  General Creative"  "bash_setup template-render  data.json  template.txt"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  bash_setup BOLD "-n" "=== Renders: {{nested vars}}: "
  echo '{"name":"ted","corp":"General Creative","full":"{{name}} {{corp}}"}' > data.json
  echo "RESULT: {{full}}" > template.txt
  should-match "RESULT: ted General Creative"  "bash_setup template-render  data.json  template.txt"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  bash_setup BOLD "-n" "=== Renders: {{ENV vars}}: "
  echo "RESULT: {{NAME}} {{CORP}}" > template.txt
  should-match-output "RESULT: ted General Creative"  "NAME=\"ted\" CORP=\"General Creative\" bash_setup template-render template.txt"
  # =================================================================================================


  # =================================================================================================
  reset-fs
  bash_setup BOLD "-n" "=== Renders: {{dir of vars}}: "
  echo "tEd" > NAME
  echo "General Creative" > CORP
  echo "{{NAME}} {{CORP}}" > template.txt
  should-match "tEd General Creative"  "bash_setup template-render  $TMP  template.txt"
  # =================================================================================================


} # === specs



