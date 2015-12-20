#!/bin/bash

# IMPORTANTE
# Se stai leggendo questo messaggio
# e non hai aperto volontariamente il programma con un editor di testo
# devi uscire; quindi premere con il tasto destro del mouse sopra al file,
# cliccare proprietà, selezionare permessi ed abilitare CONSENTI L'ESECUZIONE DEL FILE.
# Altrimenti puoi aprire un terminale, dirigerti nella cartella che contiene il file "cd ~/Scrivania"
# e digitare "chmod +x nomefile"

 ##SORGENTI##
link_yaourt="https://github.com/archlinuxfr/yaourt/archive/master.zip"
link_package_query="https://github.com/archlinuxfr/package-query/archive/master.zip"
############

function install_yaourt()
{
	mkdir /home/$USER/.temp/
	mkdir /home/$USER/.temp/libreria_comandi
	mkdir /home/$USER/.temp/libreria_comandi/yaourt
	cd /home/$USER/.temp/libreria_comandi/yaourt
	wget $link_yaourt
	unzip master.zip
	cd /home/$USER/.temp/libreria_comandi/yaourt/yaourt-master/src/
	sudo make install
	cd
	rm -rf /home/$USER/.temp/libreria_comandi
}


function install_package-query()
{
	mkdir /home/$USER/.temp/
	mkdir /home/$USER/.temp/libreria_comandi
	mkdir /home/$USER/.temp/libreria_comandi/package-query
	cd /home/$USER/.temp/libreria_comandi/package-query
	wget $link_package_query
	unzip master.zip
	cd /home/$USER/.temp/libreria_comandi/package-query/package-query-master/src/
	sudo make install
}
install_yaourt
