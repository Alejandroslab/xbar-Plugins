#!/bin/bash

# <bitbar.title>ETHEUR last price</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>G.G.</bitbar.author>
# <bitbar.author.github>ggrelet</bitbar.author.github>

# <bitbar.desc>Gives the last price of ether to euro</bitbar.desc>
# <bitbar.dependencies>bash</bitbar.dependencies>

#DEFINE ALL THE COINS WE NEED FROM THE MARKETS WE WANT TO SEE

BCHKraken=$(curl -s "https://api.kraken.com/0/public/Ticker?pair=BCHUSD" | tr -d '{}"[]' | tr ':,' '\n' | grep -A1 "^c$" | tail -1)

BCHKrakenEUR=$(curl -s "https://api.kraken.com/0/public/Ticker?pair=BCHEUR" | tr -d '{}"[]' | tr ':,' '\n' | grep -A1 "^c$" | tail -1)

ethKraken=$(curl -s "https://api.kraken.com/0/public/Ticker?pair=ETHEUR" | tr -d '{}"[]' | tr ':,' '\n' | grep -A1 "^c$" | tail -1)

ethCoinbase=$(curl -s "https://api.coinbase.com/v2/prices/ETH-EUR/spot" -H "CB-VERSION: 2017-04-16" | egrep -o '{"data":{"amount":"[0-9]+(\.)?' | sed 's/{"data":{"amount"://'  | sed 's:^.\(.*\).$:\1:')

ethGDAX=$(curl -s "https://api.gdax.com/BTC-EUR/ticker" -H "CB-VERSION: 2017-04-16" | egrep -o '{"data":{"amount":"[0-9]+(\.)?' | sed 's/{"data":{"amount"://'  | sed 's:^.\(.*\).$:\1:')

ethKUSD=$(curl -s "https://api.kraken.com/0/public/Ticker?pair=ETHUSD" | tr -d '{}"[]' | tr ':,' '\n' | grep -A1 "^c$" | tail -1)



echo "$(printf "BCH $%.2f \n" "$BCHKraken") | size=13 |"
echo "---"
echo "Kraken: Nuovi BCH!"
echo "$(printf "$%.2f \n" "$BCHKraken") | size=13 |"
echo "$(printf "€%.2f \n" "$BCHKrakenEUR") | size=13 |"
echo "---" 
echo "ETH EUR"
echo "Kraken: $(printf "€%.2f \n" "$ethKraken") | size=13 | href=\"https://www.kraken.com/\""
echo "Coinbase: $(printf "€%.2f \n" "$ethCoinbase") | size=13"
echo "GDAX: $(printf "€%.2f \n" "$ethGDAX") | size=13"
echo "Inserisci altre monete"
echo "Inserisci altre monete"
echo "---"
echo "ETH USD"
echo "Kraken: $(printf "$%.2f \n" "$ethKUSD") | size=13"
echo "Inserisci monete in USD"
echo "Inserisci monete in USD"
echo "Inserisci monete in USD"
echo "---"
echo "LTC EUR"
echo "1) option"
echo "2) option"


#to create a link to a website
#echo "Kraken.com | href=\"https://www.kraken.com/\""