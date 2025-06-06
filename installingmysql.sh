#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE(){

 if [ $1 -ne 0 ]
    then
    echo "$2 is........ $R failure"
    exit 1

    else
    echo "$2 .....$G success"
    fi

}

if [ $USERID -ne 0]
then
echo "error::user must have previllaged admin access"
exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then 
dnf install mysql -y
   VALIDATE $? installing mysql
else 
echo "mysql is allready  $Y installed"
fi

    dnf list installed git

        if [ $? -ne 0 ]
        then
        dnf install git -y
       VALIDATE $? "INSTALLING GIT"

    else
    echo "git is  $Y allready installed"
    fi