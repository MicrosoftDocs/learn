You've recreated the Spring Apps service in a virtual network and configured private DNS in the virtual network. Now you can reach your microservices within your virtual network.

You'll now integrate with Azure Application Gateway allowing applications to be accessible on the Internet. To direct your Azure Spring Apps back-end, you'll need to make sure that the domain name is the same as the `hostname`used by the Application Gateway to direct traffic to your Azure Spring Apps service. The `hostname`is required so cookies and generated redirect URLs work as expected.

To configure, you'll need a custom domain and corresponding certificate on your applications in Azure Spring Apps. The certificate will need to be stored in Azure Key Vault and can be retrieved from there by your apps.

In this exercise, you'll choose to use a self signed certificate for demonstrational purposes. For production systems you use a publicly signed certificate.

You need to acquire a self-signed certificate and add it to Key Vault.

1.  To create a self-signed certificate, you'll use a **sample-policy.json** file. To generate the file, from the Git Bash shell prompt, run the following command:
    
    ```Bash
    az keyvault certificate get-default-policy > sample-policy.json
    ```

2.  From the Git Bash window, use your text editor to open the **sample-policy.json** file. Change the `subject`property and add the `subjectAlternativeNames`property to match the sample shown below. Save and close the file.
    
    ```Bash
    {
    // ...
        "subject": "C=US, ST=WA, L=Redmond, O=Contoso, OU=Contoso HR, CN=myapp.mydomain.com",
        "subjectAlternativeNames": {
            "dnsNames": [
                "myapp.mydomain.com",
                "*.myapp.mydomain.com"
            ],
            "emails": [
                "hello@contoso.com"
            ],
                "upns": []
        }
    // ...
    }
    ```
    
    > [!NOTE]
    > Ensure that you include the trailing comma at the end of the updated content whenever there's another JSON element following it.

3.  You'll need to find and replace the **myapp.mydomain.com** DNS name in the **sample-policy.json** file with a randomly generated custom domain name. You'll use custom domain name later in this exercise. To generate the custom domain name, run the following commands.
    
    ```Bash
    DNS_LABEL=springappsdns$RANDOM$RANDOM
    DNS_NAME=sampleapp.${DNS_LABEL}.com
    cat sample-policy.json | sed "s/myapp.mydomain.com/${DNS_NAME}/g" > result-policy.json
    
    ```

4.  Review the updated content of the **result-policy.json** file and record the updated DNS name in the *`sampleapp.<your-custom-domain-name>.com`* format by running the following command.
    
    ```Bash
    cat result-policy.json
    ```

5.  You can now use the *result-policy.json* file to create a self-signed certificate in Key Vault.
    
    ```Bash
    CERT_NAME_IN_KV=openlab-certificate
    az keyvault certificate creates \
        --vault-name $KEYVAULT_NAME \
        --name $CERT_NAME_IN_KV \
        --policy @result-policy.json
    ```
