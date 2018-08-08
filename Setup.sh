#!/bin/bash

# IMPORTANTE
# Se stai leggendo questo messaggio
# e non hai aperto volontariamente il programma con un editor di testo
# devi uscire; quindi premere con il tasto destro del mouse sopra al file,
# cliccare proprietà, selezionare permessi ed abilitare CONSENTI L'ESECUZIONE DEL FILE.
# Altrimenti puoi aprire un terminale, dirigerti nella cartella che contiene il file "cd ~/Scrivania"
# e digitare "chmod +x nomefile"

sudo mkdir /usr/share/libreria_comandi
sudo mkdir /usr/share/libreria_comandi/ico
sudo mkdir /var/log/libreria_comandi

cd /usr/share/libreria_comandi
sudo wget https://raw.githubusercontent.com/xunil89/Libreria-Comandi/master/Mirrorlist.sh
sudo wget https://raw.githubusercontent.com/xunil89/Libreria-Comandi/master/Yaourt_install.sh
sudo wget https://raw.githubusercontent.com/xunil89/Libreria-Comandi/master/Update_lib.sh
sudo wget https://raw.githubusercontent.com/xunil89/Libreria-Comandi/master/Libreria_comandi.sh
sudo chmod +x  Libreria_comandi.sh
sudo chmod +x Mirrorlist.sh
sudo chmod +x Aurman_install.sh
sudo chmod +x Update_lib.sh
cd /home/$USER
sudo chmod +x Libreria-comandi.desktop
cd

#cd /usr/share/libreria_comandi/ico
#wget https://raw.githubusercontent.com/xunil89/Libreria-Comandi/master/Ico_libreria_comandi.png
#cd

#cd /usr/bin
#cd

cd /home/$USER
wget https://raw.githubusercontent.com/xunil89/Libreria-Comandi/master/Libreria-comandi.desktop
cd

exit
