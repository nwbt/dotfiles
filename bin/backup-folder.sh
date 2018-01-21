#! /bin/bash
#
# backup-folder.sh
# Copyright (C) 2018  <@rubyriver.local>
#
# Distributed under terms of the MIT license.
#

# make sure FOLDER_DIR starts and ends with forward slash 
# (cause I don't feel like writing any more bash)
FOLDER_DIR='/Volumes/stub/stuff/'
BACKUP_DIR=${HOME}/.backup/
BACKUP_NAME=$(echo $FOLDER_DIR | sed 's/\///' | rev | sed 's/\///' | rev | tr '/' '-')
DATE=$(date -u +%Y-%m-%d_%H-%M-%S_%Z)

if [[ ! -d $FOLDER_DIR ]]; then
	echo "error backing up folder. '$FOLDER_DIR' not available "
	exit 1
fi

if [[ ! -d $BACKUP_DIR ]]; then
	echo "creating $BACKUP_DIR"
	mkdir -p $BACKUP_DIR
fi

BACKUP_PATH=${BACKUP_DIR}${BACKUP_NAME}_${DATE}.tgz
echo $BACKUP_PATH

tar -czvf $BACKUP_PATH $FOLDER_DIR
echo "backed up folder :)"

exit 0
