Before we cover some of the common ways to run, list, and delete containers, let's see a basic Nginx configuration running on a Docker container that's hosted on an Ubuntu virtual machine (VM).

In this part, you'll learn how to:

1. Create a Linux VM that's configured to install Docker when the VM first boots.
1. Connect to your VM and start a Docker container running Nginx.
1. Use port binding to make your web server accessible from outside the VM.

## What are containers?

A container is a virtualization environment but, unlike a virtual machine, it does not always include a full operating system. Instead, it references the operating system of the host environment that runs that container. For example, if you run five containers on a server with a specific Linux kernel, all five containers are running on that same kernel.

Containers enable you to package your application and everything that it needs to run into what's known as a _container image_. Containers are isolated, which means they don't interfere with any other container running on the same system. Container images are also portable. You can upload your images to a container registry, such as Docker Hub or Azure Container Registry. You can then run your containers in the cloud and expect them to behave the exact same way as they do in your development environment.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yMhY]

Containers enable rapid iteration. Because containers don't need to include an operating system, they're typically much smaller than full VMs. This enables you to start and stop containers quickly, often in seconds.

## Understand the setup

For learning purposes, we provide a sandbox environment for you to work in. This environment includes Azure Cloud Shell, a browser-based command-line experience for managing and developing Azure resources.

From Cloud Shell, you'll create a Linux VM that includes Docker. You'll connect to your Linux VM over SSH so that you can interactively create and use Docker containers.

Think of this Linux VM as your development environment and a space to learn about containers. In practice, you would install Docker on the computer you use to develop your apps. Docker runs on Windows, macOS, and Linux.

We'll provide resources where you can learn more about running Docker in your local development environment at the end of this module.

## What is Nginx?

Nginx (pronounced "engine-x") is a popular, free, open-source web server that runs on Unix, Linux, macOS, and Windows. Configuring a web server is a good way to see containers in action. Here you'll use Nginx to serve a basic web page.

## What is cloud-init?

Cloud-init enables you to customize a Linux VM as it boots for the first time. You can use cloud-init to install packages and write files, or to configure users and security. Here you'll use a cloud-init script to install Docker on your VM.

## What is port binding?

Port binding enables you to forward network traffic to a container from its host.

A Docker container runs on a local network on the container's host system. In this case, the container's network will be on your Linux VM.

You know that web requests typically run over port 80 (HTTP). Because the container is running on a local network inside your VM, the container is not accessible to the outside world.

Docker enables you to publish, or expose, a port to make it accessible from outside the VM. Here, you'll configure your container so that network traffic to port 8080 on your VM will be forwarded to port 80 on your container.

## Create a virtual machine to host Docker

[!include[](../../../includes/azure-sandbox-activate.md)]

### Create the cloud-init script

1. Navigate to the **clouddrive** folder.

    ```azurecli
    cd clouddrive
    ```

1. Create a new file using Cloud Shell's integrated editor.

    ```azurecli
    code .
    ```

1. Paste this cloud-init script into the editor.

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    ```yaml
    #cloud-config
    package_upgrade: true
    write_files:
      - path: /etc/systemd/system/docker.service.d/docker.conf
        content: |
          [Service]
          ExecStart=
          ExecStart=/usr/bin/dockerd
      - path: /etc/docker/daemon.json
        content: |
          {
            "hosts": ["fd://","tcp://127.0.0.1:2375"]
          }
    runcmd:
      - curl -sSL https://get.docker.com/ | sh
      - usermod -aG docker azureuser
    ```

1. Save the file as **docker-vm-config.txt** (<kbd>Ctrl+S</kbd> or right click and select **Save**).

1. Close the editor (<kbd>Ctrl+Q</kbd> or right click and select **Quit**).

### Create the VM

> [!IMPORTANT]
> Normally, you would create a resource group for all your related Azure resources with the `az group create` command, but for these exercises one has been created for you. Use "**<rgn>[sandbox resource group name]</rgn>**" as your resource group in all the steps.

1. Run this `az vm create` command to create your Linux VM.

    ```azurecli
    az vm create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name DockerVM \
      --image UbuntuLTS \
      --admin-username azureuser \
      --generate-ssh-keys \
      --custom-data docker-vm-config.txt
    ```

The `--custom-data` argument specifies the cloud-init script that installs Docker when the VM first boots. The process will take a few minutes to complete.

## Connect to the VM

Here you'll create an SSH connection to your VM so that you can configure it.

1. Run this `az vm show` command to get your VM's IP address.

    ```azurecli
    az vm show \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name DockerVM \
      --show-details \
      --query [publicIps] \
      --o tsv
    ```

1. SSH into the VM. Replace **ip-address** with yours.

    ```bash
    ssh azureuser@ip-address
    ```

1. Verify the Docker version.

    ```bash
    docker version
    ```

    > [!NOTE]
    > If the command fails, or you see an error message about connecting to the Docker daemon socket, that means that the cloud-init script hasn't yet completed. Although there are ways to wait for the script to complete, for now run `exit` to leave your SSH session and try reconnecting in a minute or two.

## Start Nginx

Here you'll start a Docker container that's running Nginx.

1. Run this `docker run` command to start a Docker container running Nginx.

    ```bash
    docker run -d -p 8080:80 --name nginx nginx
    ```

    The command downloads a Docker image that's preconfigured with Nginx from [Docker Hub](https://hub.docker.com/_/nginx?azure-portal=true).

    The `--name` argument assigns the name "nginx" to your Docker container so you can work with it later.

    The `-p` argument forwards network traffic to port 8080 on your VM to port 80 on your container.

1. Run `curl` to verify that Nginx is running and accessible.

    ```bash
    curl http://localhost:8080
    ```

1. Exit your SSH session.

    ```bash
    exit
    ```

## Access your web server from a web browser

Recall that you configured your container so that network traffic on port 8080 is forwarded to port 80 on your container.

To see port mapping in action, here you'll open port 8080 to your VM through the Azure firewall. Then you'll access your web server from a browser.

1. Run this `az vm open-port` command to open port 8080 on your VM through the firewall.

    ```azurecli
    az vm open-port \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name DockerVM \
      --port 8080 \
      --priority 1001
    ```

1. From a web browser, navigate to your VM's IP address. Be sure to include port 8080, for example,  **http://40.121.106.164:8080**.

    You see the default home page.

    ![The web site running in a browser](../media/2-nginx-browser.png)

## Stop the container

Now let's stop the container.

1. First, log back in to your VM. Here's a refresher.

    Get the IP address.

    ```azurecli
    az vm show \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name DockerVM \
      --show-details \
      --query [publicIps] \
      --o tsv
    ```

    SSH into the VM. Replace **ip-address** with yours.

    ```bash
    ssh azureuser@ip-address
    ```

1. Run `docker stop nginx` to stop the container named "nginx".

    ```bash
    docker stop nginx
    ```

Keep your SSH connection open for the next part.

Congratulations! You've successfully created a virtual machine and used it to host an Nginx containerized web server.
