#!/usr/bin/bash
# Torattacker
# Coded by Nedi Senja
# Github: https://github.com/stepbystepexe/Torattacker
clear
trap 'echo Keluar...; exit 1;' SIGINT SIGTSTP
checkroot(){
if [[ "$(id -u)" -ne 0 ]]; then
   printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mMohon, jalankan program root!\n\n\e[0m"
   exit 1
fi
}
#checkroot
package(){
    printf "\e[0m[\e[1;91m INFO \e[0m] \e[0;100;77;1m Menginstall paket & tool \e[0m\n\n"
    sleep 1
    (trap '' SIGINT SIGTSTP && command -v bash > /dev/null 2>&1 || { printf >&2  "\e[0m[\e[1;92m!\e[0m] \e[1;77mMenginstall Bash, memproses...\n\e[0m"; apt-get update > /dev/null && apt-get -y install bash > /dev/null || printf "\e[0m[\e[1;93m!\e[0m] \e[1;77mBash tidak terinstall.\n\e[0m"; }) & wait $!
    (trap '' SIGINT SIGTSTP && command -v curl > /dev/null 2>&1 || { printf >&2  "\e[0m[\e[1;92m!\e[0m] \e[1;77mMenginstall cURL, memproses...\n\e[0m"; apt-get update > /dev/null && apt-get -y install curl > /dev/null || printf "\e[0m[\e[1;93m!\e[0m] \e[1;77mcURL tidak terinstall.\n\e[0m"; }) & wait $!
    (trap '' SIGINT SIGTSTP && command -v wget > /dev/null 2>&1 || { printf >&2  "\e[0m[\e[1;92m!\e[0m] \e[1;77mMenginstall Wget, memproses...\n\e[0m"; apt-get update > /dev/null && apt-get -y install wget > /dev/null || printf "\e[0m[\e[1;93m!\e[0m] \e[1;77mWget tidak terinstall.\n\e[0m"; }) & wait $!
    (trap '' SIGINT SIGTSTP && command -v openssl > /dev/null 2>&1 || { printf >&2  "\e[0m[\e[1;92m!\e[0m] \e[1;77mMenginstall Openssl, memproses...\n\e[0m"; apt-get update > /dev/null && apt-get -y install openssl > /dev/null || printf "\e[0m[\e[1;93m!\e[0m] \e[1;77mOpenssl tidak terinstall.\n\e[0m"; }) & wait $!
    (trap '' SIGINT SIGTSTP && command -v tor > /dev/null 2>&1 || { printf >&2  "\e[0m[\e[1;92m!\e[0m] \e[1;77mMenginstall TOR, memproses...\n\e[0m"; apt-get update > /dev/null && apt-get -y install tor > /dev/null || printf "\e[0m[\e[1;93m!\e[0m] \e[1;77mTOR tidak terinstall.\n\e[0m"; }) & wait $!
    (trap '' SIGINT SIGTSTP && command -v python2 > /dev/null 2>&1 || { printf >&2  "\e[0m[\e[1;92m!\e[0m] \e[1;77mMenginstall Python2, memproses...\n\e[0m"; apt-get update > /dev/null && apt-get -y install python2 > /dev/null || printf "\e[0m[\e[1;93m!\e[0m] \e[1;77mPython2 tidak terinstall.\n\e[0m"; }) & wait $!
    (trap '' SIGINT SIGTSTP && command -v git > /dev/null 2>&1 || { printf >&2  "\e[0m[\e[1;92m!\e[0m] \e[1;77mMenginstall Git, memproses...\n\e[0m"; apt-get update > /dev/null && apt-get -y install git > /dev/null || printf "\e[0m[\e[1;93m!\e[0m] \e[1;77mGit tidak terinstall.\n\e[0m"; }) & wait $!
}
termuxupdate(){
    package
    sleep 1
    read -p $'\n\e[0m[\e[1;97m+\e[0m] Update & upgrade termux [Y/n] ' dat
        if [[ $dat == 'y' || $dat == 'Y' ]]; then
        echo
        apt update && apt upgrade
        echo
        installtools
        sleep 0.1
            elif [[ $dat == 'n' || $sat == 'N' ]]; then
            echo
            exit 1
            echo
        else
            echo
    fi
}
installtools(){
    # Torshammer
    echo -e "\e[0m[\e[1;91m!\e[0m] \e[1;77mMenginstalll Torshammer\e[0m"
    git clone https://github.com/dotfighter/torshammer
    sleep 1
        read -p $'\n\e[0m[\e[1;97m+\e[0m] Kembali ke tool, Torattacker [Y/n] ' opt
            if [[ $opt == 'y' || $opt == 'Y' ]]; then
            cd $HOME/torattacker
            bash torattacker.sh
                elif [[ $opt == 'n' || $opt == 'N' ]]; then
                echo
                exit 1
                echo
            else
                echo
                exit 1
                echo
        fi
}
termuxupdate
