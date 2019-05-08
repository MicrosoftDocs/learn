TLS Transport encryption is an important step to ensure your application is secure.

You want to implement end-to-end encryption for the shipping portal application, to make sure all data transmitted between your users and your server is encrypted and nobody can intercept and read the data.

In this unit, you'll setup the web application and Application Gateway. Next you will create some self-signed TLS certificates and enable encryption in your backend pool to secure the traffic from the Application Gateway to your servers.

## Setup

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using your MSLearn account.

1. In the Cloud Shell window on the right, run the following command to download the source code for the shipping portal:

    ```bash
    git clone http://github.com/<location of repository>/shipping portal
    ```

1. Move to the ShippingPortal folder:

    ```bash
    cd shippingportal
    ```

1. Run the setup script to create the virtual machine and Application Gateway

    ```bash
    ./setup-infra.sh
    ```

## Configure backend pools for encryption

1. Get the virtual machine private IP address

    ```bash
    privateip="$(az vm list-ip-addresses --resource-group $rgName --name webservervm1 --query "[0].virtualMachine.network.privateIpAddresses[0]" --output tsv)"
    ```

1. Setup backend pool via the CLI

    ```bash
    az network application-gateway address-pool create --resource-group $rgName --gateway-name gw-shipping --name ap-backend --servers $privateip
    ```

1. Upload SSL certificate to be used by the Application Gateway

    ```bash
     az network application-gateway ssl-cert create --resource-group $rgName --gateway-name gw-shipping --name shipping-ssl-cert --cert-file server-config/shipping-ssl.pfx --cert-password <YOURPASSWORD>
    ```

1. Upload Authorization certificate

    ```bash
    az network application-gateway auth-cert create --resource-group $rgName --gateway-name gw-shipping --name shipping-auth-cert --cert-file server-config/shipping-ssl.crt
    ```

1. Create HTTP settings via the CLI

    ```bash
    az network application-gateway http-settings create --resource-group $rgName --gateway-name gw-shipping --name https-settings --port 443 --protocol Https --auth-certs shipping-auth-cert
    ```