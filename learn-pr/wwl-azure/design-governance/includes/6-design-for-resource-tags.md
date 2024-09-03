[Resource tags](/azure/azure-resource-manager/management/tag-resources?tabs=json) are another way to organize resources. Tags provide extra information, or metadata, about your resources. 

> [!TIP]
> Before you start a resource tagging project, ask yourself what you want to accomplish. Will reporting or billing use tags? Can you use the tags to enable more effective searching for Tailwind Traders? Will automated scripts use tags? Be sure to clearly define your goals. 

### Things to know about resource tags

As you plan the governance strategy for Tailwind Traders, consider these characteristics of resource tags:

- A resource tag consists of a name-value pair. For example, `env = production` or `env = dev, test`.

- You can assign one or more tags to each Azure resource, resource group, or subscription.

- Resource tags can be added, modified, and deleted. These actions can be done with PowerShell, the Azure CLI, Azure Resource Manager (ARM) templates, the REST API, or the Azure portal.

- [Tags can be applied](/azure/azure-resource-manager/management/tag-resources) to a resource group. However, tags applied to a resource group aren't inherited by the resources in the group.

### Things to consider when creating resource tags

You created the organizational hierarchy for Tailwind Traders. Now you need to determine which resource tags to apply. 

:::image type="content" source="../media/resource-tags.png" alt-text="Diagram that shows an example hierarchy of resource tags." border="false":::

- **Consider your organization's taxonomy**. Align your resource tags with accepted department nomenclature to make it easier to understand. Are there recognized terms for compliance or cost reporting for the Tailwind Traders organization? Add tags for office locations, confidentiality levels, or other defined policies.

- **Consider whether you need IT-aligned or business-aligned tagging**. Implement IT-aligned tagging or business-aligned tagging, or a combination of these approaches to be most effective.

   > [!Tip]
   > Many organizations are shifting from IT-aligned to business-aligned tagging strategies. 

   The following table describes the tagging options in detail.

   | Alignment | Description | Example scenarios |
   | --- | --- | ---|
   | **IT-aligned** | The IT-aligned option is useful for tracking workload, application, function, or environment criteria. This option can reduce the complexity of monitoring assets. IT-aligned tagging simplifies making management decisions based on operational requirements. | Tailwind Traders printers are busy 80% of the time. We have five high-speed color printers and should buy more. Use IT-aligned tagging to support printer resource workload and function. |
   | **Business-aligned** | The Business-aligned option helps to focus on accounting, business ownership, cost responsibility, and business criticality. This option provides improved accounting for costs and value of IT assets to the overall business. You can use Business-aligned tagging to shift the focus from an asset's operational cost to an asset's business value. | The Tailwind Traders Marketing department's promotional literature increased sales revenue 10%. We should invest in more printing capabilities. Use Business-aligned tagging to support marketing resource ownership, accounting, and cost. | 

- **Consider the type of tagging required**. Plan to use different types of resource tags to support the Tailwind Traders organization. Resource tags generally fall into five categories: functional, classification, accounting, partnership, and purpose. 

   | Tag type | Description |  Example name-value pairs |
   | --- | --- | --- |
   | **Functional** | Functional tags categorize resources according to their purpose within a workload. This tag shows the deployed environment for a resource, or other functionality and operational details. | - `app = catalogsearch1` <br> - `tier = web` <br> - `webserver = apache` <br> - `env = production, dev, staging` |
   | **Classification** | Classification tags identify a resource by how it's used and what policies apply to it. | - `confidentiality = private` <br> - `SLA = 24hours` |
   | **Accounting** | Accounting tags allow a resource to be associated with specific groups within an organization for billing purposes. | - `department = finance` <br> - `program = business-initiative` <br> - `region = northamerica` | 
   | **Partnership** | Partnership tags provide information about the people (other than IT members) who are associated with a resource, or otherwise affected by the resource. | - `owner = jsmith` <br> - `contactalias = catsearchowners` <br> - `stakeholders = user1;user2;user3` |
   | **Purpose** | Purpose tags align resources to business functions to better support investment decisions. | - `businessprocess = support` <br> - `businessimpact = moderate` <br> - `revenueimpact = high` | 

- **Consider starting with a few tags and then scale out**. The resource tagging approach you choose can be simple or complex. Rather than identify all the possible tags required by the Tailwind Traders organization, prototype with just a few important or critical tags. Determine how effective the tagging scheme is before you add more resource tags. 

- **Consider using Azure policy to apply tags and enforce tagging rules and conventions**. Resource tagging is only effective if used consistently across an organization. You can use Azure policy to require that certain tags be added to new resources as they're created. You can also define rules that reapply tags when deleted.

- **Consider which resources require tagging**. Keep in mind that you don't need to enforce that a specific tag is present on all Tailwind Traders resources. You might decide that only mission-critical resources have the `Impact` tag. All nontagged resources would then not be considered as mission critical.

> [!NOTE]
> To implement an effective resource tagging structure, be sure to seek input from the different stakeholders in your organization. 