#!/bin/bash

# This script creates a new kali vm with the given configuration
# The VM will automatically shut down at 03:00 AM if not stopped before

username='kali'
password='Default-Password-Kali-2020!' # must be 12 letters long, contain one upper and one
name='kali_vm'
resourceGroup='kali_vm_resource_group'
size='Standard_DS3_v2'
location='switzerlandnorth'

set -x

az group create --name $resourceGroup --location $location && \

az vm create \
    --resource-group $resourceGroup \
    --name $name \
    --image kali-linux:kali-linux:kali:2019.2.0 \
    --size $size \
    --authentication-type password \
    --admin-username $username \
    --admin-password $password \
    --storage-sku StandardSSD_LRS && \

az vm open-port --resource-group $resourceGroup --name $name --nsg-name "remote desktop" --port 3389 && \

az vm auto-shutdown --resource-group $resourceGroup --name $name --time 0300 && \

ipAddress=$(az vm show -d --resource-group $resourceGroup --name $name --query publicIps -o tsv) && \

echo "Created Kali VM. The VM is accessible via the ip [$ipAddress]" && \

az vm run-command invoke \
    --resource-group $resourceGroup \
    --name $name \
    --command-id RunShellScript \
    --scripts 'apt-get --assume-yes --option Dpkg::options::="--force-confdef" --option Dpkg::options::="--force-confold" --option Dpkg::options::="--force-unsafe-io" --quiet update' && \

az vm run-command invoke \
    --resource-group $resourceGroup \
    --name $name \
    --command-id RunShellScript \
    --scripts 'DEBIAN_FRONTEND=noninteractive apt-get --assume-yes --option Dpkg::options::="--force-confdef" --option Dpkg::options::="--force-confold" --option Dpkg::options::="--force-unsafe-io" --quiet install gcc-8-base' && \

az vm run-command invoke \
    --resource-group $resourceGroup \
    --name $name \
    --command-id RunShellScript \
    --scripts 'DEBIAN_FRONTEND=noninteractive apt-get --assume-yes --option Dpkg::options::="--force-confdef" --option Dpkg::options::="--force-confold" --option Dpkg::options::="--force-unsafe-io" --quiet install xfce4' && \

az vm run-command invoke \
    --resource-group $resourceGroup \
    --name $name \
    --command-id RunShellScript \
    --scripts 'DEBIAN_FRONTEND=noninteractive apt-get --assume-yes --option Dpkg::options::="--force-confdef" --option Dpkg::options::="--force-confold" --option Dpkg::options::="--force-unsafe-io" --quiet install xrdp' && \

az vm run-command invoke \
    --resource-group $resourceGroup \
    --name $name \
    --command-id RunShellScript \
    --scripts 'systemctl enable xrdp' && \

az vm run-command invoke \
    --resource-group $resourceGroup \
    --name $name \
    --command-id RunShellScript \
    --scripts 'echo xfce4-session > ~/.xsession' && \

az vm run-command invoke \
    --resource-group $resourceGroup \
    --name $name \
    --command-id RunShellScript \
    --scripts 'echo xfce4-session > /home/kali/.xsession' && \

az vm run-command invoke \
    --resource-group $resourceGroup \
    --name $name \
    --command-id RunShellScript \
    --scripts 'service xrdp restart'

if [ $? -eq 0 ]; then
    set +x 
    echo "Deploying Kali VM was successfull. Access your VM via this ip: [$ipAddress]"
else
    set +x 
    echo 'Unsuccessful deplyoment of Kali VM... Should VM and resource group be removed?'
    az group delete --name $resourceGroup
fi
