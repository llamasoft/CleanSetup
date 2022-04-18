#!/usr/bin/env bash

echo "Date: $(date)"
echo "User: ${USER}"
echo "Host: ${HOSTNAME}"
echo "PID: $$"
echo
echo "Parameters: $#"
printf "  <%s>\n" "$@"
echo
