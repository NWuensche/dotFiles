freeEpic() {
  FREE=$(curl --connect-timeout 2 -s https://www.freegamekeys.com/epic-games-store/ --compressed | sed -n '/Check Giveaway/p' | head -n 1 | sed -n '/Cause 4/p' ) #If DISTRAINT isn't the latest free game anymore, then notify me
  if [[ "$FREE" == "" ]] ; then
    notify-send "Epic Store Free Game";
  fi
}

freeGOG() {
  FREE=$(curl --connect-timeout 2 -s https://www.freegamekeys.com/gog/ --compressed | sed -n '/Check Giveaway/p' | head -n 1 | sed -n '/SYMM/p' ) #If DISTRAINT isn't the latest free game anymore, then notify me
  if [[ "$FREE" == "" ]] ; then
    notify-send "GOG Free Game";
  fi
}

freeUPlayUbisoft() {
  FREE=$(curl --connect-timeout 2 -s https://www.freegamekeys.com/uplay/ --compressed | sed -n '/Check Giveaway/p' | head -n 1 | sed -n '/Creed 2/p' ) #If DISTRAINT isn't the latest free game anymore, then notify me
  if [[ "$FREE" == "" ]] ; then
    notify-send "UPlay Free Game";
  fi
}

freeHB() {
  # https://www.freegamekeys.com/ does not publish Humblebundle 
  FREE=$(curl --connect-timeout 2 -s https://steamcommunity.com/groups/freegamesfinders/rss/  | sed -n '/title.*from Humble Bundle/Ip' | head -n 1 | sed -n '/Manual Samuel/p' )
  if [[ "$FREE" == "" ]] ; then
    notify-send "Humblebundle Free Game";
  fi
}

freeOrigin() {
  FREE=$(curl --connect-timeout 2 -s https://www.freegamekeys.com/origin/ --compressed | sed -n '/Check Giveaway/p' | head -n 1 | sed -n '/Access: 1 Month/p' ) #If DISTRAINT isn't the latest free game anymore, then notify me
  if [[ "$FREE" == "" ]] ; then
    notify-send "Origin Free Game";
  fi

}

freeSteam() {
  FREE=$(curl --connect-timeout 2 -s https://steamcommunity.com/groups/freegamesfinders/rss/  | sed -n '/title.*from Steam/Ip' | head -n 1 | sed -n '/The Search/p' )
  if [[ "$FREE" == "" ]] ; then
    notify-send "Steam Free Game";
  fi
}

ping -q -W 2 8.8.8.8 -c 2 #Check Connection

freeEpic
freeGOG
freeUPlayUbisoft
freeHB
freeOrigin
freeSteam
