#!/bin/bash

# IMPORTANTE
# Se stai leggendo questo messaggio
# e non hai aperto volontariamente il programma con un editor di testo
# devi uscire; quindi premere con il tasto destro del mouse sopra al file,
# cliccare proprietà, selezionare permessi ed abilitare CONSENTI L'ESECUZIONE DEL FILE.
# Altrimenti puoi aprire un terminale, dirigerti nella cartella che contiene il file "cd ~/Scrivania"
# e digitare "chmod +x nomefile"


function remove_lib()
{
	read -p "Attenzione stai per rimuovere l'intera libreria comandi sei sicuro? [N\s]" sel
	if [[ $sel = @(n|N) ]]; then
		echo "Uscita dallo script..."
		sleep 3
		exit
	elif [[ $sel = @(s|S) ]]; then
		echo "Procedo con la disinstallazione..."
		sudo rm -rf /usr/share/libreria_comandi
		sudo rm -rf /var/log/libreria_comandi
		sudo rm -rf  /home/$USER/Libreria-comandi.desktop
	else
		install_pacman
	fi
exit
}

remove_lib
