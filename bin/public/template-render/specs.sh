
specs () {
  local TMP="/tmp/bash_setup/template-render"
  reset-fs () {
    rm -rf "$TMP"
    mkdir -p "$TMP"
    cd $TMP
  }

  # =================================================================================================
  reset-fs
  sh_color BOLD "-n" "=== Renders: {{data.json  template.txt}}: "
  echo '{"name":"ted","corp":"General Creative"}' > data.json
  echo "RESULT: {{name}}  {{corp}}"               > template.txt
  should-match "RESULT: ted  General Creative"  "bash_setup template-render  data.json  template.txt"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  sh_color BOLD "-n" "=== Renders: {{nested vars}}: "
  echo '{"name":"ted","corp":"General Creative","full":"{{name}} {{corp}}"}' > data.json
  echo "RESULT: {{full}}" > template.txt
  should-match "RESULT: ted General Creative"  "bash_setup template-render  data.json  template.txt"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  sh_color BOLD "-n" "=== Renders: {{ENV vars}}: "
  echo "RESULT: {{NAME}} {{CORP}}" > template.txt
  should-match-stdout "RESULT: ted General Creative"  "NAME=\"ted\" CORP=\"General Creative\" bash_setup template-render template.txt"
  # =================================================================================================


  # =================================================================================================
  reset-fs
  sh_color BOLD "-n" "=== Renders: {{dir of vars}}: "
  echo "tEd" > NAME
  echo "General Creative" > CORP
  echo "{{NAME}} {{CORP}}" > template.txt
  should-match "tEd General Creative"  "bash_setup template-render  $TMP  template.txt"
  # =================================================================================================

  # =================================================================================================
  reset-fs
  sh_color BOLD "-n" "=== Exits 1 if vars not found: "
  echo "{{NAME}} {{CORP}}" > template.txt
  should-exit 1 "mksh_setup template-render  $TMP  template.txt"

} # === specs

specs

