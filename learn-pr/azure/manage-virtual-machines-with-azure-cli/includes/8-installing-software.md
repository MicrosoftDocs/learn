The last thing we want to try on our VM is to install a web server. One of the easiest packages to install is `nginx`.

## Install NGINX web server

1. Locate the public IP address of your *SampleVM* Linux virtual machine.

    ```azurecli
    az vm list-ip-addresses --name SampleVM --output table
    ```

1. Next, open an `ssh` connection to *SampleVM* using the Public IP address from the preceding step.

    ```bash
    ssh azureuser@<PublicIPAddress>
    ```

1. After you're logged in to the virtual machine, run the following command to install the `nginx` web server. The command will take a few moments to complete.

    ```bash
    sudo apt-get -y update && sudo apt-get -y install nginx
    ```

1. Exit the Secure Shell:

    ```bash
    exit
    ```

## Retrieve your default page

1. In Azure Cloud Shell, use `curl` to read the default page from your Linux web server by running the following command, replacing `<PublicIPAddress>` with the public IP you found previously. You can also open a new browser tab and try to browse to the public IP address.

    ```bash
    curl -m 80 <PublicIPAddress>
    ```

    This command will fail, because the Linux virtual machine doesn't expose port 80 (`http`) through the network security group that secures the network connectivity to the virtual machine. We can fix the failure by running the Azure CLI command `vm open-port`.

1. Enter the following command into Cloud Shell to open port 80:

    ```azurecli
    az vm open-port \
        --port 80 \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --name SampleVM
    ```

    It will take a moment to add the network rule and open the port through the firewall.

1. Run the `curl` command again.

    ```bash
    curl -m 80 <PublicIPAddress>
    ```

    This time, it should return data like the following. You can see the page in a browser as well.

    ```html
    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>

    <p>For online documentation and support, refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>

    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>
    ```
