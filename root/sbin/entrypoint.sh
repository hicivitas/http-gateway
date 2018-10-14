#!/usr/bin/with-contenv /bin/bash
set -eo pipefail

[[ $DEBUG == true ]] && set -x

case ${1} in
  help)
    echo "Help yourself!"
    ;;
  start)
    /bin/s6-svc -wu -T 5000 -u /var/run/s6/services/ss-local
    sleep 2
    /bin/s6-svc -wu -T 5000 -u /var/run/s6/services/privoxy
    sleep 2
    /bin/s6-svwait -D -o /var/run/s6/services/ss-local /var/run/s6/services/privoxy
    ;;
  *)
    exec "$@"
    ;;
esac

exit 0
