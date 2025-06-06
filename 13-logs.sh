#!/bin/bash
USERID=$(id -u)
VALIDATE(){
      if [ $1 -ne 0 ]
    then 
    echo "$2 ....... is failure"
    exit 1
    else
    echo "$2 ....... is success"
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
echo "git allready installed"
fi