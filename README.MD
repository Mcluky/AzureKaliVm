# Azure Kali Vm with Remote Desktop

## With default settings
Run the following command in your [Azure cli](shell.azure.com/):
```
curl -s https://raw.githubusercontent.com/Mcluky/AzureKaliVm/main/create-azure-kali-vm.sh | bash
```
Default settings:
```
username='kali'
password='Default-Password-Kali-2020!' # must be 12 letters long, contain one upper and one
name='kali_vm'
resourceGroup='kali_vm_resource_group'
size='Standard_DS3_v2'
location='switzerlandnorth'
```

## With custom settings
Run the following command in your [Azure cli](shell.azure.com/):
```
curl https://raw.githubusercontent.com/Mcluky/AzureKaliVm/main/create-azure-kali-vm.sh --output create-azure-kali-vm.sh
# Update the script according to your needs
. create-azure-kali-vm.sh
```
