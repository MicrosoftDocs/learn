Encrypting your data while it's in transit is an important step to securing your applications. You can purchase certificates from a certificate authority and use them to encrypt the messages that pass in and out of your servers. This prevents unauthorized users from being able to intercept and examine the information in these messages while they are being transmitted.

In the shipping portal, encryption is important, as we're dealing with shipping customer orders. If someone were able to access the data that is transmitted they could view sensitive information, such as customer details or financial account data.

To secure this data, you can use Application Gateway to ensure your data is encrypted while traversing the network from your end users to your application servers.

## Application Gateway and its benefits

Azure Application Gateway is an application delivery controller that provides several features such as load balancing HTTP traffic, web application firewall, and support for SSL encryption of your data. Application Gateway supports encrypting traffic between your user and the Application Gateway, and between your application servers and Application Gateway.

![Image showing a representation of Application Gateway](../media/2-application-gateway.svg)

When you terminate the SSL connection at the application gateway, it offloads the CPU intensive SSL termination workload from your servers. Also, you don’t need to install certificates and configure SSL on your servers.

If you require end-to-end encryption, Application Gateway can decrypt the traffic on the gateway using your private key and then re-encrypt again with the public key of the service running in the backend pool.

Exposing your website or web application through the Application Gateway also means that you don't directly connect your servers to the web. You're only exposing port 80 or port 443 on the Application Gateway. Your web servers aren't directly accessible from the Internet, reducing the attack surface of your infrastructure.

## Application Gateway components

Application Gateway comprises several components. But the main parts as far as encryption is concerned are the frontend port, listener, and the backend pool.

The following image shows how incoming traffic from a client to Application Gateway over SSL is decrypted and then re-encrypted when it is sent to server in the backend pool.

![Image showing how messages are decrypted and re-encrypted in an end-to-end SSL configuration with Application Gateway ](../media/2-components.svg)

### Frontend port and listener

Traffic enters the gateway through a frontend port. You can open many ports, and Application Gateway can receive messages on any of these ports. A listener is the first thing that your traffic meets when entering the gateway through a port. It's set up to listen for a specific hostname, and a specific port on a specific IP address. The listener can use an SSL certificate to decrypt the traffic that comes into the gateway. The listener then uses a rule that you define to direct the incoming requests to a backend pool.

### Backend pool

The backend pool contains your application servers. These servers could be virtual machines, a virtual machine scale set, or applications running on Azure App Service. Incoming requests can be load-balanced across the servers in this pool. The backend pool has an HTTP setting that references a certificate used to authenticate the backend servers. The gateway re-encrypts the traffic using this certificate before sending it to one of your servers in the backend pool.

If you are using Azure App Service to host the backend application, you don't need to install any certificates in Application Gateway to connect to the backend pool. All communications are automatically encrypted, and the servers are trusted by Application Gateway because they are managed by Azure.
