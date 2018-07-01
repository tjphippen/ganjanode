# GanjaCoin Masternode Setup
### PC Wallet
----
- Download Windows Wallet here: https://ganjacoinpro.com/downloads/GanjaCoinv1.0.0.7.zip
- Extract `GanjaCoinv1.0.0.7.zip` & open `Ganjaproject-qy.exe`
- Wait for wallet to finish syncing. 
*Connections & current block is shown under `Help > Debug Window`, on the Information tab. Check current block should match* http://explorer.ganjacoinpro.com/
- Go to Recieve & create a New Address for your master node
- Go to Send & transfer exactly 30,000 MRJA to the newly created address. 
*Enable Coin Control by navigating to Settings > Options & Display tab to specify Inputs*
- Wait for the transaction to be confirmed
- Click Help > Debug Window & go to the Consol tab
- Type `masternode outputs` & press enter. You should get something formatted like:
```
masternode outputs
{
	"784661b58542cf3fd018a9013767987bdf19a85ca3ce24a0cd936a5a04a2a43b" : "0"  (Transaction ID : TXINDEX)
}
``` 
You will need these & be prompted for them during the VPS setup.

##### After completeing VPS setup you need to manually create & start your masternode.

- Open masternode.conf with a text editor. 
Windows location 'C:/Users/YOURUSER/AppData/Roaming/Ganjaproject2'
- Paste the Generated Wallet masternode.conf from the VPS setup formatted like:
```
mn1 XXX.XXX.XX.XXX:12419 5e2aqYqRKKAWpM2fpwwqYZnqkjZ93sEa4bHy2a7BPa5D8nPzhxL 784661b58542cf3fd018a9013767987bdf19a85ca3ce24a0cd936a5a04a2a43b 0 
```
- Save masternode.conf
- Open your Wallet to the Masternodes > My Master Nodes
- Select your masternode & click Start
- Wait for your node to show active on the 'Ganjaproject Network' tab.

## VPS
----
- Download & install PuTTY: https://www.putty.org/ for Windows or on Mac use terminal
- Create a Ubuntu 16.04 x64 instance at your favorite host. (Digital Ocean, Vultr, etc) 
Highly suggest setting up SSH Key to prevent unwanted access: https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-digitalocean-droplets

Once logged in to you VPS paste:
```wget https://raw.githubusercontent.com/tjphippen/ganjanode/master/ganjainstall.sh && bash ganjainstall.sh```
& press enter.

![Alt text](setup-start.png?raw=true "Setup Start")

Prompts for VPS IP Address & RPC Port will be autopopulated with the detected IP & default ports.
- Wait for everything to be installed(~20-30 minutes)

- Enter the Tranaction ID & TXINDEX shown in the wallet setup. (Right Click to paste in puTTY)

- Copy/save the Generated Wallet masternode.conf for use in Wallet setup

![Alt text](setup-complete.png?raw=true "Setup Complete")

```
myMN1 178.128.171.186:12419 5e2aqYqRKKAWpM2fpwwqYZnqkjZ93sEa4bHy2a7BPa5D8nPzhxL 784661b58542cf3fd018a9013767987bdf19a85ca3ce24a0cd936a5a04a2a43b 0

```
The Ganjaproject.conf file will be written for you & your masternode will start.
- Type/paste  ```watch ~/coins/GanjaCoin/src/ganjacoind getinfo``` 
to see wallet version, connection & current block. 

```
{
    "version" : "v1.0.0.7-60032",
    "protocolversion" : 60032,
    "walletversion" : 60000,
    "balance" : 0.00000000,
    "darksend_balance" : 0.00000000,
    "newmint" : 0.00000000,
    "stake" : 0.00000000,
    "blocks" : 3011,
    "timeoffset" : 0,
    "moneysupply" : 39536001.40000000,
    "connections" : 26,
    "proxy" : "",
    "ip" : "192.241.221.149",
    "difficulty" : {
        "proof-of-work" : 0.00158072,
        "proof-of-stake" : 5079765.16341258
    },
    "testnet" : false,
    "keypoololdest" : 1529869661,
    "keypoolsize" : 101,
    "paytxfee" : 0.00001000,
    "mininput" : 0.00000000,
    "errors" : ""
}
```

Once you've finished the Wallet setup & started your masternode in your Wallet type/paste ```~/coins/GanjaCoin/src/ganjacoind masternode status``` 

It should be status 9.
You're all set :)

Ganjacoind will automatically start in case of reboot.

Also find your masternode status/info listed here: http://explorer.ganjacoinpro.com/masternodes

##### If this guide helped donate MRJA to `ifvXoQRGAzWRTt5Ey4WSt4FULqzTE3BdsU`
