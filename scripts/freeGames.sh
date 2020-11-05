GAME="s 3"
#Does not include HB
freeEpicUPlayOriginHB () {
FREE=$(curl -s 'https://www.gamerpower.com/giveaways/pc/free-games' \
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
  |  tr '<' '\n' | sed -n 's/.*alt="Free \([^"]*\).*/\1/gp' | head -n 1 | sed -n "/$GAME/p" )
  if [[ "$FREE" == "" ]] ; then
    notify-send "Some Free Game";
    echo "Some Free Game";
  fi

}


#Includes HB
freeSteam() {
  FREE=$(curl --connect-timeout 2 -s https://steamcommunity.com/groups/freegamesfinders/rss/  | sed -n '/title.*\(in Steam\|on Steam\|from Humble Bundle\)/Ip' | head -n 1 | sed -n '/: Cl/p' )
  if [[ "$FREE" == "" ]] ; then
    notify-send "Steam Free Game";
    echo "Steam Free Game";
  fi
}

ping -q -W 2 8.8.8.8 -c 2 #Check Connection

freeEpicUPlayOriginHB

freeSteam
