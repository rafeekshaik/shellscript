#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0]
then
echo "error::user must have previllaged admin access"
exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then 
dnf install mysql -y
if [ $? -ne 0 ]
then 
echo "instaling mysql is........ failure"
exit 1
fi
else
echo "installing mysql .....success"
exit 1
fi
else 
echo "mysql is allready installed"
fi

    dnf list installed git

    if [ $? -ne 0 ]
    then
    dnf install git -y
    if [ $? -ne 0 ]
    then
    echo "installing git is a failure"
    exit 1
    fi
    else
    echo "installing git is success"
    exit 1
    fi
    else
    echo "git is allready installed"
    fi