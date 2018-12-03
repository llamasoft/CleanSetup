# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

export PATH="${PATH}:~/bin"

for profile in ~/.bash_env ~/.bash_vars ~/.bash_utils; do
    if [[ -f "${profile}" ]]; then
        . "${profile}"
    fi
done
