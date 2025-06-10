#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

LOG_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOG_FOLDER/$LOG_FILE-$TIMESTAMP.log"
VALIDATE(){
      if [ $1 -ne 0 ]
    then 
    echo -e "$2 ....... is $R failure $N"
    exit 1
    else
    echo -e "$2 ....... is  $G success $N"
    fi
}

mkdir -p /home/ec2-user/shellscript-logs

USAGE (){
echo -e "$R USAGE:: $N sh backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
exit 1

}


if [ $# -lt 2 ]
then
USAGE
fi

if [ ! -d $SOURCE_DIR ]
then 
echo -e "$SOURCE_DIR dose not exist ...please check"
exit 1
fi

if [ ! -d $DEST_DIR ]
then
echo -e "$DEST_DIR dose not exist....please check"
exit 
fi

FILE=$(find $SOURCE_DIR -name "*.log" -mtime +14)
