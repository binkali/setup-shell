#!/usr/bin/env bash

read -p "Project name: " name
read -p "Put project in existing folder(y/n)" yn

if [ "$yn" = "y" ] || [ "$yn" = "Y" ]; then
    read -p "Put project in folder: " folder
    if [[ ! -d "$folder" ]]; then
        echo "Folder: '$folder' does not exist"
        exit 1
    fi
    mkdir "$folder"/"$name"
else
    mkdir "$name"
fi


# Checking if uv is installed
if command -v uv >/dev/null 2>&1; then
    echo "uv $(uv --version) is installed."
else
    read -p "uv isn't found on your system. Do you want to install it?(y/n)" uvyn

    # installing uv
    if [ "$uvyn" = "y" ] || [ "$uvyn" = "Y" ]
        if command -v brew >/dev/null 2>&1; then
            echo "Installing uv via brew..."
            brew install uv >/dev/null 2>&1
        else
            echo "Exiting..."
            exit 1
        fi
    fi
fi

# Checking if git is installed
if command -v git >/dev/null 2>&1; then
    echo "git $(git --version) is installed."
else
    read -p "git isn't found on your system. Do you want to install it?(y/n)" gtyn
    if [ "$gtyn" = "y" ] || [ "$gtyn" = "Y" ]; then
        echo "Installing git via brew..."
        brew install git >/dev/null 2>&1
    else
        echo "Exiting..."
        exit 1
    fi
fi
# initialising project
uv init
git init

