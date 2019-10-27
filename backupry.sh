#!/bin/bash
# A folder backup utility script.
# Copyright © 2019 Gwenael Guyot

#Init variables
set -e
src_dir=$1
backup_dir=$2
default_src_dir=""
default_backup_dir=""
date=$(date '+%Y-%m-%d')
error_icon=$(echo 💃)
msg_icon=$(echo 🧜)
prompt_icon=$(echo ❓)
#Validate parameters
if [[ -z "$default_src_dir" && -z "$src_dir" ]]; then
    echo "$error_icon  Error: No Source directory given."
    exit 1
fi
if [[ -z "$default_backup_dir" && -z "$backup_dir" ]]; then
    echo "$error_icon  Error: No Backup directory given."
    exit 1
fi
#Set default source & backup directory if defined
if [[ ! -z "$default_src_dir" && -z "$src_dir" ]]; then
    src_dir=$default_src_dir
    echo "$msg_icon  Info: Default source directory will be used ( $default_src_dir )."
fi
if [[ ! -z "$default_backup_dir" && -z "$backup_dir" ]]; then
    src_dir=$default_backup_dir
    echo "$msg_icon  Info: Default source directory will be used ( $default_backup_dir )."
fi
#Validate source directory
if [[ -d "$src_dir" && ! -z "$src_dir" ]]; then
    echo "$msg_icon  Info: Source directory is valid"
elif [ ! -z "$src_dir" ]; then
    echo "$error_icon  Error: Source directory '$src_dir' does not exists."
    exit 1
fi

#Validate backup directory
if [[ -d "$backup_dir" && ! -z "$backup_dir" ]]; then
    echo "$msg_icon  Info: Backup directory is valid"
elif [ ! -z "$backup_dir" ]; then
    echo "$error_icon  Error: Backup directory '$backup_dir' does not exists."
    exit 1
fi
if [[ "$backup_dir" == "$src_dir" ]]; then
    echo "$error_icon  Error: Backup directory can't be the same as the source directory."
    exit 1
fi

#Validate backup path
base_name=$(basename $src_dir)
backup_path="$backup_dir/$base_name/$date"

if [[ -d "$backup_path" ]]; then
    echo "$msg_icon  Info: A backup of this folder has already been done today. "
    echo "$prompt_icon  What do you wish to do ? "
    select yn in "Overwrite" "Cancel"; do
        case $yn in
        Overwrite) break ;;
        Cancel) exit ;;
        esac
    done
    else
    mkdir $backup_dir/$base_name
fi

if [[ -d "$backup_dir/$base_name" ]]; then
#Execute backup
echo "Info: Beginning Backup"
rsync -arh --info=progress2 --ignore-times --delete --ignore-existing $src_dir/ $backup_path/
else
echo "$error_icon  Error: Could not create a directory in the backup folder."
echo "Make sure you have the right permissions."
fi
#date "+%s" -d "02/20/2013 08:41:15"
