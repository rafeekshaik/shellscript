#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shellscript-logs"
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

dnf install mysql-server -y
VALIDATE $? "INSTALLING MYSQL SERVER"

systemctl enable mysqld
VALIDATE $? "ENABLING MYSQL SERVER"

systemctl start mysqld
VALIDATE $? "STARTING MYSQL SERVER"

mysql -h mysql.daws17s.online -uroot -pExpenseApp@1 'show databases;'
if [ $? -ne 0 ]
then 
mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE $? "setting up root password"
else 
echo -e "root password allresy setup..... $G skipping $Y"
fi