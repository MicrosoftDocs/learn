In the Azure portal, each Azure service requires certain steps to configure the service endpoints and restrict network access.

To access these settings for your storage account, you use the **Firewalls and virtual networks** settings. You add the virtual networks that should have access to the service for the account.

:::image type="content" source="../media/secure-storage-access-d32868ef.png" alt-text="Screenshot of the Storage Account Firewalls and virtual networks settings in the Azure portal. One virtual network is selected and the firewall has an IP address range.":::

### Things to know about configuring service endpoints

Here are some points to consider about configuring service access settings:

- The **Firewalls and virtual networks** settings restrict access to your storage account from specific subnets on virtual networks or public IPs.

- You can configure the service to allow access to one or more public IP ranges.

- Subnets and virtual networks must exist in the same Azure region or region pair as your storage account.

> [!Important]
> Be sure to test the service endpoint and verify the endpoint limits access as expected.

### How to connect to a storage account using private link

<iframe width="854" height="480" src="https://www.youtube.com/embed/vM7yDwHSc_o" title="How to move Azure Storage Blobs between containers" allowfullscreen></iframe>
