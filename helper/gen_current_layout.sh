#!/usr/bin/env bash

function usage() {
    echo "Usage: ${0} <full|brief> [filename]"
}

function main() {
    case "${1}" in
        full | brief )
            true
            ;;
        * )
            usage
            exit 1
            ;;
    esac

    sed -f <( xmodmap -pke | sed -f script.sed ) "ibm-pc-keyboard-${1}.svg" \
    | convert -background transparent - ${2:-x:}
}

main "${@}"
