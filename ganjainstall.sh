#!bin/bash
echo "GanjaCoin Masternode Setup by siforek"
echo "-------------------------------------"
echo
IPADDR=$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')
read -e -p "VPS IP Address: " -i "$IPADDR" IPADDR
read -e -p "Choose RPC Port: " -i "12420" RPCPORT
read -rsp $'This will take a while so smoke a bowl & chill out, press any key to continue...\n' -n1 key
apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get -y install ufw fail2ban libwww-perl build-essential libtool automake autotools-dev autoconf pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils libdb++-dev libminiupnpc-dev libboost-all-dev libqrencode-dev unzip && fallocate -l 4G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && echo "vm.swappiness=10" >> /etc/sysctl.conf && echo "/swapfile none swap sw 0 0" >> /etc/fstab
ufw allow 22/tcp && ufw allow $RPCPORT/tcp && yes | ufw enable
mkdir -p ~/coins && cd ~/coins && git clone https://github.com/legends420/GanjaCoin.git && cd ~/coins/GanjaCoin/src && make -f makefile.unix
~/coins/GanjaCoin/src/ganjacoind
sudo cp ~/coins/GanjaCoin/MNSampleGanjaProject.conf ~/.Ganjaproject2/Ganjaproject.conf
read -e -p "Choose RPC User: " RPCUSER
read -e -p "Choose RPC Password: " RPCPASS
read -e -p "Key(genkey): " GENKEY
read -e -p "Transaction ID: " TXID
read -e -p "TXINDEX(0 or 1): " TXINDEX
read -e -p "Wallet Masternode Name: " MNNAME
cat > ~/.Ganjaproject2/Ganjaproject.conf <<EOF
rpcuser=$RPCUSER
rpcpassword=$RPCPASS
rpcallowip=localhost
rpcport=$RPCPORT
port=12419
externalip=$IPADDR
server=1
listen=1
daemon=1
logtimestamps=1
txindex=$TXINDEX
maxconnections=500
mnconflock=1
masternode=1
masternodeaddr=$IPADDR:$RPCPORT
masternodeprivkey=$GENKEY
stake=0
staking=0
seednode=138.197.44.71
addnode=192.99.55.111
addnode=45.63.4.123
addnode=81.152.218.253
addnode=80.208.228.52
addnode=104.131.15.51
addnode=98.172.83.59
addnode=216.173.152.247
addnode=91.121.95.32
addnode=45.76.2.44
EOF
echo "starting node"
~/coins/GanjaCoin/src/ganjacoind
echo "Generated Wallet masternode.conf:"
echo
echo $MNNAME $IPADDR:$RPCPORT $GENKEY $TXID $TXINDEX
echo
echo "Enjoy GanjaProject"
