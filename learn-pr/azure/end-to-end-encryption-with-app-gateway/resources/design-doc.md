
# Module Design

## Title

Encrypt network traffic end-to-end with Azure Application Gateway

## Role(s)

- Solution architect
- Developer

## Level

- Intermediate

## Product(s)

- Azure Application Gateway

## Prerequisites

- Basic understanding of SSL/TLS encryption
- Basic knowledge of PowerShell
- Basic knowledge of networking concepts

## Summary

Secure the traffic from your end user all the way through to your web servers by enabling TLS encryption on Application Gateway.

## Learning objectives

- Implement TLS encryption between your end users and Application Gateway
- Implement TLS encryption between Application Gateway and your web server

## Chunk your content into subtasks

Identify the subtasks of *Encrypt network traffic end-to-end with Azure Application Gateway*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- |---|---|---|---|
| Explain the benefits of using Application Gateway to encrypt network traffic | Encrypt network traffic between the user and backend application | Knowledge check & exercise | 1, 2 | Yes |
| Setup backend pools | Enable TLS encryption to the backend application | Exercise | 2 | Yes |
| Create listeners | Enable TLS encryption for incoming requests | Exercise | 1 | Yes |

## Outline the units

1. **Introduction**

    A retail organization has a new shipping portal they are publishing to allow vendors to ship customer items and track status. This exposes business and customer data, and needs to be encrypted between the user and the back end application to ensure this data is not exposed while transmitted over the network. They have implemented Application Gateway to load balance their traffic, and need to enable TLS encryption between the user and their servers.

1. **Application Gateway and encryption**

    List the content that will enable the learner to *Explain the benefits of using Application Gateway to encrypt network traffic*:

    - Define Application Gateway and its benefits
        - Application Gateway is an Azure service that sits between your web application and the internet
        - Offloads CPU intensive SSL termination
        - Allows SSL to be terminated at the gateway or end-to-end encryption all the way to your server
        - Your servers aren't directly linked to your domain, everything is routed through the Application Gateway public IP address
    - Explain how it works and the parts that are needed
        - Frontend listener
            - Private certificate to decrypt traffic on the gateway
        - Backend pool
            - Public certificate to route traffic to the server

   **Knowledge check**

    What types of questions will test *Explain the benefits of using Application Gateway to encrypt network traffic*?

    - What are the benefits of using an Application Gateway?
    - What is needed to configure an Application Gateway?

1. **Configure backend pools for encryption**

    - Explain what the backend pool is used for
        - Collection of servers/IP addresses
    - Explain what the HTTP setting is for, and the details
        - Used to re-encrypt the traffic to send back to the server from the Application Gateway
        - Needs public SSL certificate

1. **Exercise - Configure backend pools for encryption**

    List the steps which apply the learning content from previous unit:

    1. Setup a Virtual Machine with a sample ASP.NET Core MVC web application. Also setup Application Gateway with the virtual network, Frontend IP configuration etc already configured. This should be done via the CLI.

    1. Setup backend pool via the CLI

        ``` azurecli
        az network application-gateway address-pool create --resource-group rg-gw-shipping --gateway-name gw-shipping --name ap-backend --servers 10.0.1.1
        ```

    1. Create self-signed SSL certificate using openssl to be used for the Application Gateway. This is for demonstration only, you should use a certificate from a trusted provider.

        It will prompt you for some details to add to the SSL certificate, country code, company name etc, you can leave these blank.

        ``` azurecli
        openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout shipping-ssl.key -out shipping-ssl.crt
        ```

        Run the following openssl command to export the certificate as pfx, it will prompt you for a password and to confirm  to export it. Choose whatever password you would like.

        ``` azurecli
        openssl pkcs12 -export -out shipping-ssl.pfx -inkey shipping-privatekey.key -in shipping-ssl.crt
        ```

    1. Upload SSL certificate to be used by the Application Gateway

            ``` azurecli
            az network application-gateway ssl-cert create --resource-group rg-gw-shipping --gateway-name gw-shipping --name shipping-ssl-cert --cert-file shipping-ssl.pfx --cert-password <your password>
            ```

    1. Upload Authorization certificate

        ``` azurecli
        az network application-gateway auth-cert create --resource-group rg-gw-shipping --gateway-name gw-shipping --name shipping-auth-cert --cert-file shipping-ssl.crt
        ```

    1. Create HTTP settings via the CLI
    
        ``` azurecli
        az network application-gateway http-settings create --resource-group rg-gw-shipping --gateway-name gw-shipping --name https-settings --port 443 --protocol Https --auth-certs shipping-auth-cert
        ```

1. **Configure Application Gateway listener for encryption**

    - Explain what the listener is for
        - Listens to a Frontend IP configuration for a configured port
    - Needed to create the listener:
        - Frontend IP configuration
        - Frontend port (443)
        - Uploaded SSL certificate

1. **Exercise - Configure Application Gateway listener for encryption**

    List the steps which apply the learning content from previous unit:

    1. Create a new frontend port (443) via the CLI

        ``` azurecli
        az network application-gateway frontend-port create --resource-group rg-gw-shipping --gateway-name gw-shipping --name https-port --port 443
        ```

    1. Create the new Listener with via the CLI

        ``` azurecli
        az network application-gateway http-listener create --resource-group rg-gw-shipping --gateway-name gw-shipping --name httpslistener --frontend-port https-port --ssl-cert shipping-ssl-cert
        ```

    1. Test the Application Gateway  

    1. Find the fully qualified domain name of the Application Gateway IP address:

        ```azurecli
        az network public-ip show --resource-group rg-gw-shipping --name gw-shipping
        ```

    1. Using a web browser, navigate to \<ip address returned above\>

    1. Verify that the web page appears and the connection is over https.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?
    - Explained benefits of Application Gateway
    - Setup TLS using Application Gateway to existing Virtual Machine

## Notes

End-to-end encryption in AppGW - https://docs.microsoft.com/azure/application-gateway/application-gateway-end-to-end-ssl-powershell

AppGW takes a while to spin up, so for the exercise we may want to kick that off early, go over some concepts, then come back when it's running. We'll also need a server with a basic web site that we can use to test. Don't use VMSS like the example as they are not available in the sandbox environment, just use a single VM.

Suggestion for video might be an overview of the traffic flow and how the encrypted traffic flows through.