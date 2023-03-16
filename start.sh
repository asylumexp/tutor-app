#!/usr/bin/env bash
echo "Not updated for latest!!"
echo "dont use for now please."
dir=$(pwd)
sh="$dir/start.sh"
cd ./server

npm install && npm start & cd .. && cd ./flutter && flutter run -d web-server --web-hostname=0.0.0.0 --web-port=4000 & echo 'Client and Server started'

read text

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ "$text" == 'restart' ]; then
            killall -e node
            killall -e dart
            ./start.sh
        elif [ "$text" == 'kill' ]; then
            killall -e node
        fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
        if [ "$text" == 'restart' ]; then
            killall -e node
            killall -e dart
            ./start.sh
        elif [ "$text" == 'kill' ]; then
            killall -e node
        fi
elif [[ "$OSTYPE" == "msys" ]]; then
        if [ "$text" == 'restart' ]; then
            powershell -File ./start.ps1
            ./start.sh
        elif [ "$text" == 'kill' ]; then
            powershell -File ./start.ps1
        fi
else
        echo 'Unsupported'
fi
