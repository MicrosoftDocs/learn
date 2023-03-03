You've completed all the steps required to test whether your application is accessible from the internet using Application Gateway.

In this unit, you'll access an application using Domain Name Services.

1.  Check the back-end health of Application Gateway instance you deployed in the previous task.
    
    ```Bash
    az network application-gateway show-backend-health \
        --name $APPGW_NAME \
        --resource-group $RESOURCE_GROUP
    ```
    
    > [!NOTE]
    > The output of this command should return the Healthy value of the health property of the `backendHttpSettingsCollection` element. If so, your setup is valid. If you see any other value than healthy, review the previous steps.
    
    > [!NOTE]
    > There might be a delay before the Application Gateway reports the Healthy status of `backendHttpSettingsCollection`, so if you encounter any issues, wait a few minutes and rerun the previous command before you start troubleshooting.

2.  Next, identify the public IP address of the Application Gateway by running the following command from the Git Bash shell.
    
    ```Bash
    az network public-ip show \
        --resource-group $RESOURCE_GROUP \
        --name $APPLICATION_GATEWAY_PUBLIC_IP_NAME \
        --query [ipAddress] \
        --output tsv
    ```

3.  To identify the custom DNS name associated with the certificate you used to configure the endpoint exposed by the Application Gateway instance, run the following command from the Git Bash shell.
    
    ```Bash
    echo $DNS_NAME
    ```
    
    > [!NOTE]
    > To validate the configuration, you'll need to use the custom DNS name to access the public endpoint of the api-gateway app, exposed via the Application Gateway instance. You can text by adding an entry that maps the DNS name to the IP address you identified in the previous step to the `hosts`file on your computer.

4.  On your lab computer, open the *C:\\Windows\\System32\\drivers\\etc\\hosts* in Notepad using elevated privileges and add an extra line to the file. Replace the *`<app-gateway-ip-address>`* and *`<custom-dns-name>`* placeholders with the IP address and the DNS name you identified in the previous two steps.
    
    ```Bash
    <app-gateway-ip-address> <custom-dns-name>
    ```

5.  Using a web browser on your lab computer, navigate to the URL with the *https://* prefix followed by the custom DNS name you specified when updating the local hosts file. Your browser may display a warning notifying you that your connection isn't private. The warning expected and because you're relying on a self-signed certificate. Acknowledge the warning and proceed to displaying the target web page. You should be able to see the PetClinic application start page again.
    
    > [!NOTE]
    > While the connection to the MySQL database should be working at this point, keep in mind that this connectivity is established using the public endpoint, rather than the private one. You'll remediate the connection in the next exercise.
