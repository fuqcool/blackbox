#!/bin/bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied."
    exit 1
fi

FILE=$1
ENCRYPT_METHOD=-aes-256-cbc

export PASSWORD

if [ ! -f $FILE ]; then
    read -s -p "Please setup your password: " PASSWORD
    echo
    echo "Anything you put in here will be encrypted. Shhhhh...." > $FILE.tmp
else
    read -s -p "Please enter your password: " PASSWORD
    echo
    openssl enc $ENCRYPT_METHOD -d -in $FILE -pass "env:PASSWORD" > $FILE.tmp

    RESULT=$?
    if [ ! $RESULT -eq 0 ]; then
        echo "Cannot open decrypted file."
        rm $FILE.tmp
        exit 1
    fi
fi

DATE_BEFORE=$(stat -f "%Sm" $FILE.tmp)
vim $FILE.tmp
DATE_AFTER=$(stat -f "%Sm" $FILE.tmp)

if [ "$DATE_BEFORE" = "$DATE_AFTER" ]; then
    rm $FILE.tmp
    echo "No changes made, exit."
    exit 0
fi

RESULT=$?
if [ $RESULT -eq 0 ]; then
    echo "Encrypt $FILE ..."
    openssl enc $ENCRYPT_METHOD -in $FILE.tmp -out $FILE -pass "env:PASSWORD"
fi
if [ -f $FILE.tmp ]; then
    rm $FILE.tmp
fi

unset PASSWORD
echo "Done."
