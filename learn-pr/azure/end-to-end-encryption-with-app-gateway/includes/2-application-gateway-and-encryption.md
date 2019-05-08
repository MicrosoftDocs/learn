Encrypting your data while it's in transit is an important step to securing your application. Purchasing TLS certificates from a known reputable provider and using this means that when your users request a page or send data back to your application nobody can intercept and read that data since it is encrypted.

In the shipping portal, encryption is really important, as we are dealing with shipping customer orders. If someone could get access to the data that is transmitted to and from the shipping portal they might be able to view the customer data or place orders on behalf of the customer.

In this unit you will learn the benefits of the Application Gateway, and the how transport encryption is applied to the Application Gateway.

## Application Gateway and its benefits

The Application Gateway allows you to encrypt your traffic of your application, this can either be done by offloading the SSL or it can provide end-to-end encryption (E2EE) all the way to your servers.

The benefits of terminating your SSL at the Application Gateway means you offload the CPU intensive workload of SSL termination from your servers, it also means that you do not need to setup SSL on your servers and install the certificates.

If you require end-to-end encryption all the way through, the Application Gateway also supports this by decrypting the SSL on the gateway using your private key (the same private certificate that you install on your server), and then re-encrypting again with your public key (the same public certificate that users have in their browsers).

Exposing your website or web application through the Application Gateway also means that you don't directly publicly expose your servers to the web. You are only exposing port 80 and port 443 and directing this traffic to your web servers. This is good, as it means that your web servers aren't exposed to other ports and vulnerabilities that might exist outside of the internet traffic on port 80 and 443.

## Application Gateway components

The Application Gateway has a few things to configure to get all of this working. But the main two parts are the Frontend Listener, and the Backend Pool.

### Frontend Listener

The Frontend Listener is the first thing that your traffic meets when entering the gateway. It is setup to listen for a specific hostname, a specific port on a specific IP address, and it uses your private SSL certificate to decrypt the traffic that comes into the gateway. It also has a Rule associated to it, which tells it what Backend Pool to use to direct traffic to.

### Backend Pool

The Backend Pool is where your servers will be setup, this can be either one or many servers or IP addresses or App Services. The Backend Pool has an HTTP setting that contains your public certificate which re-encrypts the traffic before sending it onto one of your servers that are configured in the Backend Pool.