#!bin/bash
echo "                            #####################.                             
                       ######           #       /######                        
                   #####                #             ####*                    
                ####                   ###               /###*                 
              ###                      ##                   (###               
           ,###                       ###  ,                   ###             
          ###                        #####* #                    ###           
        ###                         #####*/                        ##          
       ##                          #######                          ###        
     .##                           ######    /                       ###       
    /##                           #######   /.                         ##      
    ##                            #######    #                          ##     
   ##   #                        ########  *   #                        ###    
  ##/    ###                      ####### #                              ##    
  ##      ##(#####               ######## . ## (                          ##   
 ##(       (##*##*####(           #######     #                           ##   
 ##         (###*###*#####       .#######   #               #   /         ###  
 ##          #####(######## #    ########   (  .#    / #      #           .##  
 ##           #**##############   #######                       .,         ##  
 ##            ################## #######     #        ,                   ##  
 ##               ################ #########           #    #             (##  
 ##                ################                  /   #                ##*  
 ###                #############    ####   # .   .(                      ##   
  ##                   (#########   #####      ##    /                   ###   
  ###                     #######   #####      #,  #  #                  ##    
   ###               # ##########   .####*# #  # # . # (                ##     
    ##           *###(############,             #         #            ###     
     ##    ********(##*###############*   ,##     #        .   *..,   ###      
      ###        *##*####################        ##   ( # /          ###       
       ###             #(##/,# ######## #  #     #     #           .##         
         ###                  ########  #        #/.              ###          
          ###/              ########    #     #     #           ###            
            ####           ######       *         (#  #       ###              
               ###        ###           *            .#    ####                
                 ####(                                  ####                   
                    .#####                          #####                      
                         ########           ,########                          
                               .##############                                 "
echo
echo "GanjaCoin Masternode Setup by siforek"
echo "-------------------------------------"
echo
IPADDR=$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')
read -e -p "VPS IP Address: " -i "$IPADDR" IPADDR
read -e -p "Choose Port: " -i "12419" MNPORT
read -e -p "Choose RPC Port: " -i "12420" RPCPORT
read -e -p "Choose RPC User: " RPCUSER
read -e -p "Choose RPC Password: " RPCPASS
read -e -p "Transaction ID: " TXID
read -e -p "TXINDEX(0 or 1): " TXINDEX
read -e -p "Wallet Masternode Name: " MNNAME
read -rsp $'This will take a while so smoke a bowl & chill out, press any key to continue...\n' -n1 key
apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get -y install ufw fail2ban libwww-perl build-essential libtool automake autotools-dev autoconf pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils libdb++-dev libminiupnpc-dev libboost-all-dev libqrencode-dev unzip && fallocate -l 4G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile && echo "vm.swappiness=10" >> /etc/sysctl.conf && echo "/swapfile none swap sw 0 0" >> /etc/fstab
mkdir -p ~/coins && cd ~/coins && git clone https://github.com/legends420/GanjaCoin.git && cd ~/coins/GanjaCoin/src && make -f makefile.unix
~/coins/GanjaCoin/src/ganjacoind
ufw allow 22/tcp && ufw allow $MNPORT/tcp && yes | ufw enable
sudo cp ~/coins/GanjaCoin/MNSampleGanjaProject.conf ~/.Ganjaproject2/Ganjaproject.conf
cat > ~/.Ganjaproject2/Ganjaproject.conf <<EOF
rpcuser=$RPCUSER
rpcpassword=$RPCPASS
rpcallowip=localhost
rpcport=$RPCPORT
port=$MNPORT
externalip=$IPADDR
server=1
listen=1
daemon=1
logtimestamps=1
txindex=$TXINDEX
maxconnections=500
mnconflock=1
masternode=0
masternodeaddr=$IPADDR:$MNPORT
masternodeprivkey=MYGENKEY
masternodeminprotocol=60029
stake=0
staking=0
seednode=138.197.44.71
addnode=138.197.44.71
addnode=45.32.212.138
addnode=218.101.109.199
addnode=73.196.26.253
addnode=104.236.217.59
addnode=216.172.33.74
addnode=173.249.26.81
EOF
echo -n "Connecting to network"
~/coins/GanjaCoin/src/ganjacoind
sleep 5
while [ "$(~/coins/GanjaCoin/src/ganjacoind getconnectioncount)" == "0" ]; do
echo -n ".";
sleep 5;
done
echo
echo -n "Syncing chain"
while [ "$(curl -s 'http://explorer.ganjacoinpro.com/api/getblockcount')" != "$(~/coins/GanjaCoin/src/ganjacoind getblockcount)" ]; do
echo -n ".";
sleep 5;
done
echo
echo "Connected!"
echo "Generating Masternode key.."
GENKEY=$(~/coins/GanjaCoin/src/ganjacoind masternode genkey)
sed -i '16s/.*/masternodeprivkey='$GENKEY'/' ~/.Ganjaproject2/Ganjaproject.conf
sed -i '14s/.*/masternode=1'/' ~/.Ganjaproject2/Ganjaproject.conf
~/coins/GanjaCoin/src/ganjacoind stop
sleep 3
~/coins/GanjaCoin/src/ganjacoind
sleep 3
echo
echo "Copy the Generated Wallet line to you local/cold wallet masternode.conf file:"
echo
echo $MNNAME $IPADDR:$MNPORT $GENKEY $TXID $TXINDEX
echo
echo "Then open My Masternodes in your local/cold wallet & click start!"
echo "Enjoy GanjaProject"
