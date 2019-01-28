Your web server is up and running, but you realize you need more computing power to make the experience great for your users. How can you make your VM run faster?

In your data center, you might move your web server to more powerful hardware to solve performance problems. The problem is you need to buy, rack, and power your new system. With Azure, the answer is much simpler.

Before you scale up your VM to a more powerful size, let's first define what scale means.

## What is scale?

_Scale_ refers to adding network bandwidth, memory, storage, or compute power to achieve better performance.  

You may have heard the terms _scaling up_ and _scaling out_.

Scaling up, or vertical scaling, means to increase the memory, storage, or compute power on an existing virtual machine. For example, you can add additional memory to a web or database server to make it run faster.

Scaling out, or horizontal scaling, means to add extra virtual machines to power your application. For example, you might create many virtual machines configured in exactly the same way and use a load balancer to distribute work across them.

> [!TIP]
> The cloud is elastic. You can _scale down_ or _scale in_ your deployment if you needed to scale up or scale out only temporarily. Scaling down or scaling in can help you save money.<br><br>**Azure Advisor** and **Azure Cost Management** are two services that help you optimize cloud spend. You can use these services to identify where you're using more than you need, and then scale back to the capacity you're actually using.

## Scale up your VM

Recall that you specified the size **Standard_DS2_v2** when you created your VM. Your VM currently has two virtual CPUs and 7 GB of memory.

Let's bump up to the next size, **Standard_DS3_v2**. Your VM will then have four virtual CPUs and 14 GB of memory.

::: zone pivot="windows-cloud"

1. From Cloud Shell, run `az vm resize` to increase your VM's size to **Standard_DS3_v2**.

    ```azurecli
    az vm resize \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name myVM \
      --size Standard_DS3_v2
    ```
    The update process takes about a minute. Your VM restarts during the process.

1. Run `az vm show` to verify that your VM is running the new size.

    ```azurecli
    az vm show \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name myVM \
      --query "hardwareProfile" \
      --output tsv
    ```
    You see your new VM size, **Standard_DS3_v2**.
    ```output
    Standard_DS3_v2
    ```

::: zone-end

::: zone pivot="linux-cloud"

1. From Cloud Shell, run `az vm resize` to increase your VM's size to **Standard_DS3_v2**.

    ```azurecli
    az vm resize \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name myVM \
      --size Standard_DS3_v2
    ```
    The update process takes about a minute. Your VM restarts during the process.

1. Run `az vm show` to verify that your VM is running the new size.

    ```azurecli
    az vm show \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name myVM \
      --query "hardwareProfile" \
      --output tsv
    ```
    You see your new VM size, **Standard_DS3_v2**.
    ```output
    Standard_DS3_v2
    ```

::: zone-end