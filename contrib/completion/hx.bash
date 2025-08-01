#!/usr/bin/env bash
# Bash completion script for Helix editor

_hx() {
    local cur prev languages
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD - 1]}"

    case "$prev" in
    -g | --grammar)
        mapfile -t COMPREPLY < <(compgen -W 'fetch build' -- "$cur")
        return 0
        ;;
    --health)
        languages=$(hx --health all-languages | tail -n '+2' | awk '{print $1}' | sed 's/\x1b\[[0-9;]*m//g')
        mapfile -t COMPREPLY < <(compgen -W """clipboard languages all-languages all $languages""" -- "$cur")
        return 0
        ;;
    esac

    case "$2" in
    -*)
        mapfile -t COMPREPLY < <(compgen -W "-h --help --tutor -V --version -v -vv -vvv --health -g --grammar --vsplit --hsplit -c --config --log" -- """$2""")
        return 0
        ;;
    *)
        mapfile -t COMPREPLY < <(compgen -fd -- """$2""")
        return 0
        ;;
    esac
} && complete -o filenames -F _hx hx
