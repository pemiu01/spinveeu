o 3.2                                                      veeuspin.sh

#!/bin/bash
clear
merah='\e[31m'
ijo='\e[1;32m'
kuning='\e[1;33m'
biru='\e[1;34m'
NC='\e[0m'
#intro
printf "${ijo}
         ██████╗ ██╗   ██╗███████╗███████╗
        ██╔════╝ ██║   ██║╚══███╔╝╚══███╔╝
        ██║  ███╗██║   ██║  ███╔╝   ███╔╝
        ██║   ██║██║   ██║ ███╔╝   ███╔╝
        ╚██████╔╝╚██████╔╝███████╗███████╗
         ╚═════╝  ╚═════╝ ╚══════╝╚══════╝                                 ${biru}
                VeeU APPS Spin BOT
               Code By : Mr.MinZ
                  (グッズ)
"
printf "${kuning}__________________________________________________${NC}\n\n"

if [[ ! -f veu.reg ]]
        then
printf "${kuning}[!]${NC} Insert Your Veeu Token: "; read token
echo "$token"  >> veu.reg
else
        printf "${kuning}[+]${NC} To Use Another Token, Remove veu.reg\n"
fi
printf "${kuning}[!]${NC} Bet Amount (Leave Blank To Bet 1000 Coins) : "; read bet
if [[ $bet == '' ]]
then
        bet='1000'
fi
token=$(cat veu.reg)
printf "${kuning}[+]${NC} Starting...\n"
spin(){
        ngespin=$(curl -s 'http://nandrbiz1.com/veeuspin.php' -d "token=$token&bet=$bet")
        status=$(echo "$ngespin" | grep -Po '(?<=multiplier": )[^}]*')
        status2=$(echo "$status" | tr -d '.')
        total=$(echo "$ngespin" | grep -Po '(?<=current_point": )[^}]*')
        reward=$(echo "$ngespin" | grep -Po '(?<=reward_point": )[^,]*' | sed -n 1p)
#       rumus=$(expr $reward - $bet)
        if [[ $ngespin =~ 'multiplier' ]]
        then
rumus=$(expr $reward - $bet)
                if [[ 10#$status2 -gt '10' ]]
        then
                printf "${ijo}[WIN] [$status]${NC} You Win [Reward : $reward] [${ijo}+$rumus Coins${NC}] [Coins : $total]\n"
        elif [[ $status2 == '10' ]]
                then
                        printf "${kuning}[DRAW] [$status]${NC} DRAW RESULT [${kuning}+$rumus Coins${NC}] [Coins : $total]\n"
                elif [[ 10#$status2 -lt '10' ]]; then
                        printf "${merah}[LOSE] [$status]${NC} You Lose [Reward : $reward] [${merah}$rumus Coins${NC}] [Coins : $total]\n"
                fi
        elif [[ $ngespin =~ "Your Token Is Not Allowed" ]]
        then
                printf "${merah}[!]${NC} Token Not Allowed Please Use New Account\n"
                exit
        elif [[ $ngespin =~ 'too fast' ]]
        then
                printf "${kuning}[!]${NC} Access Too Fast, Sleeping for 30 minute...\n"
                sleep 1800
        elif [[ $ngespin =~ 'invalid' ]]
     then
                printf "${merah}[!}${NC} Invalid Token\n"
        exit
fi
}
for (( ; ; ))
do
        spin
        sleep 2
done
wait
