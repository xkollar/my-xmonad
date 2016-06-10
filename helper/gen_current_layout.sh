#!/usr/bin/env bash

function usage() {
    echo "Usage: ${0} <full|brief|brief-color> [filename]"
    echo "       ${0} <full|brief|brief-color> [ImageMagick options] filename"
    echo "       ${0} <--help|-h>"
}

function main() {
    local -r mode="${1}"; shift

    case "${mode}" in
        full | brief | brief-color )
            true
            ;;
        --help | -h )
            usage
            exit 0
            ;;
        * )
            usage >&2
            exit 1
            ;;
    esac

    sed -f <( xmodmap -pke | sed -f script.sed ) "ibm-pc-keyboard-${mode}.svg" \
    | convert -background transparent - "${@:-x:}"
}

main "${@}"
