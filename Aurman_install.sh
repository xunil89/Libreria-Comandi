#!/bin/bash

# IMPORTANTE
# Se stai leggendo questo messaggio
# e non hai aperto volontariamente il programma con un editor di testo
# devi uscire; quindi premere con il tasto destro del mouse sopra al file,
# cliccare proprietà, selezionare permessi ed abilitare CONSENTI L'ESECUZIONE DEL FILE.
# Altrimenti puoi aprire un terminale, dirigerti nella cartella che contiene il file "cd ~/Scrivania"
# e digitare "chmod +x nomefile"

 ##SORGENTI##
link_aurman="https://github.com/polygamma/aurman/archive/master.zip"
############
function install_program()
{
	sudo pacman -Su wget unzip
}

function check_programm()
{
	echo "Controllo presenza programmi..."
	echo ""
	wget_c
	unzip_c
	
	if [ $prog == 2 ]; then
		echo -e "$GREEN Tutti i programmi supplementari sono presenti $Z"
		echo "Attenti..."
		sleep 7
	elif [ $prog -ge 1 ]; then
		echo "Alcuni programmi supplementari non sono presenti"
		read -p "Vuoi installarli  (Tali programmi sono FONDAMNETALI) [S\n]" sel
		if [[ $sel = @(n|N) ]]; then
			echo "Chiusura script"
			exit
		elif [[ $sel = @(s|S) ]]; then
			install_program
		else
			install_program
		fi
		sel=""
		sleep 3
	else
		echo -e "$RED Tutti i programmi supplementari non sono prensenti $Z"
		read -p "Vuoi installarli  (Tali programmi sono FONDAMNETALI) [S\n]" sel
		if [[ $sel = @(n|N) ]]; then
			echo "Chiusura script"
			exit
		elif [[ $sel = @(s|S) ]]; then
			install_program
		else
			install_program
		fi
		sel=""
		sleep 3
	fi

}

function wget_c()
{
	if which wget &>/dev/null; then
		prog=$(($prog+1))
		wget=1
		echo -e "Wget............................[$GREEN OK $Z]"
	else
		wget=0
		echo -e "Wget..........................[$RED FAIL $Z]"
	fi
}

function unzip_c()
{
	if which unzip &>/dev/null; then
		prog=$(($prog+1))
		wget=1
		echo -e "Unzip............................[$GREEN OK $Z]"
	else
		wget=0
		echo -e "Unzip..........................[$RED FAIL $Z]"
	fi
}

function install_aurman()
{
	echo "Installazione Aurman da GitHub"
	echo "Attenti..."
	sleep 2
	mkdir /home/$USER/.temp/
	mkdir /home/$USER/.temp/libreria_comandi
	mkdir /home/$USER/.temp/libreria_comandi/aurman
	cd /home/$USER/.temp/libreria_comandi/aurman
	wget $link_aurman
	unzip master.zip
	cd /home/manuel/.temp/libreria_comandi/aurman/aurman-master
	makepkg -s
	sudo pacman -U aurman-git*
	cd
	echo "Pulizia"
	echo "Attenti..."
	sleep 2
	rm -rf /home/$USER/.temp/libreria_comandi
}

check_programm
install_aurman
