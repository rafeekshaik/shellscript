#!/bin/bash

USERID=(id -u)
if [ $USERID -ne 0 ]
then
echo "error: user must have previllaged access"
exit 1

dnf list installed mysql
if [ $? -ne 0 ]
    then
    dnf install mysql -y
    if [ $? -ne 0 ] 
    then 
    echo "installing mysql.... is failure"
    exit 1
    else
    echo "installing mysql.... is successfull"
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
    echo "installing git ..... failure"
    exit 1
    else
    echo "insatlling git .... successfully"
    fi
else
echo "git allrey installed"
fi