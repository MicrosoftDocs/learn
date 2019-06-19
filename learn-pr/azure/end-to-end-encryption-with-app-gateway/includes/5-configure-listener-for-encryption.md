You have configured SSL for the connection between Application Gateway and the servers in the backend pool. For the shipping portal you need full end-to-end encryption. To do this, you'll also need to encrypt the messages that the client sends to Application Gateway.

## Create a frontend port

Application Gateway receives requests using one or more ports. If you're communicating with the gateway over HTTPS, you should configure an SSL port. Traditionally, HTTPS uses port 443. Use the `az network application-gateway frontend-port create` command to create a new frontend port. The following example shows how to create a frontend port for port 443:

```azurecli
az network application-gateway frontend-port create \
    --resource-group <resource group name> \
    --gateway-name <application gateway name>  \
    --name <port name>
    --port 443
```

## Configure a listener

A listener waits for incoming traffic to the gateway on a specified frontend port. This traffic is then routed to a server in the backend pool. If the frontend port uses SSL, you need to indicate the certificate to use to decrypt incoming messages. This is a certificate that includes the private key. You can add the certificate using the `az network application-gateway ssl-cert create` command. The certificate file should be in PFX format. As this file contains the private key, it will also likely be password protected. You provide the password in the `cert-password` argument, as shown in the following example.

 ```azurecli
az network application-gateway ssl-cert create \
    --resource-group <resource group name> \
    --gateway-name <application gateway name> \
    --name <ssl certificate name> \
    --cert-file <SSL certificate file (PFX)> \
    --cert-password <password for certificate file>
```

You can then create the listener that receives requests from the frontend port and decrypts them using this certificate. Use the `az network application-gateway http-listener create` command.

```azurecli
az network application-gateway http-listener create \
    --resource-group <resource group name> \
    --gateway-name <application gateway name> \
    --name <listener name> \
    --frontend-port <frontend port name> \
    --ssl-cert <ssl certificate name>
```

## Define a rule to send HTTPS requests to the servers

The final step is to create a rule that directs the messages received using the listener to the servers in the backend pool. The messages received from the frontend port are decrypted by using the SSL certificate specified for the listener. These messages need to be re-encrypted by using the client-side certificate for the servers in the backend pool. You define this information in the rule. The following example shows how to use the `az network application-gateway rule create` command to create a rule that connects a listener to a backend pool. The `--http-settings` parameter specified the HTTP settings that reference the client-side certificate for the servers. You create these settings in the previous unit.

```azurecli
az network application-gateway rule create \
    --resource-group <resource group name> \
    --gateway-name <application gateway name> \
    --name <rule name> \
    --address-pool <backend pool> \
    --http-listener <listener name> \
    --http-settings <HTTPS settings name> \
    --rule-type Basic
```

You should now have complete end-to-end encryption for messages routed through Application Gateway. Clients use the SSL certificate for Application Gateway to send messages. Application Gateway decrypts these messages using this SSL certificate, and then re-encrypts the messages using the certificate for the servers in the backend pool.
