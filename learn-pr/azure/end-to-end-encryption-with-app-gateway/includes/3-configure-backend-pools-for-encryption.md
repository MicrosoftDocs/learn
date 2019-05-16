The backend pool contains the servers that implement the application. Application Gateway routes requests to these servers, and can load balance the traffic across these servers.

In the shipping portal, the application servers in the backend pool must use SSL to encrypt the data that passes between Application Gateway and the servers in the backend pool. In this unit, you'll see how to create the backend pool and install the necessary certificates in Application Gateway to protect the messages that are transmitted to and from the backend pool.

## Backend pool

A backend pool can reference individual virtual machines, a virtual machine scale-set, the IP addresses of real computers (either on-premise or running remotely), or services hosted by using Azure App Service. However you implement the servers in the backend pool, they should all be configured in the same way, and this includes their security settings.

If the traffic directed to the backend pool is protected by using SSL, then each server in the backend pool must provide a suitable certificate. For testing purposes, you can create a self-signed certificate, but in a production environment you should always generate or purchase a certificate that can be authenticated by a trusted provider.

> [!IMPORTANT]
> The exercise that follows uses the *openssl* utility to create self-signed certificates. It is important to understand that these certificates are for testing only. They are unverifiable, and you should never use them in a real system.

## Client-side certificates for the backend pool

Application Gateway requires that you install the client-side certificate (also called the *authorization certificate*) for the servers in the gateway configuration. This certificate contains the public key that Application Gateway can use to encrypt messages and authenticate your servers. You can create this certificate by exporting it from the server. The server-side certificate contains the private key for decrypting these messages, and should only be stored in your application servers.

You can add a client-side certificate to Application Gateway using the `az network application-gateway auth-cert create` command from the Azure CLI. The following example illustrates the syntax of this command. The *\<certificate name>* argument is a name that you use to reference the certificate in Application Gateway. The *\<client-side certificate>* argument specifies a file containing the certificate. The certificate should be in CER (Claim, Evidence, and Reasoning) format.

```azurecli
az network application-gateway auth-cert create \
    --resource-group <resource group name> \
    --gateway-name <application gateway name> \
    --name <certificate name> \
    --cert-file <client-side certificate>
```

Application Gateway provides other commands that you can use to list and manage client-side certificates. For example, the `az network application-gateway auth-cert list` command shows the certificates that have been installed, the `az network application-gateway auth-cert update` command can be used to change the certificate, and the `az network application-gateway auth-cert delete` command removes a certificate.

## HTTP settings

Application Gateway uses a *rule* to specify how to direct the messages that it receives on its incoming port to the servers in the backend pool. If the servers are using SSL, then you must configure the *rule* to indicate that the servers expect traffic using the HTTPS protocol, and which certificate to use to encrypt traffic and authenticate the connection to a server. You define this configuration information using an *HTTP Setting*.

Define HTTP setting information using the `az network application-gateway http-settings create` command in the Azure CLI. The example below shows the syntax for creating a setting that routes traffic using the HTTPS protocol to port 443 on the servers in the backend pool. The *\<certificate name>* argument is the name of the client-side certificate that you added to Application Gateway previously.

```azurecli
az network application-gateway http-settings create \
    --resource-group <resource group name> \
    --gateway-name <application gateway name> \
    --name <HTTPS settings name> \
    --port 443 \
    --protocol Https \
    --auth-certs <certificate name>
```