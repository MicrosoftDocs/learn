### Prepare for the exercises

This exercise requires the use of a personal, trial, or work subscription in order to create Resource Groups and the necessary virtual machine.

1. In the Cloud Shell, create a VM.

    ```azurecli
    PASSWORD=$(openssl rand -base64 32)
    az vm create \
        --name SQL2019Server \
        --image "MicrosoftSQLServer:sql2019-ws2019:sqldev:latest" \
        --size Standard_D2s_v3 \
        --admin-username azureadmin \
        --admin-password $PASSWORD \
        --nsg-rule RDP \
        --resource-group <rgn>[Sandbox resource group]</rgn>
    echo $PASSWORD
    ```

2. Make a note of this password as you'll need it to connect to the VM in the exercises.
3. Open the RDP port to allow you to connect with a Remote Desktop Connection.

    ```azurecli
    az vm open-port \
        --port 3389 \
        --name SQL2019Server \
        --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

4. Install the .NET framework runtime version 4.8 in the VM. This is required for DMA version 5.3. The command may take several minutes to complete:

    ```azurecli
    az vm run-command invoke \
        --command-id RunPowerShellScript \
        --name SQL2019Server \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --scripts "Invoke-WebRequest 'https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0fd66638cde16859462a6243a4629a50/ndp48-x86-x64-allos-enu.exe' -OutFile 'Net4.8.exe'; ./Net4.8.exe /q /norestart /ChainingPackage ADMINDEPLOYMENT"
    ```

5. Restart the VM to finish the installation:

    ```azurecli
    az vm restart --resource-group <rgn>[Sandbox resource group]</rgn> --name SQL2019Server
    ```

> [!WARNING]
> Do not deactivate the sandbox. This sandbox will continue to be used in following units.