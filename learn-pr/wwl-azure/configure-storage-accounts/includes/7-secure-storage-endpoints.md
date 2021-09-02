The steps necessary to restrict network access to Azure services varies across services. For accessing a storage account, you would use the **Firewalls and virtual networks** blade to add the virtual networks that will have access. Notice you can also configure to allow access to one or more public IP ranges.

:::image type="content" source="../media/secure-storage-access-d32868ef.png" alt-text="Screenshot of the Storage Account Firewalls and virtual networks blade in the Azure portal. One virtual network is selected and the firewall has an IP address range.":::


 -  Firewalls and Virtual Networks restricts access to the Storage Account from specific Subnets on Virtual Networks or public IPs.
 -  Subnets and Virtual Networks must exist in the same Azure Region or Region Pair as the Storage Account.

> [!NOTE]
> Be sure to test the service endpoint and verify the endpoint is limiting access as expected.
