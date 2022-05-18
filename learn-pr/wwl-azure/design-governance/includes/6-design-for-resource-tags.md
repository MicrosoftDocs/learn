[Resource tags ](/azure/azure-resource-manager/management/tag-resources?tabs=json)are another way to organize resources. Tags provide extra information, or metadata, about your resources. 

> [!TIP]
> Before starting a resource tagging project, ask yourself what you want to accomplish. Will the tags be used for reporting or billing? Perhaps you will use the tags to enable more effective searching? Maybe the tags will be used in automated scripts. Be sure to clearly define your goals. 

### Things to know about resource tags

- A resource tag consists of a name-value pair. For example, env: production or env: test.

- You can assign one or more tags to each Azure resource, resource group, or subscription.

- You can add, modify, or delete resource tags. These actions can be done with PowerShell, the Azure CLI, Azure Resource Manager templates, the REST API, or the Azure portal.

- You can [apply tags](/azure/azure-resource-manager/management/tag-resources) to a resource group. However, the resources in the resource group don't inherit those tags by default.

### Things to consider when creating resource tags

Tailwind Traders has created their organization hierarchy and now needs to determine which resource tags to apply. 

:::image type="content" source="../media/resource-tags.png" alt-text="Example hierarchy of resource tags.":::

- **Consider your organization’s taxonomy.** Has your organization already defined terms for compliance or cost reporting? Aligning tags with accepted department nomenclature will make it easier to understand. For example, are office locations, confidentiality levels, and programs already defined? 

- **Consider whether you need IT-aligned or business-aligned tagging.** Generally, you can choose IT-aligned tagging or business-aligned tagging. A combination of the two approaches can be effective. Many organizations are shifting from IT-aligned to business-aligned tagging strategies. 

| **Tagging scheme**| **Description**| **Example** |
| - | - | -|
| **IT-aligned tagging**| Focuses on workload, application, function, or environment criteria. Reduces the complexity of monitoring assets. Simplifies making management decisions based on operational requirements.| Our printers are busy 80% of the time. We have five high-speed color printers and should buy more. |
| **Business-aligned tagging**| Focuses on accounting, business ownership, cost responsibility, or business criticality. Provides improved accounting for costs and value of IT assets to the overall business. Shifts the focus from an asset’s operational cost to an asset’s business value.| Our marketing department’s promotional literature has increased sales revenue 10%. We should invest in more printing capabilities. | 

**Consider the type of tagging that is required.** 

Resource tags generally fall into five categories functional, classification, accounting, partnership, and purpose. 

| **Tag type**| **Examples**| **Description** |
| - | - | - |
| Functional| app = catalogsearch1  <br>tier = web  <br>webserver = apache  <br>‎env = prod, dev, staging| Categorize resources by their purpose within a workload, what environment they've been deployed to, or other functionality and operational details. |
| Classification| confidentiality = private  <br>SLA = 24hours| Classifies a resource by how it's used and what policies apply to it. |
| Accounting| department = finance  <br>program = business-initiative  <br>region = northamerica| Allows a resource to be associated with specific groups within an organization for billing purposes. |
| Partnership| owner = jsmith  <br>contactalias = catsearchowners  <br>‎stakeholders = user1;user2;user3| Provides information about what people (outside of IT) are related or otherwise affected by the resource. |
| Purpose| businessprocess = support  <br>businessimpact = moderate  <br>‎revenueimpact = high| Aligns resources to business functions to better support investment decisions. |


 

- **Consider starting with a few tags and then scaling out.** Your resource tagging approach can be simple or complex. Rather than identifying all the possible tags your organization needs, prototype using a few important or critical tags. Determine how effective the tagging is before adding more resource tags. 

- **Consider using Azure policy to apply tags and enforce tagging rules and conventions**. Resource tagging is only effective if it’s used consistently across an organization. You can use Azure policy to require that certain tags be added to new resources as they're provisioned. You can also define rules that reapply tags that have been removed.

- **Consider which resources require tagging.** Keep in mind that you don't need to enforce that a specific tag is present on all your resources. For example, you might decide that only mission-critical resources have the Impact tag. All non-tagged resources would then not be considered as mission critical.

> [!NOTE]
> You’ll need support from many different stakeholders to implement an effective resource tagging structure. 