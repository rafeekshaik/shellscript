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
echo "script executed at :$TIMESTAMP" &>>$LOG_FILE_NAME
USAGE (){

echo "USAGE:: sh backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
exit 1
}
if [ $# -lt 2 ]
then 
USAGE
fi

if [ ! -d $SOURCE_DIR ]
then 
echo "source directory $SOURCE_DIR is not exist"
exit 1
fi

if [ ! -d $DEST_DIR ]
then
echo "Destination directory $DEST_DIR is not present"
exit 1
fi
FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)

if [ -n "$FILES" ]
then
echo "files are :$FILES"
ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
find $SOURCE_DIR -name "*.log" -mtime +14 | zip -@ "$ZIP_FILE"
if [ -f "$ZIP_FILE" ]
then
echo "zip file is cretaed successfully"
while read -r filesname
do 
   echo "files to be deleted are:$filesname"
   rm -rf $filesname

done <<< $FILE

exit 1
else
echo "creating zip file is failure"
exit 1
fi
else
echo "no files are there for older then $DAYS"
fi


