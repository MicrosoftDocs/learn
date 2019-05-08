Now that we have our Application Gateway configured and backend pool setup, we need to create our listener. The listener will detect traffic for our hostname and decrypt it using the private certificate and route the traffic to the backend pool.

In this unit, you'll set up the listener with port 443 and with the TLS certificate you created in the first exercise.

## Configure listener

1. In the Cloud Shell window on the right, run the following command create a new frontend port (443)

    ``` bash
    az network application-gateway frontend-port create \
      --resource-group $rgName \
      --gateway-name gw-shipping \
      --name https-port --port 443
    ```

1. Now run the following command to create the new listener

    ``` bash
    az network application-gateway http-listener create \
      --resource-group $rgName \
      --gateway-name gw-shipping \
      --name httpslistener \
      --frontend-port https-port \
      --ssl-cert shipping-ssl-cert
    ```

## Test the Application Gateway

1. Find the fully qualified domain name of the Application Gateway IP address:

    ```bash
    az network public-ip show \
      --resource-group $rgName \
      --name gw-shipping
    ```

1. Using a web browser, navigate to \<ip address returned above\>

1. Verify that the web page appears and the connection is over https.

You have now configured the listener to listen on port 443 and decrypt the data ready to be passed to the backend pool.

With the listener in place you now have setup end-to-end encryption for the shipping portal.