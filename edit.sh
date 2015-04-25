#!/bin/bash

FILE=$1
export PASSWORD

if [ ! -f $FILE ]; then
    read -s -p "Welcome to XXX, please set your password: " PASSWORD
    echo
    echo "This file will be encrypted." > $FILE.tmp
else
    read -s -p "Please enter your password: " PASSWORD
    echo
    openssl enc -aes-256-cbc -d -in $FILE -pass "env:PASSWORD" > $FILE.tmp

    RESULT=$?
    if [ ! $RESULT -eq 0 ]; then
        echo "Cannot open decrypted file."
        rm $FILE.tmp
        exit 1
    fi
fi

vim $FILE.tmp

RESULT=$?
if [ $RESULT -eq 0 ]; then
    echo "Encrypt $FILE ..."
    openssl enc -aes-256-cbc -in $FILE.tmp -out $FILE -pass "env:PASSWORD"
fi
if [ -f $FILE.tmp ]; then
    rm $FILE.tmp
fi

echo "Done."
