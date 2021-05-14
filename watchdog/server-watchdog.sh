#!/bin/bash

IP_ADDRESSES=()
LAST_RESPONSE=()
MINUTES=1
SECONDS=$((MINUTES * 60))
FILES_PATH=/media/cristi/SAMSUNG/Info/Assistant/sss-infrastructure/watchdog
WEBHOOK_URL=https://discordapp.com/api/webhooks/842661568017989663/eGNYfsK5Yqk9ktIvgy--Sz_KPR2QL2AcApKS8i47xNS2xCaNEkIBaEdD5DUYUH10KkxL

echo "[$(date +"%d/%m/%y %T")]: Watchdog is alive" > $FILES_PATH/log.txt

while sleep 10 & wait; do
    readarray IP_ADDRESSES < $FILES_PATH/ips.txt
    readarray LAST_RESPONSE < $FILES_PATH/responses.txt

    for i in ${!IP_ADDRESSES[@]}; do
        if [[ ! ${IP_ADDRESSES[i]} ]]; then
            continue
        fi

        RES=$(curl -I --silent ${IP_ADDRESSES[i]} | grep HTTP | cut -d' ' -f 2)

        IP=$(echo ${IP_ADDRESSES[i]} | cut -d":" -f 1)
        PORT=$(echo ${IP_ADDRESSES[i]} | cut -d":" -f 2)

        if [[ ! $RES ]]; then
            RES=$(nc -z $IP $PORT; echo $?)
            if [[ $RES == "0" ]]; then
                RES="UP"
            else
                RES="DOWN"
            fi
        fi

        if [ $RES != ${LAST_RESPONSE[i]} ]; then
            if [[ $RES == "DOWN" ]]; then
                MESG="[$(date +"%d/%m/%y %T")]: ${IP_ADDRESSES[i]} is **down**"
            else
                if [[ $RES == "200" ]] || [[ $RES == "UP" ]]; then
                    MESG="[$(date +"%d/%m/%y %T")]: ${IP_ADDRESSES[i]} is **up**"
                else
                    MESG"[$(date +"%d/%m/%y %T")]: ${IP_ADDRESSES[i]} **replied with $RES**"
                fi
            fi
            curl \
                -H "Content-Type: application/json" \
                -d "{\"username\": \"Server Watchdog\", \"content\" : \"$MESG, \"avatar_url\": \"https://imgur.com/LN2QDcu.jpg\"}" \
                $WEBHOOK_URL
            echo $MESG >> $FILES_PATH/log.txt
            LAST_RESPONSE[i]=$RES
        fi
    done
    for i in ${!LAST_RESPONSE[@]}; do
        if [[ i -eq "0" ]]; then
            echo ${LAST_RESPONSE[i]} > $FILES_PATH/responses.txt
        else
            echo ${LAST_RESPONSE[i]} >> $FILES_PATH/responses.txt
        fi
    done
done
