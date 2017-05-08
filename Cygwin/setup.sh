#!/bin/bash

require() {
    prog="${1}"
    if ! command -v "${prog}" >"/dev/null" 2>&1; then
        echo "Setup requires that ${prog} is installed first"
        exit 1
    fi
}

require "curl"
require "sed"
require "grep"

echo ""
echo "Installing apt-cyg..."
aptcyg_url='https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg'
time curl -O "${aptcyg_url}" && install "apt-cyg" "/bin"

require "apt-cyg"
echo ""
echo "Installing Cygwin packages..."
time cat "CygwinPackages.txt" | sed 's/\s*#.*$//' | grep -v '^\s*$' | while read -r pkg; do
    echo "Installing ${pkg} ..."
    apt-cyg install "${pkg}"
done

echo ""
echo "Applying Cygwin tweaks..."

# Adds "Open Cygwin Here" shell option
chere -ic -t mintty

# Disables automatically adding Windows paths to Cygwin
if [[ -z "${CYGWIN_NOWINPATH}" ]]; then
    /cygdrive/c/windows/setx CYGWIN_NOWINPATH 1
fi


echo ""
echo "Installing GNU parallel..."
parallel_url='https://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2'
time curl -O "${parallel_url}" && tar xjf "parallel-latest.tar.bz2" && cd "parallel-"* && ./configure && make && make install

echo ""
echo "Installing cpanminus..."
time cpan App::cpanminus
echo ""

echo "Installing pip..."
pip_url="https://bootstrap.pypa.io/get-pip.py"
time curl -O "${parallel_url}" && chmod +x "get-pip.py" && python "get-pip.py"

echo ""
echo "Installation complete"


####################### Misc Tweaks ########################
#
# # Adds "Open Cygwin Here" shell option
# chere -ic -t mintty
#
# # Disables automatically adding Windows paths to Cygwin
# if [[ -z "${CYGWIN_NOWINPATH}" ]]; then
#     /cygdrive/c/windows/setx CYGWIN_NOWINPATH 1
# fi
#
