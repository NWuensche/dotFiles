#!/bin/bash

git fetch origin
git rebase origin/master
echo "Make Docker..."
make dockerimage > /dev/null
echo "Run Docker..."
DOCKER=$(python3 run_docker.py BasicLibrary 2>&1| grep "Failed tasks:")
if [ -n "$DOCKER" ]; then
    echo "Docker: BUILD FAILED"
else
    echo "Docker: BUILD SUCCESSFUL"
fi
echo "Run Gradle..."
./gradlew clean test 2>&1| grep "BUILD" | awk '{print "Gradle: " $1" "$2}'
