
This unit will detail steps on deploying an Ubuntu Server VM with Azure IoT Edge runtime support from the Azure Marketplace. In previous labs, VMs have been created using the Azure portal. This lab will detail the use of Azure CLI to create the required VMs.

## Deploy Azure IoT Edge enabled Linux VM

1. Log in to your Azure portal using your Azure account credentials.

2. Open the Azure Cloudshell by clicking the Terminal icon located within the top header bar of the Azure portal, and select the Bash shell option.

3. To create a resource group for the Azure IoT Edge enabled VM, enter the following command:

```bash
az group create --name AZ-220-IoTEdge-RG --location {YOUR-LOCATION}
```

Remember to replace {YOUR-LOCATION} with a location close to you.

4. To create a Linux VM, enter the following commands:

```bash
 az vm image terms accept --urn microsoft_iot_edge:iot_edge_vm_ubuntu:ubuntu_1604_edgeruntimeonly:latest
 az vm create --resource-group AZ-220-IoTEdge-RG --name AZ220EdgeVM{YOUR-ID} --image microsoft_iot_edge:iot_edge_vm_ubuntu:ubuntu_1604_edgeruntimeonly:latest --admin-username vmadmin --admin-password {YOUR-PASSWORD-HERE} --authentication-type password
```
The first command above accepts the terms and conditions of use for VM image. The second command actually creates the VM within the resource group specified above. Remember to update AZ220EdgeVM{YOUR-ID} with your unique ID and replace {YOUR-PASSWORD-HERE} with a suitably secure password.

    >[!NOTE]
    >In production, you may elect to generate SSH keys rather than use the username/password approach. You can learn more about Linux VMs and SSH here: https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed.
    
    >[!NOTE]
    >Deployment will take approximately 5 minutes to complete. You can continue on to the next unit while it is deploying.
