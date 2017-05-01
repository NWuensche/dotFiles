# Lege dieses Skript in den Ordner mit den Videos, benenne die Videos entsprechend ihres Datums um und starte das Skript
for i in *.mp4; do
  #Dateiendung weg
  name=`echo $i | cut -d'.' -f1`;
  #Jede Datei mit Endung auf 1s kürzen, Unten links videotitle anzeigen und hintergrund des Texts transarent machen, New Datei speichern, da bei überschreiben Probleme mit ffmpeg
  ffmpeg -i $i -t 1 -filter:v "drawtext=fontsize=30:box=1:fontfile=/usr/share/fonts/TTF/Vera.ttf:text=$name:x=50:y=(h-text_h-line_h):boxcolor=black@0.0:fontcolor=white" New$name.mp4;
  # Neue Datei wieder in alte umbenennen
  trash $name.mp4;
  mv New$name.mp4 $name.mp4;
  # .mp4 in .ts umwandeln, da sich .mp4 Datein schlecht concaten lassen
  ffmpeg -i $name.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts $name.ts;
  trash $name.mp4;
  # Alle Datein in Textdatei, damit diese später concatet werden
  echo "file $name.ts" >> concat.txt;
done
# Alle Videos in ein Video
ffmpeg -f concat -i concat.txt -c copy output.mp4;

#Aufräumen
for i in *.ts; do
    trash $i;
done
trash concat.txt;
