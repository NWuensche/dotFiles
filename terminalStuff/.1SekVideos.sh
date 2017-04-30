# Lege dieses Skript in den Ordner mit den Videos, benenne die Videos entsprechend ihres Datums um und starte das Skript
for i in *.mp4; do
  #Dateiendung weg
  name=`echo $i | cut -d'.' -f1`;
  ffmpeg -i $i -t 1 -filter:v "drawtext=fontsize=30:box=1:fontfile=/usr/share/fonts/TTF/Vera.ttf:text=$name:x=50:y=(h-text_h-line_h):boxcolor=black@0.0:fontcolor=white" New$name.mp4;
  trash $name.mp4;
  mv New$name.mp4 $name.mp4;
  ffmpeg -i $name.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts $name.ts;
  trash $name.mp4;
  echo "file $name.ts" >> concat.txt;
done
ffmpeg -f concat -i concat.txt -c copy output.mp4;

for i in *.ts; do
    trash $i;
done
trash concat.txt;
