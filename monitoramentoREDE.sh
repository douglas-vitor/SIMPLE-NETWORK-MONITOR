#!/bin/bash
###################
#Script para monitoramento de trafego na rede
#v 1.0
#by:2
###################

######################configs##########################
#iftopinterface="eth0"

#ifip="192.168.0.1" #gatery roteador
#nmapip="192.168.0.1" #gatery roteador

iftopverifica=`dpkg -l | cut -b 1-9 | grep iftop`
var1="ii  iftop"
nethogsverifica=`dpkg -l | cut -b 1-11 | grep nethogs`
var2="ii  nethogs"
#######################################################

if [ "$iftopverifica" == "$var1" ] 2> /dev/null; then
echo "iftop instalado.....[OK]"
else
echo "instalando iftop"
apt-get install iftop -y
fi

if [ "$nethogsverifica" == "$var2" ]; then
echo "nethogs instalado.....[OK]"
else
echo "instalando nethogs"
apt-get install nethogs -y
fi

while true; do
read -p 'Digite a interface para o IFTOP analisar, ex. eth0 : ' iftopinterface
case $iftopinterface in
esac
break
done
while true; do
read -p 'Digite o IP do gatery/roteador para o IFTOP, ex. 192.168.1.1 : ' ifip
case $ifip in
esac
break
done

#iftop
xterm -e iftop -i $iftopinterface -F $ifip/24 -P -o 2s &

#nethogs
xterm -e nethogs -d -v -c 0 -s -a &

while true; do
read -p 'Digite o IP do gatery/roteador para o NMAP, ex. 192.168.1.1 : ' nmapip
case $nmapip in
esac
break
done

#nmap
while true; do
nmap -sP $nmapip/24
echo
read -p 'Reload? [s/n]' OP
case $OP in
	n ) break ;;
	y ) clear; nmap -sP $nmapip/24 ;;
esac
echo
done

