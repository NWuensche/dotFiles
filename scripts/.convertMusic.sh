#So oft, weil jedes Rename nur 1x in einem Namen wirkt
rename " " "_" *;
rename " " "_" *;
rename " " "_" *;
rename " " "_" *;
rename " " "_" *;
rename " " "_" *;
rename " " "_" *;


for i in *.m4a; do
    name=`echo $i | cut -d'.' -f1`;
    ffmpeg -i $i $name.mp3;
    trash $i;
done

#So oft, weil jedes Rename nur 1x in einem Namen wirkt
rename "_" " " *;
rename "_" " " *;
rename "_" " " *;
rename "_" " " *;
rename "_" " " *;
rename "_" " " *;
rename "_" " " *;


