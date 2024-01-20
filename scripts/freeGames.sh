GAME="LOVE"
set -e # to stop on failing ping
#Does not include HB
freeEpicUPlayOriginHB () {
FREE=$(curl -s -L 'http://www.gamerpower.com/giveaways/pc/free-games' \
  -H 'authority: www.gamerpower.com' \
  -H 'cache-control: max-age=0' \
  -H 'dnt: 1' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-user: ?1' \
  -H 'sec-fetch-dest: document' \
  -H 'accept-language: de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7' \
  --compressed \
  | tr '<' '\n' | grep 'thumbnail.*alt' | grep -iv 'Black Desert Online' | grep -iv 'Microsoft Store' |  grep -iv 'Opera Gx' | grep -iv 'Indiegaka' | grep -iv 'Indieg' | grep -iv 'Indiegala' | grep -iv 'Indie Gala' | grep -iv 'itchio' | grep -iv 'itch.io' | grep -iv 'itchi.o' | head -n 1 | sed -n "/$GAME/p" ) #INFO Don't show anything from Indiegala or itchio
  if [[ "$FREE" == "" ]] ; then
    notify-send "Some Free Game";
    echo "Some Free Game"
  fi


}


#Includes HB
freeSteam() {
  FREE=$(curl --connect-timeout 2 -s https://steamcommunity.com/groups/freegamesfinders/rss/  | sed -n '/title.*\(in Steam\|in the Steam\|on Steam\|from Humble Bundle\)/Ip' | head -n 1 | sed -n '/Seven/p' )
  if [[ "$FREE" == "" ]] ; then
    notify-send "Steam Free Game";
    echo "Steam Free Game";
  fi
}

ping -q -W 2 8.8.8.8 -c 2 #Check Connection

freeEpicUPlayOriginHB

#freeSteam Defect no Steam/HB game + Didn't find anything new (wrt gamerpower website)  in ~6Months
