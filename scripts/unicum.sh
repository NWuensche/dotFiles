#!/bin/sh
SITE=$(
python -c "
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException

baseurl = 'https://www.facebook.com/pg/unicum.de/events/?ref=page_internal'

options = webdriver.ChromeOptions()
options.add_argument('headless')

mydriver = webdriver.Chrome(options=options)

mydriver.get(baseurl)

print(mydriver.page_source)
"
)
BERLIN_TIMES=$(echo "$SITE" | sed -n 's/.*Berlin.*/Berlin/p' | wc -l)
if (( $BERLIN_TIMES > 0 )); then
    notify-send "Look Unicum Bag"
fi

