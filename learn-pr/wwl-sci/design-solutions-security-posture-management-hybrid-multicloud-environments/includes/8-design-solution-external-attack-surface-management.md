## What is an external attack surface?

An external attack surface is the entire area of an organization or system that is susceptible to an attack from an external source. An organization's attack surface is made up of all the points of access that an unauthorized person could use to enter their system. The larger your attack surface is, the harder it's to protect.

You can use Defender for Cloud's new integration with Microsoft Defender External Attack Surface Management (Defender EASM), to improve your organization's security posture and reduce the potential risk of being attacked. Defender EASM continuously discovers and maps your digital attack surface to provide an external view of your online infrastructure. This visibility enables security and IT teams to identify unknowns, prioritize risk, eliminate threats, and extend vulnerability and exposure control beyond the firewall.

Defender EASM applies Microsoft’s crawling technology to discover assets that are related to your known online infrastructure, and actively scans these assets to discover new connections over time. Attack Surface Insights are generated by applying vulnerability and infrastructure data to showcase the key areas of concern for your organization, such as:

-   Discover digital assets, always-on inventory
-   Analyze and prioritize risks and threats
-   Pinpoint attacker-exposed weaknesses, anywhere and on-demand
-   Gain visibility into third-party attack surfaces

EASM collects data for publicly exposed assets (“outside-in”). That data can be used by Defender for Cloud CSPM (“inside-out”) to assist with internet-exposure validation and discovery capabilities to provide better visibility to customers.

## Defender EASM overview

_Microsoft Defender External Attack Surface Management (Defender EASM)_ continuously discovers and maps your digital attack surface to provide an external view of your online infrastructure. This visibility enables security and IT teams to identify unknowns, prioritize risk, eliminate threats, and extend vulnerability and exposure control beyond the firewall. Attack Surface Insights are generated by leveraging vulnerability and infrastructure data to showcase the key areas of concern for your organization.

:::image type="content" source="../media/overview-1.png" alt-text="Screenshot of Overview Dashboard." lightbox="../media/overview-1.png":::
<!--
[](/azure/external-attack-surface-management/#discovery-and-inventory)
-->


### Discovery and inventory

Microsoft's proprietary discovery technology recursively searches for infrastructure with observed connections to known legitimate assets to make inferences about that infrastructure's relationship to the organization and uncover previously unknown and unmonitored properties. These known legitimate assets are called discovery “seeds”; Defender EASM first discovers strong connections to these selected entities, recursing to unveil more connections and ultimately compile your Attack Surface.

Defender EASM includes the discovery of the following kinds of assets:

-   Domains
-   Hostnames
-   Web Pages
-   IP Blocks
-   IP Addresses
-   ASNs
-   SSL Certificates
-   WHOIS Contacts

:::image type="content" source="../media/overview-2.png" alt-text="Screenshot of Discovery View." lightbox="../media/overview-2.png":::

Discovered assets are indexed and classified in your Defender EASM Inventory, providing a dynamic record of all web infrastructure under the organization's management. Assets are categorized as recent (currently active) or historic, and can include web applications, third party dependencies, and other asset connections.
<!--
[](/azure/external-attack-surface-management/#dashboards)
-->

### Dashboards

Defender EASM provides a series of dashboards that help users quickly understand their online infrastructure and any key risks to their organization. These dashboards are designed to provide insight on specific areas of risk, including vulnerabilities, compliance, and security hygiene. These insights help customers quickly address the components of their attack surface that pose the greatest risk to their organization.

<!--
[](/azure/external-attack-surface-management/#managing-assets)
-->
:::image type="content" source="../media/overview-3.png" alt-text="Screenshot of Dashboard View." lightbox="../media/overview-3.png":::

### Managing assets

Customers can filter their inventory to surface the specific insights they care about most. Filtering offers a level of flexibility and customization that enables users to access a specific subset of assets. This allows you to leverage Defender EASM data according to your specific use case, whether searching for assets that connect to deprecating infrastructure or identifying new cloud resources.

:::image type="content" source="../media/overview-4.png" alt-text="Screenshot of Inventory View." lightbox="../media/overview-4.png":::

<!--
[](/azure/external-attack-surface-management/#user-permissions)
-->

### User permissions

Users that have been assigned either Owner or Contributor roles can create, delete, and edit Defender EASM resources and the inventory assets within it. These roles can utilize all capabilities offered in the platform. Users that have been assigned the Reader role are able to view Defender EASM data, but are unable to create, delete or edit inventory assets or the resource itself.