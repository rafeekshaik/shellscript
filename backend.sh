#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/expense-log"
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

dnf module disable nodejs -y &>>$LOG_FILE_NAME
VALIDATE $? "disabling node js 16"
dnf module enable nodejs:20 -y &>>$LOG_FILE_NAME
VALIDATE $? "enabling node js 20"
dnf install nodejs -y &>>$LOG_FILE_NAME
VALIDATE $? "installing nodejs"
id expense
if [ $? -ne 0 ]
useradd expense &>>$LOG_FILE_NAME
VALIDATE $? "adding expense user"
else
echo "expense user allready created"
fi

mkdir -p /app &>>$LOG_FILE_NAME
VALIDATE $? "creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE_NAME
VALIDATE $? "downloading appcode"

rm -rf /app/* 
cd /app
unzip /tmp/backend.zip
VALIDATE $? "unzipping the code"

npm install &>>$LOG_FILE_NAME
echo "downloading dependencies"

cp /home/ec2-user/shellscript/backend.sh /etc/systemd/system/backend.service &>>$LOG_FILE_NAME
VALIDATE $? "copying backend.service"

dnf install mysql -y &>>$LOG_FILE_NAME
VALIDATE $? "installing mysql client"

mysql -h mysql.daws17s.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG_FILE_NAME
VALIDATE $? "adding schemas to the databases"

systemctl daemon-reload &>>$LOG_FILE_NAME
VALIDATE $? "demon relaod"

systemctl start backend &>>$LOG_FILE_NAME
VALIDATE $? "start backend"

systemctl enable backend &>>$LOG_FILE_NAME
VALIDATE $? "enable baclend"


