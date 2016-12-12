
# === {{CMD}}  app_name func_name
source () {
  cat /apps/$1/bin/public/$2/_.sh || cat /apps/$1/bin/private/$2/_.sh
} # === end function
