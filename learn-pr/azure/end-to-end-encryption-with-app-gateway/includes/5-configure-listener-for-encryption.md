You've configured SSL for the connection between Azure Application Gateway and the servers in the backend pool. For the shipping portal, you need full end-to-end encryption. To do this encryption, you'll also need to encrypt the messages that the client sends to Application Gateway.

## Create a frontend port

Application Gateway receives requests through one or more ports. If you're communicating with the gateway over HTTPS, you should configure an SSL port. Traditionally, HTTPS uses port 443. Use the `az network application-gateway frontend-port create` command to create a new frontend port. The following example shows how to create a frontend port for port 443:

```azurecli
az network application-gateway frontend-port create \
    --resource-group $rgName \
    --gateway-name gw-shipping  \
    --name my-https-port \
    --port 443
```

## Configure a listener

A listener waits for incoming traffic to the gateway on a specified frontend port. This traffic is then routed to a server in the backend pool. If the frontend port uses SSL, you need to indicate the certificate to use for decrypting incoming messages. The certificate includes the private key.

You can add the certificate by using the `az network application-gateway ssl-cert create` command. The certificate file should be in PFX format. Because this file contains the private key, it will also likely be password protected. You provide the password in the `cert-password` argument, as shown in the following example.

 ```azurecli
az network application-gateway ssl-cert create \
    --resource-group $rgName \
    --gateway-name gw-shipping \
    --name shipping-ssl.crt \
    --cert-file shippingportal/server-config/shipping-ssl.pfx \
    --cert-password <password for certificate file>
```

You can then create the listener that receives requests from the frontend port and decrypts them by using this certificate. Use the `az network application-gateway http-listener create` command.

```azurecli
az network application-gateway http-listener create \
    --resource-group $rgName \
    --gateway-name gw-shipping \
    --name http-listener \
    --frontend-port my-https-port \
    --ssl-cert shipping-ssl.crt
```

## Define a rule to send HTTPS requests to the servers

The final step is to create a rule that directs the messages received through the listener to the servers in the backend pool. The messages received from the frontend port are decrypted through the SSL certificate specified for the listener. You need to re-encrypt these messages by using the client-side certificate for the servers in the backend pool. You define this information in the rule.

The following example shows how to use the `az network application-gateway rule create` command to create a rule that connects a listener to a backend pool. The `--http-settings` parameter specified the HTTP settings that reference the client-side certificate for the servers. You created these settings in the previous unit.

```azurecli
az network application-gateway rule create \
    --resource-group $rgName \
    --gateway-name gw-shipping \
    --name app-gw-rule \
    --address-pool ap-backend \
    --http-listener http-listener \
    --http-settings https-settings \
    --rule-type Basic
    --priority 101
```

You should now have complete end-to-end encryption for messages routed through Application Gateway. Clients use the SSL certificate for Application Gateway to send messages. Application Gateway decrypts these messages by using this SSL certificate. It then re-encrypts the messages by using the certificate for the servers in the backend pool.
