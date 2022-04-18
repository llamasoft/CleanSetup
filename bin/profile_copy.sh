#!/usr/bin/env bash

if (( $# < 1 )); then
    echo "USAGE: $0 destination_server [destination_server ...]" 1>&2
    exit 1
fi

file_list=(
    ${HOME}/.bash_env
    ${HOME}/.bash_profile
    ${HOME}/.bash_utils
    ${HOME}/.bash_vars
    ${HOME}/.bashrc
    ${HOME}/.cloud_utils
    ${HOME}/.gitconfig
    ${HOME}/.inputrc
    ${HOME}/.mysql
    ${HOME}/.vimrc
    ${HOME}/bin/
)

for host in "${@}"; do
    echo "Copying files to ${host}..."
    scp -r "${file_list[@]}" "${host}:~/"
    echo ""
done
