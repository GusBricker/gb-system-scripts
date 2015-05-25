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
