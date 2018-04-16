#!/bin/bash

require() {
    prog="${1}"
    if ! command -v "${prog}" >"/dev/null" 2>&1; then
        echo "Setup requires that ${prog} is installed first"
        exit 1
    fi
}



platform=$(uname)
if [[ "${platform}" == "CYGWIN"* ]]; then
    require "curl" # For this script


    require "wget" # For use in apt-cyg
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
    if [[ -z "${CYGWIN_NOWINPATH}" ]] && command -v setx >/dev/null 2>&1; then
        setx CYGWIN_NOWINPATH 1
    fi

    # Sometimes gcc + ld can't find GMP's library files
    # Most libraries have a .a and .dll.a file, but GMP only had the latter
    for lib in "/usr/lib/libgmp" "/usr/lib/libgmpxx"; do
        if [[ -f "${lib}.dll.a"  && ! -e "${lib}.a" ]]; then
            ln -s "${lib}.dll.a" "${lib}.a"
        fi
    done


    require "perl"
    echo ""
    echo "Installing GNU parallel..."
    parallel_url='https://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2'
    time curl -O "${parallel_url}" && tar xjf "parallel-latest.tar.bz2" && cd "parallel-"*"/" && ./configure && make && make install
    echo "will cite" | parallel --citation


    require "python"
    echo "Installing pip..."
    pip_url="https://bootstrap.pypa.io/get-pip.py"
    time curl -O "${pip_url}" && chmod +x "get-pip.py" && python "get-pip.py"


    echo ""
    echo "Installing cpanminus..."
    cpanminus_url='https://cpanmin.us'
    time curl -L "${cpanminus_url}" | perl - "App::cpanminus"
    echo ""


elif [[ "${platform}" == "MINGW"* ]]; then
    echo ""
    echo "Installing MinGW packages..."
    pacman -Sy

    time cat "MingwPackages.txt" | sed 's/\s*#.*$//' | grep -v '^\s*$' | while read -r pkg; do
        echo "Installing ${pkg} ..."
        pacman -S --noconfirm "${pkg}"
    done


else
    echo "Unknown platform: ${platform}"
    exit 1
fi


echo ""
echo "Installation complete"
