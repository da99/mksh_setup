
# === {{CMD}}
# === {{CMD}}  folder
sizes () {
    # === $ sizes
    # === $ sizes  folder/path
    folder="./*"
    if [[ -n "$@" ]]; then
      folder="$1"
      shift
    fi

    # du -h $folder | grep --extended-regexp ".*[0-9]G.*" | sort --human-numeric-sort
    du -h --max-depth=0 $folder | sort --human-numeric-sort
} # === end function
