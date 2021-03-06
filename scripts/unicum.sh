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
mydriver.quit()
"
)
NO_HWR=$(echo "$SITE" | sed 's|HWR Berlin</a></div><div class="_30n_">Berlin||g' |  sed 's/HWRBerlin//g')
NO_FU=$(echo "$NO_HWR" | sed 's/Freie Universität Berlin//g')
BERLIN_TIMES=$(echo "$NO_FU" | sed -n 's/.*Berlin.*/Berlin/p' | wc -l)
if (( $BERLIN_TIMES > 0 )); then
    notify-send "Look Unicum Bag"
fi

