#!/usr/bin/env bash

dir=$(pwd)
sh="$dir/start.sh"
cd ./server

npm start & cd ../client && npm start & echo 'Client and Server started' & cd ..

read text

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ "$text" == 'restart' ]; then
            killall -e node
            ./start.sh
        elif [ "$text" == 'kill' ]; then
            killall -e node
        fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
        if [ "$text" == 'restart' ]; then
            killall -e node
            ./start.sh
        fi
elif [[ "$OSTYPE" == "msys" ]]; then
        if [ "$text" == 'restart' ]; then
            powershell -File ./start.ps1
            ./start.sh
        fi
else
        echo 'Unsupported'
fi
