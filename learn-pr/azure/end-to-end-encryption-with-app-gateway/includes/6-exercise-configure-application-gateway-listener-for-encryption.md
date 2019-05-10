Having configured the certificates for Application Gateway and the backend pool, you can create a listener to handle incoming requests. The listener will wait for messages, decrypt them using the private certificate, and then route theses messages to the backend pool.

In this unit, you'll set up the listener with port 443 and with the TLS certificate you created in the first exercise.

## Configure listener

[!include[](../../../includes/azure-sandbox-activate.md)]

1. In the Cloud Shell window on the right, create a variable named *rgName* that references the sandbox resource group:

    ```bash
    export rgName=<rgn>[Sandbox resource group]</rgn>
    ```

1. Run the following command create a new frontend port (443) for the gateway:

    ```azurecli
    az network application-gateway frontend-port create \
      --resource-group $rgName \
      --gateway-name gw-shipping \
      --name https-port --port 443
    ```

1. Run the following command to create a new listener that accepts incoming traffic on port 443. The listener uses the certificate *shipping-ssl-cert* to decrypt messages:

    ```azurecli
    az network application-gateway http-listener create \
      --resource-group $rgName \
      --gateway-name gw-shipping \
      --name https-listener \
      --frontend-port https-port \
      --ssl-cert shipping-ssl-cert
    ```

1. Run the following command to create a rule that directs traffic received using the new listener to the backend pool.

    ```azurecli
    az network application-gateway rule create \
        --resource-group $rgName \
        --gateway-name gw-shipping \
        --name https-rule \
        --address-pool ap-backend \
        --http-listener https-listener \
        --http-settings https-settings \
        --rule-type Basic
    ```

## Test the Application Gateway

1. Find the fully qualified domain name of the Application Gateway IP address:

    ```azurecli
    az network public-ip show \
      --resource-group $rgName \
      --name appgwipaddr \
      --query "dnsSettings.fqdn"
    ```

2. Using a web browser, navigate to **https://\<fqdn\>** where *\<fqdn\> is the address of the Application Gateway returned by the previous command.

3. Verify that the web page appears, and the connection is made over an HTTPS connection.

You've now configured the listener to listen on port 443 and decrypt the data ready to be passed to the backend pool. With the listener in place, you have set up end-to-end encryption for the shipping portal.