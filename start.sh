#!/usr/bin/env bash

dir=$(pwd)
sh="$dir/start.sh"
cd ./server

npm start & cd ../client && npm start & echo 'Client and Server started' & cd ..

read text

if [ "$text" == 'restart' ]; then
    killall -e node
    ./start.sh
fi