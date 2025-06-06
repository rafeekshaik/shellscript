#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then 
echo "ERROR::user must have previllaged admin access"
exit 1
fi

dnf list installed mysql
    if [ $? -ne 0 ]
    then
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
    echo "installing mysql ....is failure"
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
        echo "insatlling git.....if failure"
        exit 1
        else
        echo "installing git .... successfull"
        fi
    else
    echo "git allready installed"
    fi
    