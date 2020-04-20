#!/usr/bin/env bash

#expected environment variables:
#USER -> the name of the storage account
#smbshare -> The name of the share within the storage account
#PASSWD -> Password/key for the storage account
#fahteam -> team-id for folding@home
#fahuser -> user-id for folding@home

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth unzip mono-mcs

echo $SHARE_NAME
echo $STORAGE_ACCOUNT
echo $FOLDING_URL

# Write azure storage file share credentials
cat > /tmp/azure-storage-creds <<EOF
>username=$STORAGE_ACCOUNT
>password=$STORAGE_KEY
>EOF

# Mount azure storage file share
sudo mkdir /mnt/storage

sudo mount -t cifs //$STORAGE_ACCOUNT.file.core.windows.net/$SHARE_NAME /mnt/storage -o nofail,vers=3.0,dir_mode=0777,file_mode=0777,serverino,noperm,dynperm,credentials=/tmp/azure-storage-creds

rm /tmp/azure-storage-creds

# Retrieve the folding@home client
mkdir folding-client
wget $FOLDING_URL

tar jxf latest.tar.bz2
cp fahclient/* folding-client

# mono folding-at-azure/fahtcher.exe
