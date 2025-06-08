
#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR="/home/ec2-user/app-logs"
LOG_FOLDER="/var/log/expense-logs"
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
FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14 )
echo "files to be deleted:: $FILES_TO_DELETE"




