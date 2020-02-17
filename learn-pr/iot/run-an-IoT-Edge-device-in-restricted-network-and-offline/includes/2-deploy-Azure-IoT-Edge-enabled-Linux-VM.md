
In this unit, you will deploy an Ubuntu Server VM with Azure IoT Edge runtime support from the Azure Marketplace. In previous labs, you have created the VM using the Azure Portal. This time around, we will create the VM using the Azure CLI.

## Deploy Azure IoT Edge enabled Linux VM

1. If necessary, log in to your Azure portal using your Azure account credentials. Be sure that you are logged in with the account that is tied to the subscription that you will be using for this course.

2. Open the Azure Cloud Shell by clicking the Terminal icon within the top header bar of the Azure portal, and select the Bash shell option.

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
The first command above accepts the terms and conditions of use for VM image. The second command actually creates the VM within the resource group specified above. Remember to update AZ220EdgeVM{YOUR-ID} with your unique id and replace {YOUR-PASSWORD-HERE} with a suitably secure password.

**Note:** In production, you may elect to generate SSH keys rather than use the username/password approach. You can learn more about Linux VMs and SSH here: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed. 

**Note:** Deployment will take approximately 5 minutes to complete. You can continue on to the next unit while it is deploying.
