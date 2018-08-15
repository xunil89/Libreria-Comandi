#!/bin/bash

# IMPORTANTE
# Se stai leggendo questo messaggio
# e non hai aperto volontariamente il programma con un editor di testo
# devi uscire; quindi premere con il tasto destro del mouse sopra al file,
# cliccare proprietà, selezionare permessi ed abilitare CONSENTI L'ESECUZIONE DEL FILE.
# Altrimenti puoi aprire un terminale, dirigerti nella cartella che contiene il file "cd ~/Scrivania"
# e digitare "chmod +x nomefile"

#########################################################
####RICONOSCIMENTI#######################################
#########################################################

riconoscimenti="Libreria comandi By Mac89				          v$ver"

#########################################################
####FUNZIONI GESTIONALI##################################
#########################################################

##COLORI##
RED="\e[0;31m"
GREEN="\e[0;32m"
BLUE="\e[0;34m"
YELLOW="\e[1;33m"
Z="\e[0m"

##SORGENTE##
link="https://raw.githubusercontent.com/xunil89/Libreria-Comandi/master/Libreria_comandi.sh"
############

##CARTELLE PROGRAMMA##
master_dir="/usr/share/libreria_comandi"
log_dir="/var/log/libreria_comandi"
temp_dir="/home/$USER/.temp"
log_dir="/var/log"
bin_dir="/usr/bin"


function check_prog_auto()
{
	if which sudo &>/dev/null; then
		sudo=1
		prog=1
	else
		sudo=0
	fi

	if which paccache &>/dev/null; then
		paccache=1
		prog=$(($prog+1))
	else
		paccache=0
	fi

	if which bleachbit &>/dev/null; then
		prog=$(($prog+1))
		bleachbit=1
	else
		bleachbit=0
	fi
	
	if which axel &>/dev/null; then
		prog=$(($prog+1))
		axel=1
	else
		axel=0
	fi

	if which aurman &>/dev/null; then
		prog=$(($prog+1))
		aurman=1
	else
		aurman=0
	fi
	
	if which wget &>/dev/null; then
		prog=$(($prog+1))
		wget=1
	else
		wget=0
	fi
	
	if which md5sum &>/dev/null; then
		prog=$(($prog+1))
		md5sum=1
	else
		md5sum=0
	fi
}

#########################################################
####FUNZIONI#############################################
#########################################################

###CONTROLLO SINGOLARMENTE DEI PROGRAMMI INSTALLATI###

function sudo_c()
{
	if which sudo &>/dev/null; then
		sudo=1
		prog=1
		echo -e "Sudo..............................[$GREEN OK $Z]"
	else
		sudo=0
		prog=0
		echo -e "Sudo............................[$RED FAIL $Z]"
	fi
}

function paccache_c()
{
	if which paccache &>/dev/null; then
		paccache=1
		prog=$(($prog+1))
		echo -e "Paccache..........................[$GREEN OK $Z]"
	else
		paccache=0
		echo -e "Paccache........................[$RED FAIL $Z]"
	fi
}

function axel_c()
{
	if which axel &>/dev/null; then
		axel=1
		prog=$(($prog+1))
		echo -e "Axel..............................[$GREEN OK $Z]"
	else
		paccache=0
		echo -e "Axel..............................[$RED FAIL $Z]"
	fi
}

function bleachbit_c()
{
	if which bleachbit &>/dev/null; then
		prog=$(($prog+1))
		bleachbit=1
		echo -e "Bleachbit.........................[$GREEN OK $Z]"
	else
		bleachbit=0
		echo -e "Bleachbit.......................[$RED FAIL $Z]"
	fi
}

function aurman_c()
{
	if which aurman &>/dev/null; then
		prog=$(($prog+1))
		aurman=1
		echo -e "Aurman............................[$GREEN OK $Z]"
	else
		aurman=0
		echo -e "Aurman..........................[$RED FAIL $Z]"
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

function md5sum_c()
{
	if which md5sum &>/dev/null; then
		prog=$(($prog+1))
		md5sum=1
		echo -e "Md5sum............................[$GREEN OK $Z]"
	else
		md5sum=0
		echo -e "Md5sum..........................[$RED FAIL $Z]"
	fi
}

###CONTROLLO PROGRAMMI FINE###

###installazione PROGRAMMI FINE###

function install_program()
{
	total=$(($aurman+$bleachbit+$paccache+$sudo+$axel+$wget+$md5sum))
	read -p "Vuoi installare tutti i programmi mancanti [S\n] " sel
	if [[ $sel = @(s|S) ]]; then
		if [[ $aurman == 0 ]]; then
			install_aurman_script
		fi
		if [[ $bleachbit == 0 ]]; then
			sudo pacman -S bleachbit
		fi
		if [[ $paccache == 0 ]]; then
			sudo pacman -S paccache
		fi
		if [[ $sudo == 0 ]]; then
			sudo pacman -S sudo
		fi
		if [[ $axel == 0 ]]; then
			sudo pacman -S axel
		fi
		if [[ $wget == 0 ]]; then
			sudo pacman -S wget
		fi
		if [[ $md5sum == 0 ]]; then
			sudo pacman -S isomd5sum
		fi
		
	elif [[ $sel = @(n|N) ]]; then
		if [[ $aurman == 0 ]]; then
			read -p "Vuoi installare Aurman [S\n] " sel
			if [[ $sel = @(s|S) ]]; then
				install_aurman_script
			else
				echo -e "$RED Aurman non verrà installato $Z"
			fi
		fi
		if [[ $bleachbit == 0 ]]; then
			read -p "Vuoi installare Bleachbit [S\n] " sel
			if [[ $sel = @(s|S) ]]; then
				sudo pacman -S bleachbit
			else
				echo -e "$RED Bleachbit non verrà installato $Z"
			fi
		fi
		if [[ $paccache == 0 ]]; then
			read -p "Vuoi installare Paccache [S\n] " sel
			if [[ $sel = @(s|S) ]]; then
				aurman -S pacman-cleanup-hook
			else
				echo -e "$RED Paccache non verrà installato $Z"
			fi
		fi
		if [[ $sudo == 0 ]]; then
			read -p "Vuoi installare Sudo [S\n] " sel
			if [[ $sel = @(s|S) ]]; then
				sudo pacman -S sudo
			else
				echo -e "$RED Sudo non verrà installato $Z"
			fi
		fi
		if [[ $axel == 0 ]]; then
			read -p "Vuoi installare Axel [S\n] " sel
			if [[ $sel = @(s|S) ]]; then
				sudo pacman -S axel
			else
				echo -e "$RED Axel non verrà installato $Z"
			fi
		fi
		if [[ $wget == 0 ]]; then
			read -p "Vuoi installare Wget[S\n] " sel
			if [[ $sel = @(s|S) ]]; then
				sudo pacman -S wget
			else
				echo -e "$RED Wget non verrà installato $Z"
			fi
		fi
		if [[ $md5sum == 0 ]]; then
			read -p "Vuoi installare md5sum (FONDAMNETALE PER GLI AGGIORNAMENTI DELLO SCRIPT)[S\n] " sel
			if [[ $sel = @(s|S) ]]; then
				sudo pacman -S isomd5sum
			else
				echo -e "$RED Md5sum non verrà installato $Z"
			fi
		fi
	fi
}
#############################

function check_programm() #Controlla i programmi installati ed eventualmente li installa
{
	cancel
	echo "Controllo presenza programmi..."
	echo ""
	sudo_c
	paccache_c
	bleachbit_c
	aurman_c
	axel_c
	wget_c
	md5sum_c
	if [ $prog == 7 ]; then #Ricordare di aumentare il contatore quando si aggiungono software
		echo -e "$GREEN Tutti i programmi supplementari sono presenti $Z"
		echo "Attenti..."
		sleep 7
		
	elif [ $prog -ge 1 ]; then
		echo "Alcuni programmi supplementari non sono presenti"
		read -p "Vuoi installarli [S\n]" sel
		if [[ $sel = @(n|N) ]]; then
			echo "Alcune funzioni dello script saranno disabilitate"
		elif [[ $sel = @(s|S) ]]; then
			install_program
		else
			install_program
		fi
		sel=""
		sleep 3
		
	else
		echo -e "$RED Tutti i programmi supplementari non sono prensenti $Z"
		read -p "Vuoi installarli [S\n]" sel
		if [[ $sel = @(n|N) ]]; then
			echo "Alcune funzioni dello script saranno disabilitate"
		elif [[ $sel = @(s|S) ]]; then
			install_program
		else
			install_program
		fi
		sel=""
		sleep 3
		
	fi

}

function install_aurman_script()
{
	cd 
	"$master_dir/Aurman_install.sh"
	returne
}

check_prog_auto
check_programm

