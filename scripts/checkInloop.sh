#!/bin/bash

git fetch origin
git rebase origin/master
echo "Make Docker"
make dockerimage > /dev/null
echo "Run Docker"
python3 run_docker.py 2>&1| grep "Failed tasks:" | awk '{print "Docker: " $1}'
echo "Run Gradle"
./gradlew clean test 2>&1| grep "BUILD" | awk '{print "Gradle: " $1" "$2}'
