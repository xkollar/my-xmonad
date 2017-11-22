#!/usr/bin/env bash

set -eu

share=$( readlink -f "$( dirname "${BASH_SOURCE[0]}" )" )

function usage() {
    echo "Usage: ${0} <full|brief|brief-color> [filename]"
    echo "       ${0} <full|brief|brief-color> [ImageMagick options] filename"
    echo "       ${0} <--help|-h>"
}

function die_usage() {
    usage >&2
    exit 1
}

function main() {
    if [[ ${#} -lt 1 ]]; then
        die_usage
    fi

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
            die_usage
            ;;
    esac

    sed \
        -f <( xmodmap -pke | sed -f "${share}/script.sed" ) \
        "${share}/ibm-pc-keyboard-${mode}.svg" \
    | convert -background transparent - "${@:-x:}"
}

main "${@}"
