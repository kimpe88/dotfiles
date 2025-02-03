#!/bin/bash

if [ -p /dev/stdin ]; then
    while IFS= read -r line; do
        stripped_line=$(echo $line | tr -d '"')
        result=$(cast call "$stripped_line" "supportsInterface(bytes4)" 0x80ac58cd --rpc-url https://eth-mainnet.alchemyapi.io/v2/Lc7oIGYeL_QvInzI0Wiu_pOZZDEKBrdf)

        if [ "$result" == "0x0000000000000000000000000000000000000000000000000000000000000001" ]; then
          echo "$stripped_line"
        fi
    done
else
    echo "No passed to script. Please provide a new line separated list of contract addresses."
fi
