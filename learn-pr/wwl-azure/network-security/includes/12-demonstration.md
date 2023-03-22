Use this short Try-This exercises to get some hands-on experience with using Azure. An individual Azure subscription is required to perform the exercise tasks. To subscribe, browse to https://www.azure.microsoft.com/free.

## Task 1 - Network security groups

This task requires a Windows virtual machine associated with a network security group. The NSG should have an inbound security rule that allows RDP. The virtual machine should be in a running state and have a public IP address.

In this task, we will review networking rules, confirm the public IP page does not display, configure an inbound NSG rule, and confirm the public IP page now displays.

**Review networking rules**

1. In the **Portal**, navigate to your virtual machine.
1. Under **Settings**, click **Networking**.
1. Discuss the default inbound and outbound rules.
1. Review the inbound rules and ensure RDP is allowed.
1. Make a note of the public IP address.

**Connect to the virtual machine and test the public IP address**

1. From the **Overview** blade, click **Connect** and RDP into the virtual machine.
1. On the **virtual machine**, open a **browser**.
1. Test the default localhost IIS HTML page: `http://localhost/default.htm`. This page should appear.
1. Test the default public IP IIS HTML page: `http://public_IP_address/default.htm`. This page should not display.

**Configure an inbound rule to allow public access on port 80**

1. Return to the **Portal** and the **Networking** blade.
1. Make a note of the virtual machine's **private IP** address.
1. On the **Inbound port rules** tab, click **Add inbound port rule**. This rule will only allow certain IP addresses on port 80. As you go through the configuration settings, be sure to discuss each one.
     -  Source: **Service Tag**
     -  Source service tag: **Internet**
     -  Destination: **IP addresses**
     -  Destination IP addresses/CIDR range: **private\_IP\_address/32**
     -  Destination port range: **80**
     -  Protocol: **TCP**
     -  Action: **Allow**
     -  Name: **Allow\_Port\_80**
     -  Click **Add**
1. Wait for your new inbound rule to be added.

**Retest the public IP address**

1. On the **virtual machine,,** return to the **browser**.
1. Refresh the default public IP IIS HTML page: `http://public_IP_address/default.htm`. This page should now display.

## Task 2 - Application service groups

This task requires a Windows virtual machine with IIS installed. These steps use VM1. Your machine name may be different.

In this task, we will connect to a virtual machine, create an inbound deny rule, configure an application security group, and test connectivity.

**Connect to the virtual machine**

1. In the **Portal**, navigate to **VM1**.
1. On the **Networking** blade, make a note of the private IP address.
1. Ensure there is an **Inbound port rule** that allows **RDP**.
1. From the **Overview** blade, ensure VM1 is **running**.
1. Click **Connect** and RDP into the VM1.
1. On **VM1**, open a browser.
1. Ensure the default IIS page display for the private IP address: `http://private_IP_address/default.htm`.

**Add an inbound deny rule and test the rule**

1. Continue in the **Portal** from the **Networking** blade.
1. On the **Inbound port rules** tab, click **Add inbound port rule**. Add a rule that denies all inbound traffic.
     -  Destination port ranges: \*
     -  Action: **Deny**
     -  Name: **Deny\_All**
     -  Click **Add**
1. Wait for your new inbound rule to be added.
1. On **VM1**, refresh the browser page: **`http://private_IP_address/default.htm`**.
1. Verify that the page does not display.

**Configure an application security group**

1. In the **Portal**, search for and select **Application security groups**.
1. Create a new Application security group.
1. Provide the required information: subscription, resource group, name, and region.
1. Wait for the ASG to deploy.
1. In the **Portal**, return to **VM1**.
1. On the **Networking** blade, select the **Application security groups** tab.
1. Click **Configure the application security groups**.
1. Select your new application security group, and **Save** your changes.
1. From the **Inbound port rules** tab, click **Add inbound rule**. This will allow the ASG.
     -  Source: **Application security group**
     -  Source application security group: **your\_ASG**
     -  Destination: **IP addresses**
     -  Destination IP addresses: **private\_IP\_address/32**
     -  Destination port range: **80**
     -  Priority: **250**
     -  Name: **Allow\_ASG**
     -  Click **Add**
1. Wait for your new inbound rule to be added.

**Test the application security group**

1. On **VM1**, refresh the browser page: `http://private_IP_address/default.htm`.
1. Verify that the page now displays.

## Task 3 - Storage endpoints (you could do this in the storage lesson)

This task requires a storage account and virtual network with a subnet. Storage Explorer is also required.

In this task, we will secure a storage endpoint.

1. In the **Portal**.
1. Locate your storage account.
1. Create a **file share**, and **upload** a file.
1. Use the **Shared Access Signature** blade to **Generate SAS and connection string**.
1. Use Storage Explorer and the connection string to access the file share.
1. Ensure you can view your uploaded file.
1. Locate your virtual network, and then select a subnet in the virtual network.
1. Under **Service Endpoints**, view the **Services** drop-down and the different services that can be secured with an endpoint.
1. Check the **Microsoft.Storage** option.
1. **Save** your changes.
1. Return to your storage account.
1. Select **Firewalls and virtual networks**.
1. Change to **Selected networks**.
1. Add your virtual network and verify your subnet with the new service endpoint is listed.
1. **Save** your changes.
1. Return to the Storage Explorer.
1. **Refresh** the storage account.
1. Verify you can no longer access the file share.
