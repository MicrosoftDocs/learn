Now that your VM is up and running, let's do something with it. Here you'll install a web server and serve up a basic web page that displays the VM's hostname.

To configure a VM, you have several choices. You can connect directly and interactively configure your system. For example, on Windows systems you can create a Remote Desktop session to connect to the UI of your remote Windows computer as if you were seated at it. On Linux systems, you can create an SSH connection to securely work with your remote Linux system from the terminal.

Manual configuration is a good start, but as you add systems, you can automate your deployments. Automation involves running repeatable processes such as programs and scripts that take care of the heavy lifting for you.

::: zone pivot="windows-cloud"

Here, you'll configure IIS remotely from your Cloud Shell session using a feature of Windows-based Azure virtual machines called the Custom Script Extension.

::: zone-end

::: zone pivot="linux-cloud"

Here, you'll configure Nginx remotely from your Cloud Shell session using a feature of Linux-based Azure virtual machines called the Custom Script Extension.

::: zone-end

::: zone pivot="windows-cloud"

## What is IIS?

Internet Information Services, or IIS, is a web server that runs on Windows. You can use IIS to serve standard web content (HTML, CSS, and JavaScript) or run ASP.NET and other kinds of web applications. IIS comes with Windows Server, but you need to activate it to start serving web pages.

## What's the Custom Script Extension?

The Custom Script Extension is an easy way to download and run scripts on your Azure VMs. It's just one of the many ways you can configure the system once your VM is up and running.

You can store your scripts in Azure storage or in a public location such as GitHub. You can run scripts manually or as part of a more automated deployment. Here, you'll run an Azure CLI command to download a PowerShell script from GitHub and execute it on your VM. The script configures IIS.

## Configure IIS

<!-- TODO: https://github.com/MicrosoftDocs/learn-pr/issues/1864 -->

Here you'll use the Custom Script Extension to configure IIS remotely on your VM from Cloud Shell. You'll also configure the firewall to allow inbound network access on port 80 (HTTP).

1. From Cloud Shell, run this `az vm extension set` command to download and execute a PowerShell script that installs IIS and configures a basic home page.

    ```azurecli
    az vm extension set \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --vm-name myVM \
      --name CustomScriptExtension \
      --publisher Microsoft.Compute \
      --settings '{"fileUris":["https://gist.githubusercontent.com/tpetchel/26f9dab2628a80bf87a33caeed1b6ded/raw/69e5d9250b9dcd7e7eece4b0ea3c3a8cd1b4fcd7/configure-iis.ps1"]}' \
      --protected-settings '{"commandToExecute": "powershell -ExecutionPolicy Unrestricted -File configure-iis.ps1"}'
    ```

    The process to configure IIS, set the contents of the homepage, and start the service takes a couple minutes to complete.

    In the meantime, you can [examine the PowerShell script](https://gist.githubusercontent.com/tpetchel/26f9dab2628a80bf87a33caeed1b6ded/raw/69e5d9250b9dcd7e7eece4b0ea3c3a8cd1b4fcd7/configure-iis.ps1?azure-portal=true) from a separate browser tab if you'd like. The script installs IIS and configures the home page to display a welcome message along with the VM's computer name, "myVM".

1. Run this `az vm open-port` command to open port 80 (HTTP) through the firewall.

    ```azurecli
    az vm open-port \
      --name myVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --port 80
    ```

## Verify the configuration

Now that IIS is set up, let's verify that it's running.

1. Run this `az vm list-ip-addresses` command to list your VM's public IP addresses.

    ```azurecli
    az vm list-ip-addresses \
      --name myVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query "[].virtualMachine.network.publicIpAddresses[0].ipAddress" \
      --output tsv
    ```

    > [!NOTE]
    > This `--query` argument makes this command a bit complex. But you'll be a pro at this as you dig in and explore Azure.

    You see your VM's public IP address. Here's an example.

    ```output
    104.211.9.245
    ```

1. In a new browser tab, navigate to your VM's IP address. You see your welcome message and your VM's name.

    ![](../media/4-iis-browser.png)

::: zone-end

::: zone pivot="linux-cloud"

## What is Nginx?

Nginx (pronounced "engine-x") is a popular, free, open-source web server that runs on Unix, Linux, macOS, and Windows. Here you'll use Nginx to serve a basic web page.

## What's the Custom Script Extension?

The Custom Script Extension is an easy way to download and run scripts on your Azure VMs. It's just one of the many ways you can configure the system once your VM is up and running.

You can store your scripts in Azure storage or in a public location such as GitHub. You can run scripts manually or as part of a more automated deployment. Here, you'll run an Azure CLI command to download a Bash script from GitHub and execute it on your VM. The script configures Nginx.

## Configure Nginx

<!-- TODO: https://github.com/MicrosoftDocs/learn-pr/issues/1864 -->

Here you'll use the Custom Script Extension to configure Nginx remotely on your VM from Cloud Shell. You'll also configure the firewall to allow inbound network access on port 80 (HTTP).

1. From Cloud Shell, run this `az vm extension set` command to download and execute a Bash script that installs Nginx and configures a basic home page.

    ```azurecli
    az vm extension set \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --vm-name myVM \
      --name customScript \
      --publisher Microsoft.Azure.Extensions \
      --settings '{"fileUris":["https://gist.githubusercontent.com/tpetchel/26f9dab2628a80bf87a33caeed1b6ded/raw/69e5d9250b9dcd7e7eece4b0ea3c3a8cd1b4fcd7/configure-nginx.sh"]}' \
      --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
    ```

    The process to configure Nginx, set the contents of the homepage, and start the service takes a couple minutes to complete.

    In the meantime, you can [examine the Bash script](https://gist.githubusercontent.com/tpetchel/26f9dab2628a80bf87a33caeed1b6ded/raw/69e5d9250b9dcd7e7eece4b0ea3c3a8cd1b4fcd7/configure-nginx.sh?azure-portal=true) from a separate browser tab if you'd like. The script installs Nginx and configures the home page to display a welcome message along with the VM's computer name, "myVM".

1. Run this `az vm open-port` command to open port 80 (HTTP) through the firewall.

    ```azurecli
    az vm open-port \
      --name myVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --port 80
    ```

## Verify the configuration

Now that Nginx is set up, let's verify that it's running.

1. Run this `az vm list-ip-addresses` command to list your VM's public IP addresses.

    ```azurecli
    az vm list-ip-addresses \
      --name myVM \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query "[].virtualMachine.network.publicIpAddresses[0].ipAddress" \
      --output tsv
    ```

    > [!NOTE]
    > This `--query` argument makes this command a bit complex. But you'll be a pro at this as you dig in and explore Azure.

    You see your VM's public IP address. Here's an example.

    ```output
    137.135.110.210
    ```

1. In a new browser tab, navigate to your VM's IP address. You see your welcome message and your VM's name.

    ![](../media/4-nginx-browser.png)

::: zone-end

## Summary

Your VM is running and can now serve up web pages, but what does that mean for you?

Remember, every journey starts with the basics, and almost any great innovation born in the cloud, from companies big and small, started with a similar setup to yours. As your idea evolves, it begins making a positive impact on your business and your users.