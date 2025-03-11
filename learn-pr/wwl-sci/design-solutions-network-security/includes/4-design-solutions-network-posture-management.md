Microsoft Defender for Cloud continuously analyzes the security state of your Azure resources for network security best practices. When Defender for Cloud identifies potential security vulnerabilities, it creates recommendations that guide you through the process of configuring the needed controls to harden and protect your resources.

The Networking features of Defender for Cloud include:

- Networking security recommendations
- Network map requires Microsoft Defender for Servers Plan 2.

### View your networking resources and their recommendations

The asset inventory page of Microsoft Defender for Cloud shows the security posture of the resources you connected to Defender for Cloud. Defender for Cloud periodically analyzes the security state of resources connected to your subscriptions to identify potential security issues and provides you with active recommendations. Active recommendations are recommendations that can be resolved to improve your security posture.

Defender for Cloud periodically analyzes the security state of resources connected to it. When resources have active security recommendations or security alerts associated with it, they appear in the inventory.

The Inventory page provides information about:

- Connected resources. Quickly see which resources are connected to Defender for Cloud.
- Overall security state: Get a clear summary about the security state of connected Azure, AWS, and GCP resources, including the total resources connected to Defender for Cloud, resources by environment, and a count of unhealthy resources.
- Recommendations, alerts: Drill down into the state of specific resources to see active security recommendations and security alerts for a resource.
- Risk prioritization: Risk-based recommendations assign risk levels to recommendations, based on factors such as data sensitivity, internet exposure, lateral movement potential, and potential attack paths.
- Risk prioritization is available when the Defender CSPM plan is enabled.
- Software. You can review resources by installed applications. To take advantage of the software inventory, either the Defender Cloud Security Posture Management (CSPM) plan, or a Defender for Servers plan must be enabled.

The Inventory uses Azure Resource Graph (ARG) to query and retrieve data at scale. For deep custom insights, you can use KQL to query the inventory.

From the asset inventory page, use the resource type filter to select the networking resources that you want to investigate, across a multicloud environment (Azure, AWS, GCP).

# [Network filters](#tab/network-filters)
:::image type="content" source="../media/network-filters-inventory-v2.png" lightbox="../media/network-filters-inventory-v2.png" alt-text="Screen shot of the filter option in the  inventory feature in Microsoft Defender for  Cloud.":::

# [Health and recommendations](#tab/health-recommendations)
:::image type="content" source="../media/network-recommendation-resource-health.png" lightbox="../media/network-recommendation-resource-health.png" alt-text="Screen shot of the network recommendations for a selected network resource.":::

---

The recommendations that appear in your environment are based on the resources that you're protecting and on your customized configuration. 

For a complete list of the all the network security recommendations you might in Microsoft Defender for Cloud, see [Networking security recommendations](/azure/defender-for-cloud/recommendations-reference-networking)

### Network Map

The interactive network map provides a graphical view with security overlays giving you recommendations and insights for hardening your network resources. Using the map you can see the network topology of your Azure workloads, connections between your virtual machines and subnets, and the capability to drill down from the map into specific resources and the recommendations for those resources.

The network map can show you your Azure resources in a Topology view and a Traffic view.

#### The topology view
In the Topology view of the networking map, you can view the following insights about your networking resources:

- In the inner circle, you can see all the VNets within your selected subscriptions, the next circle is all the subnets, the outer circle is all the virtual machines.
- The lines connecting the resources in the map let you know which resources are associated with each other, and how your Azure network is structured.
- Use the severity indicators to quickly get an overview of which resources have open recommendations from Defender for Cloud.
- You can select any of the resources to drill down into them and view the details of that resource and its recommendations directly, and in the context of the Network map.
- If there are too many resources being displayed on the map, Microsoft Defender for Cloud uses its proprietary algorithm to 'smart cluster' your resources, highlighting the ones that are in the most critical state, and have the most high severity recommendations.

:::image type="content" source="../media/network-map-and-recommendation.png" lightbox="../media/network-map-and-recommendation.png" alt-text="Screen shot of the network map and a side panel showing recommendations for a selected node.":::

Because the map is interactive and dynamic, every node is clickable, and the view can change based on the filters. You can modify what you see on the network map by using the filters at the top. You can focus the map based on:

- Security health: You can filter the map based on Severity (High, Medium, Low) of your Azure resources.
- Recommendations: You can select which resources are displayed based on which recommendations are active on those resources. For example, you can view only resources for which Defender for Cloud recommends you enable Network Security Groups.
- Network zones: By default, the map displays only Internet facing resources, you can select internal VMs as well.

#### The Traffic view

The Traffic view provides you with a map of all the possible traffic between your resources. This provides you with a visual map of all the rules you configured that define which resources can communicate with whom. This enables you to see the existing configuration of the network security groups and quickly identify possible risky configurations within your workloads.

The strength of this view is in its ability to show you allowed connections together with the vulnerabilities that exist, so you can use this cross-section of data to perform the necessary hardening on your resources. For example, you might detect two machines that you weren’t aware could communicate, enabling you to better isolate the workloads and subnets.

