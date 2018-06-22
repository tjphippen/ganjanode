#!bin/bash
echo "GanjaCoin Masternode Setup by siforek"
echo "-------------------------------------"
read -rsp $'Smoke a bowl, then press any key to continue...\n' -n1 key
read -e -p "Choose RPC Port: " -i "12419" RPCPORT
apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get -y install ufw fail2ban libwww-perl build-essential libtool automake autotools-dev autoconf pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils libdb++-dev libminiupnpc-dev libboost-all-dev libqrencode-dev unzip && fallocate -l 4G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && echo "vm.swappiness=10" >> /etc/sysctl.conf && echo "/swapfile none swap sw 0 0" >> /etc/fstab
ufw allow 22/tcp && ufw allow $RPCPORT/tcp && ufw enable
mkdir -p ~/coins && cd ~/coins && git clone https://github.com/legends420/GanjaCoin.git && cd ~/coins/GanjaCoin/src && make -f makefile.unix
cd ~/coins/GanjaCoin/src && ./ganjacoind
sudo cp ~/coins/GanjaCoin/MNSampleGanjaProject.conf ~/.Ganjaproject2/Ganjaproject.conf
echo " Edit username , rpcpassword and put in your privkey,txindex and your VPS IP address"
nano ~/.Ganjaproject2/Ganjaproject.conf
echo "start node"
cd ~/coins/GanjaCoin/src && ./ganjacoind
echo "Enjoy GanjaProject"
