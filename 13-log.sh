#!/bin/bash

USERID=$(id -u)

 R="\e[31m"
 G="\e[32m"
 Y="\e[33m"
 LOGS_FOLDER="/var/logs/shellscript-logs"
 LOG_FILE=$(echo $0 | cut -d "." -f1)
 TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
 LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
   if [ $1 -ne 0 ]
    then
    echo -e  "$2 ....is $R failure"
    exit 1
    else
    echo -e "$2.... is $G successfull"
    fi
}
echo "script started executing at :: $TIMESTAMP" &>> $LOG_FILE_NAME

if [ $USERID -ne 0 ]
then 
echo "ERROR::user must have previllaged admin access"
exit 1
fi

dnf list installed mysql &>>$LOG_FILE_NAME
    if [ $? -ne 0 ]
    then
    dnf install mysql -y &>>$LOG_FILE_NAME
    VALIDATE $? "installing mysql"

else
echo -e "mysql is $Y allready installed"
fi

   dnf list installed git &>>$LOG_FILE_NAME
        if [ $? -ne 0 ]
        then
        dnf install git -y &>>$LOG_FILE_NAME
        VALIDATE $? "installing git"
    else
    echo -e "git $Y allready installed"
    fi
