Contoso's security team knows that service endpoints reduce network exposure, but they don't eliminate the public IP address from Azure PaaS resources. To meet compliance requirements, Contoso must ensure that sensitive resources like Azure SQL Database and Azure OpenAI have no public network path. Here, you learn how to create and configure private endpoints, integrate private Domain Name System (DNS) zones, and disable public access to eliminate internet exposure.

| Step | Action |
|------|--------|
| Deploy private endpoint | Create a network interface in your virtual network (VNet) subnet that connects to the target PaaS resource |
| Configure DNS integration | Link a private DNS zone to your VNet so the resource FQDN resolves to the private IP |
| Verify DNS resolution | Test that clients in the VNet resolve the private IP, not the public IP |
| Disable public access | Turn off public network access at the resource level |

## Understand private endpoint components

A private endpoint consists of four essential components that work together to establish private connectivity. The **network interface card (NIC)** is a real Ethernet-style NIC deployed in your VNet subnet with a private IP address from that subnet's address range. The NIC is how traffic physically reaches the private endpoint — it's not a logical construct.

The NIC connects to a specific Azure PaaS resource through a **resource connection**. Many PaaS services have multiple sub-resource types. For example, a single Azure Storage account supports blob, file, queue, table, and Data Lake Storage Gen2 (dfs) sub-resources. If Contoso needs access to both blob and file shares, you create two private endpoints — one for the blob sub-resource and one for the file sub-resource.

The **approval workflow** determines whether the private endpoint can connect immediately or requires manual approval. Auto-approval applies when you have contributor-level access to both the endpoint and the target resource. When the resource resides in a different subscription or tenant, the resource owner must approve the connection — they receive an approval request in the Azure portal.

The final component is the **private DNS record**. Azure creates a DNS A record for the resource's fully qualified domain name (FQDN) that points to the private IP address. The DNS record enables clients to resolve the private IP instead of the public IP.

| PaaS service | Sub-resource | Private endpoint FQDN suffix |
|---|---|---|
| Azure SQL Database | sqlServer | `<name>.database.windows.net` → private zone: `privatelink.database.windows.net` |
| Azure Blob Storage | blob | `<name>.blob.core.windows.net` → private zone: `privatelink.blob.core.windows.net` |
| Azure Key Vault | vault | `<name>.vault.azure.net` → private zone: `privatelink.vaultcore.azure.net` |
| Azure OpenAI | account | `<name>.openai.azure.com` → private zones: `privatelink.cognitiveservices.azure.com`, `privatelink.openai.azure.com`, `privatelink.services.ai.azure.com` |

## Integrate private DNS zones correctly

DNS integration is the most critical step in the private endpoint configuration. Without correct DNS resolution, the private endpoint doesn't work — traffic continues to route over the internet to the public IP address.

Without a private DNS zone, the service FQDN (for example, `contoso.blob.core.windows.net`) resolves to the public IP address through Azure's public DNS infrastructure. Even though you created a private endpoint with a NIC in your VNet, clients bypass it because DNS directs them to the public endpoint.

With a private DNS zone linked to the VNet, DNS resolution returns the private IP address. When clients query the FQDN, Azure DNS returns the A record you created in the `privatelink.blob.core.windows.net` zone. Traffic routes to the NIC in your VNet, and the connection stays entirely within the Azure backbone network.

Azure Private DNS zones use standardized zone names for each service type — zones like `privatelink.blob.core.windows.net`, `privatelink.database.windows.net`, and `privatelink.openai.azure.com`. You create one zone per service type and link it to every VNet that needs access. Multiple private endpoints for the same service type share the same private DNS zone.

The portal simplifies this process through **auto-registration**. When you create a private endpoint and select "integrate with private DNS zone," Azure creates the zone if it doesn't exist, creates the A record, and links the zone to the VNet — in a single step. Auto-registration eliminates manual DNS configuration errors.

For hybrid environments, Contoso's on-premises clients also need to resolve the private IP. You configure DNS forwarders on-premises to forward queries for `privatelink.*.windows.net` and `privatelink.*.azure.com` to Azure DNS at 168.63.129.16. The forwarding rule applies to all private endpoints — configure it once, not per resource.

> [!IMPORTANT]
> If you disable the public endpoint before configuring DNS correctly, clients that attempt to connect fail with a connection error rather than a "public access disabled" error. Always configure the private endpoint and verify DNS resolution before disabling public access.

## Disable public network access

After you create the private endpoint and verify that DNS resolves correctly, disable the public endpoint to eliminate internet exposure. The specific portal navigation varies by service, but the concept is consistent across all Azure PaaS resources.

For Azure SQL Database, you navigate to **Networking** → **Connectivity method** → select **Private endpoint only** or disable the **Public endpoint** toggle. For Azure Blob Storage, you navigate to **Networking** → **Firewalls and virtual networks** → set **Allow access from** to **Disabled**. Alternatively, you can select **Enabled from selected virtual networks and IP addresses** with no entries, which achieves the same result.

For Azure Key Vault, you navigate to **Networking** → **Firewalls and virtual networks** → set **Allow access from** to **Disable public access**. For Azure OpenAI, you navigate to **Networking** → set **Allow access from** to **Disabled**.

> [!NOTE]
> The portal label varies slightly per service, but the concept is the same: once the private endpoint is working and DNS is configured, set the public network access to disabled.

After you disable public access, any connection attempt from outside the VNet receives an access denied error. Connections from inside the VNet continue to work because they route through the private endpoint.

## Create a private endpoint for Azure SQL Database

Follow these steps to create a private endpoint for Contoso's Azure SQL Database server.

1. In the Azure portal, navigate to your Azure SQL Server resource (not the database — the server).
2. Select **Networking** → **Private access** tab.
3. Select **+ Create a private endpoint**.
4. On the **Basics** tab, name the endpoint, select the subscription, resource group, and region.
5. On the **Resource** tab, the target resource is pre-filled with the current SQL server. Set **Target sub-resource** to **sqlServer**.
6. On the **Virtual Network** tab, select the VNet and subnet where the NIC is deployed. Under **Private DNS integration**, select **Yes** and confirm the zone name `privatelink.database.windows.net`.
7. Review and create.
8. After deployment completes, verify DNS resolution. From a virtual machine (VM) in the VNet, run `nslookup contoso.database.windows.net`. The result returns the private IP address (for example, 10.x.x.x), not a public IP address.

After you verify DNS resolution:

9. Return to **Networking** → disable public network access.
10. Test connectivity from a VM in the VNet to confirm the connection works.
11. Test from a client outside the VNet to confirm access is denied.

The verification sequence ensures the private endpoint works correctly before you remove public access. If DNS resolution fails in step 8, troubleshoot the private DNS zone link before proceeding.

## Apply private endpoints to Azure OpenAI workloads

Azure OpenAI follows the same private endpoint pattern as other PaaS services. The sub-resource is **account**, but unlike single-zone services, Azure OpenAI requires **three** private DNS zones: `privatelink.cognitiveservices.azure.com`, `privatelink.openai.azure.com`, and `privatelink.services.ai.azure.com`. All three zones must be created and linked to the VNet — missing any one zone causes DNS resolution failures for specific endpoint types. The configuration steps mirror those for Azure SQL Database, repeated once for each zone.

Without a private endpoint, AI agent applications that call the Azure OpenAI API route that traffic over the internet. If the API key or managed identity token is stolen, an attacker can run inference from anywhere with an internet connection. The public IP address creates a global attack surface for your AI workload.

With a private endpoint, the Azure OpenAI endpoint resolves to a private IP address. Only VNet-connected workloads can call the inference API. Corporate Conditional Access policies and network security groups apply to the traffic. The attack surface shrinks from the entire internet to your VNet perimeter.

For maximum security, combine two controls: use managed identity for the Azure OpenAI connection (eliminates API key risk) and deploy a private endpoint (eliminates network path risk). Managed identity alone doesn't prevent unauthorized network access. A private endpoint alone doesn't eliminate credential theft. You need both controls to meet defense-in-depth requirements.

> [!TIP]
> After configuring a private endpoint for Azure OpenAI, update your AI agent application's endpoint URL to use the private DNS-resolvable FQDN. If the application runs outside the VNet (even temporarily), calls fail because the FQDN no longer resolves outside the private DNS zone.

You configure private endpoints for Contoso's inbound PaaS access. The next unit covers a different scenario: when Contoso needs to expose one of its own services — not consume an external one — to other tenants or subscriptions without using a public IP. That's where Azure Private Link Service acts as the provider side of the pattern.
