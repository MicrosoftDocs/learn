

In the Azure portal, each Azure service has required steps to configure the service endpoints and restrict network access for the service.

To access these settings for your storage account, you use the **Firewalls and virtual networks** settings. You add the virtual networks that should have access to the service for the account.

:::image type="content" source="../media/secure-storage-access-d32868ef.png" alt-text="Screenshot of the Storage Account Firewalls and virtual networks settings in the Azure portal. One virtual network is selected and the firewall has an IP address range.":::

### Things to know about configuring service endpoints

Here are some points to consider about configuring service access settings:

- The **Firewalls and virtual networks** settings restrict access to your storage account from specific subnets on virtual networks or public IPs.

- You can configure the service to allow access to one or more public IP ranges.

- Subnets and virtual networks must exist in the same Azure region or region pair as your storage account.

> [!Important]
> Be sure to test the service endpoint and verify the endpoint limits access as expected.