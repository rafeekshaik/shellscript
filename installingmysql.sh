#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE(){

 if [ $1 -ne 0 ]
    then
    echo -e "$2 is........ $R failure"
    exit 1

    else
    echo -e "$2 .....$G success"
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
echo -e "mysql is allready  $Y installed"
fi

    dnf list installed git

        if [ $? -ne 0 ]
        then
        dnf install git -y
       VALIDATE $? "INSTALLING GIT"

    else
    echo -e "git is  $Y allready installed"
    fi