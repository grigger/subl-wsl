#!/bin/bash

set -euo pipefail

SUBLWSL_CREATE_NOEXIST=${SUBLWSL_CREATE_NOEXIST:-true}
SUBLWSL_QUIET=${SUBLWSL_QUIET:-false}

is_true() {
    local var="$1"
    case $var in
        yes|y|true|t|on|1) return 0 ;;
    esac
    return 1
}

args=()
paths=()
for arg in "$@"; do
    # Save arguments with leading "-". Note: we can't open files with a leading "-"
    if [[ "$arg" == -* ]]; then
        args+=("$arg")
    else
        paths+=("$arg")
    fi
done

# Convert paths to win paths
winpaths=()
for path in "${paths[@]}"; do
    if is_true "$SUBLWSL_CREATE_NOEXIST" && [[ ! -e "$path" ]]; then
        is_true "$SUBLWSL_QUIET" || echo "Creating $path"
        touch "$path"
    fi
    canpath=$(readlink -f "$path")
    winpath=$(wslpath -w "$canpath")
    winpaths+=("$winpath")
done

if ! is_true "$SUBLWSL_QUIET" && [[ -n "${paths[@]}" ]]; then
    echo "Editing ${paths[@]}"
    echo "Windows path is ${winpaths[@]}"
fi

/mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe "${args[@]}" "${winpaths[@]}"
