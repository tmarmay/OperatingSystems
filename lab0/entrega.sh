#!bin/bash
#1) 
cat /proc/cpuinfo | grep model | head -n 2

#2)
cat /proc/cpuinfo | grep "model name" | wc -l

#3) 
wget https://raw.githubusercontent.com/andergd/separadorSilabas/master/Carroll%2C%20Lewis%20-%20Alicia%20En%20El%20Pa%C3%ADs%20De%20Las%20Maravillas.txt && mv 'Carroll, Lewis - Alicia En El País De Las Maravillas.txt' tomas_en_el_pais_de_las_maravillas.txt && sed -i 's/Alicia/Tomas/g' tomas_en_el_pais_de_las_maravillas.txt 	

#4) 
sort -k 4 -n test.in -o weather_cordoba_sorted.in && cat weather_cordoba_sorted.in | head -n 1 | cut -b -10 && cat weather_cordoba_sorted.in | tail -n 1 | cut -b -10

#5) 
sort -k 3 -n atpplayers.in -o atpplayers_sorted.in

#6) 
awk '{print $1 " " $2 " " $3 " " $4 " " $5 " " $6 " " $7 " " $7 -$8}' superliga.in | sort -r -n -k 2 -k 9 | awk '{print $1 " " $2 " " $3 " " $4 " " $5 " " $6 " " $7}'

#7) 
ip addr | grep link/ether | awk '{print $2}'

#8) 
mkdir friends && touch friends/fma_S01E{1..10}_es.srt
for name in *; do newname=`echo $name | cut -c -10` && mv $name $newname.srt ; done
