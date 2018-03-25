#!/bin/bash
#length=$(curl https://twitter.com/jExamUpdates | grep "Beep boop" | wc -l ); 
length=$(curl http://feeds.feedburner.com/jExam\? | awk -F'description' '{print $3}' | awk -F'Die Modul' '{print $1}' | tr ' ' '\n' |grep INF-B -c)
if [ $length -gt 5 ]
then 
    notify-send -t 10000000 "JEXAM" "Neu"
fi

