cd MusikDownloads;
for i in *.mp3; do
    artist=`echo $i | cut -d'-' -f1| sed 's/.$//'`; # Alles bis zum -, aber letztes Leerzeichen weg
    title=`echo $i | cut -d'-' -f2| cut -c 2- |cut -d '.' -f1`;# Erstes Zeichen weg, da Leerzeichen, und Dateiendung weg
    ffmpeg -i "$i" -metadata artist="$artist" -metadata title="$title" "New$i";
    trash "$i";
    mv "New$i" "$i";
done
