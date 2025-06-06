#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
VALIDATE(){
      if [ $1 -ne 0 ]
    then 
    echo -e "$2 ....... is $R failure $N"
    exit 1
    else
    echo -e "$2 ....... is  $G success $N"
    fi
}
if [ $USERID -ne 0 ]
then 
echo "ERROR:user must have previllaged admin access"
exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then 
    dnf install mysql -y
   VALIDATE $? "INSTALLING MYSQL"
else
echo "mysql is allredy installed"
fi


dnf list installed git

if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "INSTALLING GIT"
else
echo -e "git allready $Y installed  $N"
fi