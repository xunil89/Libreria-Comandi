#!/bin/bash
srg="https://www.archlinux.org/mirrorlist/?"
#cnt="country=all"
#hts="&protocol="
#htp="&protocol="
#IP6="&ip_version="
#IP4="&ip_version="
#m="&use_mirror_status=off"

##Cartelle-file temporanee##
mkdir /home/$USER/.temp
touch /home/$USER/.temp/checklist
touch /home/$USER/.temp/lingua

##Variabili##
list="/home/$USER/.temp/checklist"
lingua="/home/$USER/.temp/lingua"

function mirror_status()
{
		m="&use_mirror_status=on"
}

function https_protocl()
{
		hts="&protocol=https"
}

function http_protocl()
{
		htp="&protocol=http"
}

function IPv6_protocol()
{
		IP6="&ip_version=6"
}

function IPv4_protocol()
{
		IP4="&ip_version=4"
}

function Sel_option()
{
whiptail --title "Update Mirror List" --checklist --separate-output \
"Seleziona i pramateri che preferisci" 20 78 5 \
"MirrorStatus" "Consigliato" OFF \
"Https" "Consigliato" OFF \
"Http" "Consigliato" OFF \
"IPv4" "Consigliato" OFF \
"IPv6" "" OFF 2>$list
while read choice
do
        case $choice in
                MirrorStatus) mirror_status
                ;;
                ProtocolloHttps) https_protocl
                ;;
                ProtocolloHttp) http_protocl
                ;;
                ProtocolloIPv4) IPv4_protocol
                ;;
                ProtocolloIPv6) IPv6_protocol
                ;;
        esac
done < $list
}

function Sel_lingua()
{
whiptail --title "Update Mirror List" --checklist --separate-output \
"Seleziona i paesi che preferisci" 20 78  15 \
"country=all" "All" OFF \
"country=AU" "Australia" OFF \
"country=AT" "Austria" OFF \
"country=BD" "Bangladesh" OFF \
"country=BY" "Belarus" OFF \
"country=BE" "Belgium" OFF \
"country=BR" "Brazil" OFF \
"country=BG" "Bulgaria" OFF \
"country=CA" "Canada" OFF \
"country=CL" "Chile" OFF \
"country=CN" "China" OFF \
"country=CO" "Colombia" OFF \
"country=HR" "Croatia" OFF \
"country=CZ" "Czech Republic" OFF \
"country=DK" "Denmark" OFF \
"country=EC" "Ecuador" OFF \
"country=FR" "France" OFF \
"country=DE" "Germany" OFF \
"country=GR" "Greece" OFF \
"country=HU" "Hungary" OFF \
"country=IS" "Iceland" OFF \
"country=IN" "India" OFF \
"country=ID" "Indonesia" OFF \
"country=IR" "Iran" OFF \
"country=IE" "Ireland" OFF \
"country=IL" "Israel" OFF \
"country=IT" "Italy" OFF \
"country=JP" "Japan" OFF \
"country=KZ" "Kazakhstan" OFF \
"country=LV" "Latvia" OFF \
"country=LT" "Lithuania" OFF \
"country=LU" "Luxembourg" OFF \
"country=MK" "Macedonia" OFF \
"country=NL" "Netherlands" OFF \
"country=NC" "New Caledonia" OFF \
"country=NZ" "New Zealand" OFF \
"country=NO" "Norway" OFF \
"country=PH" "Philippines" OFF \
"country=PL" "Poland" OFF \
"country=PT" "Portugal" OFF \
"country=RO" "Romania" OFF \
"country=RU" "Russia" OFF \
"country=RS" "Serbia" OFF \
"country=SG" "Singapore" OFF \
"country=SK" "Slovakia" OFF \
"country=ZA" "South Africa" OFF \
"country=KR" "South Korea" OFF \
"country=ES" "Spain" OFF \
"country=SE" "Sweden" OFF \
"country=CH" "Switzerland" OFF \
"country=TW" "Taiwan" OFF \
"country=TR" "Turkey" OFF \
"country=UA" "Ukraine" OFF \
"country=GB" "United Kingdom" OFF \
"country=US" "United States" OFF \
"country=VN" "Vietnam" OFF 2>$lingua
}

function Country()
{
	cnt=$(paste -d"&" -s $lingua)
}

function Msg_initial()
{
	whiptail --title "Update Mirror List" --msgbox "Ora si avvierà la procedura guidata per l'aggiornamento della lista mirror.Spostati con le frecette, seleziona i checkbox con la barra spaziatrice,muoviti con il tab, e premi invio" 12 78
}

Msg_initial
Sel_option
Sel_lingua
Country
cd /home/$USER/.temp
wget $srg$cnt$hts$htp$IP6$IP4$t$m
cat index.html* >> mirrorlist
sed '/^#\S/ s|#||' -i mirrorlist
sed '/^#\S/ s|#||' -i mirrorlist
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo mv /home/$USER/.temp/mirrorlist /etc/pacman.d/
rm $list
rm $lingua
rm index.html*
cd
exit
