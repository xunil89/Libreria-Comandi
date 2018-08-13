#!/bin/bash

# IMPORTANTE
# Se stai leggendo questo messaggio
# e non hai aperto volontariamente il programma con un editor di testo
# devi uscire; quindi premere con il tasto destro del mouse sopra al file,
# cliccare proprietà, selezionare permessi ed abilitare CONSENTI L'ESECUZIONE DEL FILE.
# Altrimenti puoi aprire un terminale, dirigerti nella cartella che contiene il file "cd ~/Scrivania"
# e digitare "chmod +x nomefile"

##COLORI##
RED="\e[0;31m"
GREEN="\e[0;32m"
BLUE="\e[0;34m"
YELLOW="\e[1;33m"
Z="\e[0m"

##SORGENTE##
link="https://raw.githubusercontent.com/xunil89/Libreria-Comandi/master/Libreria_comandi.sh"
link_zip="https://github.com/xunil89/Libreria-Comandi/archive/master.zip"
############

##CARTELLE PROGRAMMA##
master_dir="/usr/share/libreria_comandi"
log_dir="/var/log/libreria_comandi"
temp_dir="/home/$USER/.temp"
log_dir="/var/log"
#bin_dir="/usr/bin"


function Controlla_aggiornamenti()
{
	cd /home/$USER
	mkdir .temp
	cd /home/$USER/.temp
	wget $link
	cd
	md5=$( md5sum /usr/share/libreria_comandi/Libreria_comandi.sh | awk '{print $1}' )
	md5_1=$( md5sum /home/$USER/.temp/Libreria_comandi.sh | awk '{print $1}' )
	if [ $md5 == $md5_1 ]; then
		echo -e "$GREEN Hai già l'ultima versione $Z"
		rm -f /home/$USER/.temp/Libreria_comandi.sh
		rmdir /home/$USER/.temp
		echo "Ritorno alla schermata iniziale tra 7 Sec"
		sleep 7	
	else
		echo -e "$RED Aggiornamento disponibile $Z"
		echo -e "$GREEN Versione attuale $Z"
		sed -n '15p' /usr/share/libreria_comandi/Libreria_comandi.sh
		echo -e "$GREEN Versione disponibile $Z" 
		sed -n '15p' /home/$USER/.temp/Libreria_comandi.sh
		sel="S"
		read -p "Proseguire con l'aggiornamento [S\n] " sel
			if [[ $sel = @(n|N) ]]; then
				echo -e "$RED Aggiornamento NON ESEGUITO $Z"
				rm -f /home/$USER/.temp/Libreria_comandi.sh
				rmdir /home/$USER/.temp
				echo "Ritorno alla schermata iniziale tra 3 Sec"
				sleep 3
			elif [[ $sel = @(s|S) ]]; then
				echo -e "$GREEN Aggiornamento in corso... $Z"
				Update_lib
				md5=$( md5sum /usr/share/libreria_comandi/Libreria_comandi.sh | awk '{print $1}' )
				#########################################
				####correzione  errore temporaneo di setup
				############################################
				cd /home/$USER
				mkdir .temp
				cd /home/$USER/.temp
				wget $link
				cd
				#######################################
				md5_1=$( md5sum /home/$USER/.temp/Libreria_comandi.sh | awk '{print $1}' )
				if [ $md5 == $md5_1 ]; then
					echo -e "$GREEN Aggiornamento completato... $Z"
					echo -e "$RED Riavviare lo script per completare l'aggiornamento $Z"
					rm -f /home/$USER/.temp/Libreria_comandi.sh
					rmdir /home/$USER/.temp
					echo "Ritorno alla schermata iniziale tra 3 Sec"
					sleep 3
				else
					echo -e "$RED Aggiornamento non riuscito $Z"
					echo "Ritorno alla schermata iniziale tra 3 Sec"
					sleep 3
				fi
			else
				Controlla_aggiornamenti
			fi
				sel=""
	fi
	
	exit
}

function Update_lib()
{
	cd
	"$master_dir/Setup.sh"
	sleep 3
	cd
	#cd /home/$USER/.temp
	#wget $link_zip
	#unzip master.zip
	
	##########
	#cd /home/$USER
	#mkdir /home/$USER/.temp
	#cd /home/$USER/.temp
	#wget $link
	#chmod +x Libreria_comandi.sh
	#echo -e "$GREEN Consentire la sovrascrittura per aggiornare $Z"
	#cp -i Libreria_comandi.sh $bin_dir
	#rm -f /home/$USER/.temp/Libreria_comandi.sh
	#rmdir /home/$USER/.temp
	#cd /home/$USER
	#'/home/$USER/Libreria_comandi.sh'
	#cd
	rm -rf /home/$USER/.temp
}
Controlla_aggiornamenti
