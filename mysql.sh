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

dnf install mysql-server -y &>>$LOG_FILE_NAME

 VALIDATE $? "installing mysql server"

systemctl enable mysqld &>>$LOG_FILE_NAME

VALIDATE $? "enabling mysql server"
systemctl start mysqld &>>$LOG_FILE_NAME

VALIDATE $? "START MYSQL SERVER"


mysql -h mysql.daws17s.online -u root -pExpenseApp@1 -e 'show databases;' &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then 
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG_FILE_NAME
VALIDATE $? "setteing up root password succesfuly"
else 
echo -e "root password all ready set up ......$G skipping $Y"
fi