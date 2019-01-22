#!/usr/bin/env bash

if (( $# < 1 )); then
    echo "USAGE: $0 destination_server" 1>&2
    exit 1
fi

file_list=(
    ${HOME}/.bashrc
    ${HOME}/.bash_env
    ${HOME}/.bash_profile
    ${HOME}/.bash_utils
    ${HOME}/.bash_vars
    ${HOME}/.gitconfig
    ${HOME}/.inputrc
    ${HOME}/.vimrc
    ${HOME}/bin/
)

scp -r "${file_list[@]}" "${1}:~/"