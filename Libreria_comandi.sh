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

ver=0.6.6
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

function cancel()
{
	clear
	echo $riconoscimenti
	echo ""
}

function returne()
{
	cancel
	inizio
	exit	
}

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
}

function Controlla_aggiornamenti()
{
	"$master_dir/Update_lib.sh"
	returne
}

function Remove_lib()
{
	"$master_dir/Remove_lib.sh"
	returne
}
#########################################################
####FUNZIONI#############################################
#########################################################

###CONTROLLO PROGRAMMI###

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

###CONTROLLO PROGRAMMI FINE###

###VELOCIZZARE PACMAN AXEL###

function SpeedRunPacman()
{
	echo -e "$RED ATTENZIONE!!!$Z sto' per commentare tutte le stringhe 'XferCommand' del file '/etc/pacman.conf'"
	read -p "Posso eseguire :) [S\n] " sel
	if [[ $sel = @(n|N) ]]; then
		echo -e "$GREEN Ok nessun problema l'accelerazione downlad di pacman non'e' stata eseguita $Z"
		sleep 3
		returne
	elif [[ $sel = @(s|S) ]]; then
		sudo sed -i 's/XferCommand/#XferCommand/' /etc/pacman.conf ; sudo sed -i 's/##XferCommand/#XferCommand/' /etc/pacman.conf
		echo -e "$GREEN Commentate stringe 'XferCommand' $Z"
		sleep 3
		sudo sed -i "/^#SyncFirst   =/i\XferCommand = /usr/bin/axel -n 4 -a -o %o %u" /etc/pacman.conf
		echo -e "$GREEN Aggiunta stringa '\XferCommand = /usr/bin/axel -n 4 -a -o %o %u' $Z"
		sleep 3
		returne
	else
		SpeedRunPacman
	fi
	sel=""
}


######PACMAN AXEL FINE#######

######FUNZIONI IGNOREPKG######

function IgnorePkg()
{
	echo "La funzione IgnorePkg evita l'aggiornamento di un pacchetto"
	read -p "Devi aggiungere un pacchetto alla lista IgnorePkg [S\n] " sel
	if [[ $sel = @(n|N) ]]; then
		remove_non_aggiornare_pkg
	elif [[ $sel = @(s|S) ]]; then
		non_aggiornare_pkg
		exit
	else
		IgnorePkg
	fi
	sel=""
}

function non_aggiornare_pkg()
{
	read -p "Vuoi prima cercare l'applicazione [S\n] " sel
	if [[ $sel = @(n|N) ]]; then
		read -p "Digita il nome dell'applicazione da non aggiornare " pkg
		echo "Aggiungo $pkg alla lista dei pachetti non aggiornabili..."
		pacman -Q $pkg >/dev/null &&  c=0 || c=1
		sleep 1
		if [ $c == 0 ]; then
			echo -e "$pkg............................[$GREEN OK $Z]"
			sudo sed -i "/^#IgnorePkg   =$/i\IgnorePkg   = $pkg" /etc/pacman.conf			
		else
			echo -e "$pkg..........................[$RED NON TROVATO $Z]"
			echo -e "Aggiunta........................[$RED FALLITA $Z]"
			non_aggiornare_pkg
		fi
	elif [[ $sel = @(s|S) ]]; then
		read -p "Digita il nome dell'applicazione da cercare " pkg
		pacman -Q $pkg >/dev/null &&  c=0 || c=1
		#if which $pkg &>/dev/null; then
		if [ $c == 0 ]; then
			echo -e "$pkg............................[$GREEN OK $Z]"
			echo "Aggiungo $pkg alla lista dei pachetti non aggiornabili..."
			sleep 1
			sudo sed -i "/^#IgnorePkg   =$/i\IgnorePkg   = $pkg" /etc/pacman.conf			
		else
			echo -e "$pkg..........................[$RED NON TROVATO $Z]"
			non_aggiornare_pkg
		fi
	else
		non_aggiornare_pkg
	fi
	sel=""
	software=""
	pkg=""
	c=""
	returne

}

####FUNZIONI IGNOREPKG FINE####

function remove_non_aggiornare_pkg()
{
	echo "Attualmente i pacchetti presenti nella lista non aggiornabili sono:"
	sed -n '/IgnorePkg/p' /etc/pacman.conf
	read -p "Digita il nome del pkg da rimuovere dalla lista oppure 'q' per uscire " pkg
	if [[ $pkg = @(q|Q) ]]; then
		returne
	else
		sudo sed -i "s/IgnorePkg   = $pkg//g" /etc/pacman.conf
		echo -e "$pkg............................[$GREEN RIMOSSO $Z]"
		sudo sed -i "s/IgnorePkg   = $pkg//g" /etc/pacman.conf
		sleep 3
	fi
	pkg=""
	returne
}

function backup_soft()
{
	cancel
	
	declare -a options
	options[${#options[*]}]="Esegui backup dei pacchetti installati (solo nomi)";
	options[${#options[*]}]="Ripristina backup pacchetti da file backup_soft";
	options[${#options[*]}]="Esci";
	select opt in "${options[@]}"; do
	case ${opt} in
	
	${options[0]}) backup_soft_sal;;
	${options[1]}) backup_soft_rip;;
	${options[2]}) returne;;

	esac;
	done
}

function backup_soft_rip()
{
	cd
	per="/home/Backup_Pacchetti"
	echo "Se lasci il campo vuoto il file verrà prelevato nella cartella home/Backup_Pacchetti"
	read -p "Digita il percorso dove si trova il file pkg_backup " per
	cd $per
	sudo pacman -S $(cat pkg_backup)
	per=""
	cd
}

function backup_soft_sal()
{
	cd
	echo "Se lasci il campo vuoto il file verrà salvato nella tua home"
	read -p "Digita il percorso dove vuoi salvare il file di backup " per
	cd $per
	mkdir Backup_Pacchetti
	cd ~/Backup_Pacchetti
	pacman -Qqe > pkg_backup
	per=""
	cd
}

function install_aurman_script()
{
	cd 
	chmod +x Aurman_install.sh
	"$master_dir/Aurman_install.sh"
	returne
}

function install_program()
{
	total=$(($aurman+$bleachbit+$paccache+$sudo+$axel+$wget))
	read -p "Vuoi installare tutti i programmi mancanti [S\n] " sel
	if [[ $sel = @(s|S) ]]; then
		if [[ $aurman == 0 ]]; then
			echo "funzione non attiva"
			#su -c'
			#echo "" >> /etc/pacman.conf
			#echo "#Aurman"  >> /etc/pacman.conf
			#echo "[archlinuxfr]" >> /etc/pacman.conf
			#echo "SigLevel = Optional TrustAll"  >> /etc/pacman.conf
			#echo "Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
			#'
			#sudo pacman -S Aurman
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
		
	elif [[ $sel = @(n|N) ]]; then
		if [[ $aurman == 0 ]]; then
			read -p "Vuoi installare Aurman [S\n] " sel
			if [[ $sel = @(s|S) ]]; then
				install_aurman
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
				sudo pacman -S paccache
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
	fi
}

function install_pacman()
{
	read -p "Vuoi prima cercare l'applicazione [N\s]" sel
	if [[ $sel = @(n|N) ]]; then
		read -p "Digita il nome dell'applicazione da installare " software
		sudo pacman -S $software
	elif [[ $sel = @(s|S) ]]; then
		read -p "Digita il nome dell'applicazione da cercare " software
		pacman -Ss $software
		read -p "Digita il nome dell'applicazione da installare " software
		sudo pacman -S $software
	else
		install_pacman
	fi
	sel=""
	software=""
	returne
}

function install_aurman()
{
	aurman_c
	if [ $aurman == 1 ]; then
		read -p "Digita il nome dell'applicazione da installare " software
		aurman -S $software
		software=""
		returne
	else
		echo -e "$BLUE Mi dispiace il software Aurman non è installato $Z"
		echo "Ritorno alla schermata iniziale tra 7 Sec"
		sleep 7
		returne
	fi
}

function agg_aurman()
{
	aurman_c
	if [ $aurman == 1 ]; then
		echo "Aggiornamento S.O. con Aurman..."
		sudo aurman -Syu
		returne
	else
		echo -e "$BLUE Mi dispiace il software Aurman non è installato $Z"
		echo "Ritorno alla schermata iniziale tra 7 Sec"
		sleep 7
		returne
	fi
}

function agg_pacman()
{
	echo "Aggiornamento S.O. con pacman..."
	sudo pacman -Syu
	returne
}

function pacman_ott()
{
	echo "Ottimizzazione database pacman..."
	sudo pacman-optimize
	returne
}

function cache_del_paccache()
{
	paccache_c
	if [ $paccache == 1 ]; then
		echo "Rimozione cache pacchetti pacman (Paccache)..."
		sudo paccache -rvk1
		echo "Ritorno alla schermata iniziale tra 7 Sec"
		sleep 7
		returne
	else
		echo -e "$BLUE Mi dispiace il software Paccache non è installato $Z"
		echo "Ritorno alla schermata iniziale tra 7 Sec"
		sleep 7
		returne
	fi
}

function cache_aurman_del()
{
	echo "Rimozione cache pacman/aurman..."
	aurman -Sc
	returne
}

function cache_del()
{
	echo "Rimozione cache pacman..."
	sudo pacman -Sc
	returne
}

function cache_del_full()
{
	echo "Rimozione totale della cache pacman..."
	sudo pacman -Scc
	returne
}

function remove_orfan()
{
	echo "Rimozione pacchetti orfani"
	sudo pacman -Rs $(pacman -Qtdq)
	returne
}

function rapid_cleen()
{
	echo "Rimozione cache pacchetti pacman (Paccache)..."
	sleep 2
	sudo paccache -rvk1
	sleep 1
	echo "Rimozione cache pacman..."
	sleep 2
	sudo pacman -Sc
	echo "Ottimizzazione database pacman..."
	sleep 2
	sudo pacman-optimize
	sleep 1
	returne
}

function remove_soft_full()
{
	read -p "Vuoi prima cercare l'applicazione [S\n]" sel
	echo "Per uscire premi q in qualsiasi momento"
	if [[ $sel = @(n|N) ]]; then
		read -p "Digita il nome dell'applicazione da rimuovere " software
		sudo pacman -Rs $software
	elif [[ $sel = @(s|S) ]]; then
		read -p "Digita il nome dell'applicazione da cercare " software
		if [[ $software = @(q|Q) ]]; then
				returne
			else
			pacman -Qs | grep -i local/$software && c=0 || c=1
			if [ $c == 1 ]; then
				echo "Applicazione non trovata!!!"
				while [ $c -ne 2 ];
				do
					if [ "$c" == 1 ]; then
						read -p "Digita il nome dell'applicazione da cercare " software
						pacman -Qs | grep -i local/$software && c=0 || c=1
					else
						echo "Applicazione trovata!!!"
						software=""
						read -p "Digita il nome dell'applicazione da rimuovere " software
							if [[ $software = @(q|Q) ]]; then
								returne
							else
								sudo pacman -Rs $software
							fi
						c=2
					fi
				done
			else
				software=""
				read -p "Digita il nome dell'applicazione da rimuovere " software
				if [[ $software = @(q|Q) ]]; then
					returne
				else
					sudo pacman -Rs $software
				fi
			fi
		fi
	else
		remove_soft_full
	fi
	returne
}

function remove_soft()
{
	read -p "Vuoi prima cercare l'applicazione [S\n]" sel
	if [[ $sel = @(n|N) ]]; then
		read -p "Digita il nome dell'applicazione da rimuovere " software
		sudo pacman -R $software
	elif [[ $sel = @(s|S) ]]; then
		read -p "Digita il nome dell'applicazione da cercare " software
		pacman -Qs | grep -i local/$software
		software=""
		read -p "Digita il nome dell'applicazione da rimuovere " software
		sudo pacman -R $software
	else
		remove_soft
	fi
	returne
}

function run_bleachbit()
{
	bleachbit_c
	if [ $bleachbit == 1 ]; then
		su -c '
		bleachbit &>/dev/null'
		returne
	else
		echo -e "$BLUE Mi dispiace il software Bleachbit non è installato $Z"
		echo "Ritorno alla schermata iniziale tra 7 Sec"
		sleep 7
		returne
	fi
}

function root_manager()
{
	read -p "Vuoi aprire una posizione specifica [S\n]" sel
	if [[ $sel = @(n|N) ]]; then
		echo "Il file manager si aprirà in radice "
		su -c '
		xdg-open / &>/dev/null'
		returne
	elif [[ $sel = @(s|S) ]]; then
		su -c '
		read -p "Digita il percorso " per
		xdg-open $per &>/dev/null'
		returne
	else
		root_manager
	fi
}

function Update_Mirror()
{
	"$master_dir/Mirrorlist.sh"
	returne
}

#########################################################
####SOTTO CATEGORIE######################################
#########################################################

function install()
{
	cancel
	
	declare -a options

	options[${#options[*]}]="Installare software con Pacman";
	options[${#options[*]}]="Installare software con Aurman";
	options[${#options[*]}]="Esci";
	select opt in "${options[@]}"; do
	case ${opt} in

	${options[0]}) install_pacman;;
	${options[1]}) install_aurman;;
	${options[2]}) returne;;
	
	esac;
	done
}

function manutenzione()
{
	cancel
	
	declare -a options
	
	options[${#options[*]}]="Aggiornare il S.O. (pacman)";
	options[${#options[*]}]="Aggiornare il S.O. (Aurman)";
	options[${#options[*]}]="Ottimizzare database pacman";
	options[${#options[*]}]="Rimuove cache pacchetti (mantiene solo la penultima versione (Paccache))";
	options[${#options[*]}]="Rimuove cache pacchetti scaricati ed attualmente non installati";
	options[${#options[*]}]="Rimuove cache pacchetti (Sconsigliata)";
	options[${#options[*]}]="Rimuove cache Aurman/Pacman";
	options[${#options[*]}]="Rimuovere pacchetti orfani";
	options[${#options[*]}]="Rimuovere Software con tutte le sue dipendenze";
	options[${#options[*]}]="Rimuovere Software";
	options[${#options[*]}]="Pulizia rapida 4;5;6";
	options[${#options[*]}]="Esci";
	select opt in "${options[@]}"; do
	case ${opt} in

	
	${options[0]}) agg_pacman;;
	${options[1]}) agg_aurman;;
	${options[2]}) pacman_ott;;
	${options[3]}) cache_del_paccache;;
	${options[4]}) cache_del;;
	${options[5]}) cache_del_full;;
	${options[6]}) cache_aurman_del;;
	${options[7]}) remove_orfan;;
	${options[8]}) remove_soft_full;;
	${options[9]}) remove_soft;;
	${options[10]}) rapid_cleen;;
	${options[11]}) returne;;
	
	esac;
	done
}

function check_programm()
{
	cancel
	echo "Controllo presenza programmi..."
	echo ""
	sudo_c
	paccache_c
	bleachbit_c
	aurman_c
	axel_c
	if [ $prog == 6 ]; then
		echo -e "$GREEN Tutti i programmi supplementari sono presenti $Z"
		echo "Attenti..."
		sleep 7
		returne
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
		returne
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
		returne
	fi

}

function comandi_utili()
{
	cancel
	
	declare -a options
	options[${#options[*]}]="Avvia file manager come root";
	options[${#options[*]}]="Backup/Ripristino pacchetti";
	options[${#options[*]}]="Aggiungi/Rimuovi pachetti a IgnorePkg";
	options[${#options[*]}]="Accelera download pacman";
	options[${#options[*]}]="Aggiorna Mirror";
	options[${#options[*]}]="Esci";
	select opt in "${options[@]}"; do
	case ${opt} in
	
	${options[0]}) root_manager;;
	${options[1]}) backup_soft;;
	${options[2]}) IgnorePkg;;
	${options[3]}) SpeedRunPacman;;
	${options[4]}) Update_Mirror;;
	${options[5]}) returne;;

	esac;
	done
}

function run_external_program()
{
	cancel
	
	declare -a options
	options[${#options[*]}]="Avvia Bleachbit Root";
	options[${#options[*]}]="Esci";
	select opt in "${options[@]}"; do
	case ${opt} in
	
	${options[0]}) run_bleachbit;;
	${options[1]}) returne;;

	esac;
	done
}

#########################################################
####FUNZIONE INIZIALE####################################
#########################################################

function inizio()
{

	declare -a options
	options[${#options[*]}]="Controlla aggiornamento script";
	options[${#options[*]}]="Installare software";
	options[${#options[*]}]="Manutenzione distribuzione";
	options[${#options[*]}]="Esegui programmi";
	options[${#options[*]}]="Comandi utili";
	options[${#options[*]}]="Controlla/Installa programmi supplementari";
	options[${#options[*]}]="Rimuovi Libreria Comandi";
	options[${#options[*]}]="Esci";
	select opt in "${options[@]}"; do
	case ${opt} in
	
	${options[0]}) Controlla_aggiornamenti;;
	${options[1]}) install;;
	${options[2]}) manutenzione;;
	${options[3]}) run_external_program;;
	${options[4]}) comandi_utili;;
	${options[5]}) check_programm;;
	${options[6]}) remove_lib;;
	
	(Esci) break; ;;
	esac;
	done
}

#########################################################
####RICHIAMO PRIMA FUNZIONE##############################
#########################################################

echo "
#########################################################
#			ATTENZIONE!!!!!			#
#	   Questo script ha bisogno di software		#
#      supplemetari (Aurman,Paccache,Bleachbit)		#
#	 per eseguire tutte le sue funzionalità.	#
#	   SCEGLIEDO DI UTILIZZARE QUESTO SCRIPT	#
#    ESULI IL SUO WRITER DA QUALSIASI RESPONSABILITÀ	#
#  By Mac89				          v$ver#
#########################################################"

check_prog_auto
inizio
