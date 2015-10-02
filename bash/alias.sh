#!/bin/bash

alias ll="ls -lhF"
alias la="ls -lahF"
alias again="history -p !!"

function fif() 
{
    local s=$1
    local dir=$2
    local extras=$3

    if [[ "x${dir}" == "x" ]]
    then
        dir="."
    fi
    echo "s: ${s}"
    echo "Dir: ${dir}"
    echo "Extras: ${extras}"

    if [[ "x${s}" != "x" ]]
    then
        grep -r "${s}" "${dir}" --color=auto ${extras}
    fi
}

function fifg()
{
    fif "$1" "." "--exclude-dir=.git"
}

function rif()
{
    local find_term="$1"
    local replace_term="$2"
    local directory="$3"
    local dry_run="$4"
    local backup_ex="rifbak"
    local sed_args="-i.${backup_ex}"
    local sed_cmd="s/${find_term}/${replace_term}/g"

    if [[ "x${find_term}" == "x" ]] || [[ "x${replace_term}" == "x" ]] || [[ "x${directory}" == "x" ]]
    then
        echo "Missing minimum arguments:"
        echo "   rif <find term> <replace term> <directory> <dry run>"
        echo "   Dry run argument is optional, use yes to enable."
        return 1
    fi

    if [[ "x${dry_run}" == "xyes" ]]
    then
        sed_args="-n"
        sed_cmd="/${find_term}/p"
        echo "Running dry!"
    else
        echo "Deleting old backup files"
        rm ${directory}/*.${backup_ex}
    fi

    find "${directory}" -type f -exec sh -c "if [[ {} == *.${backup_ex} ]]; then exit 1; fi" \; -exec echo "Searching: " {} \; -exec sed ${sed_args} "${sed_cmd}" {} \;
}

function mkcd() 
{
    mkdir -p "$1" && cd "$1"
}

function up()
{
    local num=$1

    if [[ "x${num}" == "x" ]]
    then
        num=1
    fi

    if [[ ! "${num}" =~ ^-?[0-9]+$ ]]
    then
        num=1
    fi

    for (( i=0; i<${num}; i++ ))
    do
        cd ..
    done
}

function redit()
{
    local filter=$1
    local directory=$2
    local files
    local file

    if [[ "x${directory}" == "x" ]]
    then
        directory="$(pwd)"
    fi
    files=`ls -1 "${directory}"/${filter}`
    for file in $files
    do
        vim ${file}
    done
}

function download()
{
    local url="$1"
    shift

    wget --user-agent=Mozilla --content-disposition "${url}" "${@}"
}

