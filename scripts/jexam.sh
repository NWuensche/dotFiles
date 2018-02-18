#!/bin/bash
length=$(curl https://twitter.com/jExamUpdates | grep "Beep boop" | wc -l ); 
if [ $length -gt 17 ]
then 
    notify-send "JEXAM" "Neu"
fi

