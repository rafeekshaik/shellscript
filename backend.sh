#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

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

dnf module disable nodejs -y &>>$LOG_FILE_NAME
VALIDATE $? "diabling old nodejs"

dnf module enable nodejs:20 -y &>>$LOG_FILE_NAME
VALIDATE $? "enabling nodejs 20"

dnf install nodejs -y &>>$LOG_FILE_NAME
VALIDATE $? "installing nodejs"

useradd expense &>>$LOG_FILE_NAME
VALIDATE $? "creating expenseuser"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE_NAME
VALIDATE $? "downloading the code"

cd /app
unzip /tmp/backend.zip &>>$LOG_FILE_NAME
VALIDATE $? "unziiping the backend code"

npm install &>>$LOG_FILE_NAME
VALIDATE $? "downloading the dependencies"

cp /home/ec2-user/shellscript/backend.service /etc/systemd/system/backend.service &>>$LOG_FILE_NAME
VALIDATE $? "cpying the backend.service"


dnf install mysql -y &>>$LOG_FILE_NAME
VALIDATE $? "installing mysql client"

mysql -h mysql.daws17s.onlline -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG_FILE_NAME
VALIDATE $? "adding project schemas to database"

systemctl daemon-reload &>>$LOG_FILE_NAME
VALIDATE $? "demon reload"

systemctl start backend &>>$LOG_FILE_NAME
VALIDATE $? "start backend"
 
systemctl enable backend &>>$LOG_FILE_NAME
VALIDATE $? "enable backend"
