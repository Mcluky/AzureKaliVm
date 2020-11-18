# Azure Kali Vm with Remote Desktop

## With default settings
Run the following command in your [Azure cli](https://shell.azure.com/):
```
curl -s https://raw.githubusercontent.com/Mcluky/AzureKaliVm/main/create-azure-kali-vm.sh | bash
```
Default settings:
```
username='kali'
password='Default-Password-Kali-2020!' 
name='kali_vm'
resourceGroup='kali_vm_resource_group'
size='Standard_DS3_v2'
location='switzerlandnorth'
```

## With custom settings
Run the following command in your [Azure cli](https://shell.azure.com/):
```
curl https://raw.githubusercontent.com/Mcluky/AzureKaliVm/main/create-azure-kali-vm.sh --output create-azure-kali-vm.sh
# Update the script according to your needs
. create-azure-kali-vm.sh
```

## SSH
To access your server via ssh, use the ip that is printed on the console after the create-azure-kali-vm.sh script (alternatively check the ip in your azure portal). The default username is `kali` and password is `Default-Password-Kali-2020!`..
```
ssh kali@ip
```


## Remote Desktop Access
To access your server via remote desktop, use the ip that is printed on the console after the create-azure-kali-vm.sh script (alternatively check the ip in your azure portal). The default username is `kali` and password is `Default-Password-Kali-2020!`.

To get the optimal performance of your remote desktop, make sure you set the following options:
- Display -> colors to "24" or "32" bit and set  
- Experience -> "LAN"
