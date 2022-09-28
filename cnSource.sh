#!/bin/bash

function ubuntu {
    cat <<EOF > /etc/apt/sources.list && apt update
deb http://${1}/ubuntu/ ${2} main restricted universe multiverse
deb-src http://${1}/ubuntu/ ${2} main restricted universe multiverse
deb http://${1}/ubuntu/ ${2}-updates main restricted universe multiverse
deb-src http://${1}/ubuntu/ ${2}-updates main restricted universe multiverse
deb http://${1}/ubuntu/ ${2}-backports main restricted universe multiverse
deb-src http://${1}/ubuntu/ ${2}-backports main restricted universe multiverse
deb http://${1}/ubuntu/ ${2}-security main restricted universe multiverse
deb-src http://${1}/ubuntu/ ${2}-security main restricted universe multiverse
EOF
}

function error {
    echo $1 
    exit 1
}

function  ubuntu_select_version {
    case $1 in
        "22.04") 
            version="jammy"
        ;;
        "20.04")
            version="focal"
        ;;
        "18.04")
            version="bionic"
        ;;
        "16.04")
            version="bionic"
        ;;
        "14.04")
            version="trusty"
        ;;
    esac
}

function ubuntu_select_sources {
    case $1 in
        "tuna")
            sources='mirrors.tuna.tsinghua.edu.cn' 
        ;;
        "aliyun")
            sources="mirrors.aliyun.com"
        ;;
    esac
}

sources=''
version=''
case $1 in
    "ubuntu")   
        ubuntu_select_sources $2
        ubuntu_select_version $3

        if [ ! -n "$sources" ] || [ ! -n "$version" ];
        then
            error "请正确输入镜像源和版本 如: $0 ubuntu tuna focal"
        fi
        ubuntu $sources $version
    ;;
esac
