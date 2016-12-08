
# === {{CMD}}  data.json  template.html
# === {{CMD}}  path/2/dir template.html  # Gets VARs from filenames and content.
# === {{CMD}}             template.html  # Uses ENV variables.
template-render () {

  local +x  DIR="$PWD"

  # === Install Handlebars:
  if [[ ! -d "$THIS_DIR/node_modules/handlebars" ]]; then
    cd $THIS_DIR
    mksh_setup BOLD "=== Installing: {{handlebars}}" 1>&2
    set '-x'
    npm install handlebars >&2
    cd "$DIR"
  fi

  # === Generate the template:
  node $THIS_DIR/bin/lib/template-render.js "$@"

} # === end function ================================================================================




