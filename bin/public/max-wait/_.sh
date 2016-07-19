
# === {{CMD}}  X[s|m|h]   "cmd -with -args"
max-wait () {
   local +x TIME="$1"; shift
   local +x CMD="$@"
   local +x AMOUNT="$(echo $TIME | grep -Po "(\d+)(?=[a-z]?)" )"
   local +x UNIT="unknown"

   case "$(echo $TIME | grep -Po "\d+\K(.)" || echo s)" in
     d)
       UNIT="days"
       ;;
     h)
       UNIT="hours"
       ;;
     m)
       UNIT="minutes"
       ;;
     s)
       UNIT="seconds"
       ;;
     *)
       mksh_setup RED "!!! Unknown value of time: $TIME"
       exit 1
       ;;
   esac

   local +x TARGET=$(date -d "today + $AMOUNT $UNIT" +'%s')

   while true; do
     if $CMD; then
       break;
     fi
     if [[ "$(date -d "today" +'%s')" -gt "$TARGET" ]]; then
       mksh_setup RED "!!! Max {{time limit reached}}: BOLD{{$CMD}}"
       exit 1
     fi
     sleep 1
   done

} # === end function
