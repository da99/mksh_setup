
# === {{CMD}}
os-name () {

  lsb_release -a | grep "Distributor ID:" | tr -s ' ' | cut -f2
} # === end function
