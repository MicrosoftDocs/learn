## Azure Policy

Now you have identified your governance and business requirements, how do you ensure that your resources stay compliant, or that you are alerted if their configuration has changed? 

<div style="background: yellow;">
TODO: 
TWT scenario? Or leave for exercise?
</div 

[Azure Policy](https://azure.microsoft.com/services/azure-policy?azure-portal=true) is a service in Azure that enables you to create, assign, and, manage policies to control or audit your resources. These policies enforce different rules and effects over your resources, so those resources stay compliant with your corporate standards.

Azure Policy does this with both individual policies and groups of related policies, known as initiatives. It runs evaluations of your resources and highlights those which are not compliant with the policies you have created and can also block non-compliant resources from being created.  Azure Policy comes with a number of built-in policy and initiative definitions that you can use, under categories such as Storage, Networking, Compute, Security Center, and Monitoring. 

For example, you can have a policy to allow only a certain stock keeping unit (SKU) size of virtual machines (VMs) to be used in your environment. Once you enable this policy, it will apply when you create new VMs or resize existing ones. It will also evaluate any current VMs in your environment. 

In some cases, Azure Policy can automatically remediate resources and configurations that are deemed non-compliant, thus ensuring the integrity of the state of the resources. For example, if all resources in a certain resource group should be tagged with an "AppName" tag and a value of "SpecialOrder", Azure Policy can automatically re-apply that tag if it has been removed.

Azure Policy can also integrate with Azure DevOps, by applying any continuous integration and delivery pipeline policies that apply to the pre-deployment and post-deployment of your applications.

<div style="background: yellow;">
TODO: 
This is a looong piece of text. Break up with subheadings or add a screenshot of Allowed SKUs policy or a non-compliant resource?
</div>

## Azure Policy in action

There are three steps to creating an implementing an Azure policy:

![Three-step process for implementing policy definitions as discussed in the text](../media/policy-process.png)

### 1. Create a policy definition

A policy definition expresses what to evaluate and what action to take. For example, you could prevent VMs from being deployed in certain Azure regions. You also could audit that storage accounts can only accept connections from allowed networks.

Every policy definition has conditions under which it is enforced. And, it has an accompanying effect that takes place if the conditions are met. Here are some example policy definitions:

- **Allowed storage account SKUs**. This policy definition has a set of conditions/rules that determine whether a storage account that is being deployed is within a set of SKU sizes. Its effect is to deny all storage accounts that do not adhere to the set of defined SKU sizes.
- **Allowed Virtual Machine SKUs**. This policy enables you to specify a set of VM SKUs that your organization can deploy.
- **Allowed resource type**. This policy definition has a set of conditions/rules to specify the resource types that your organization can deploy. Its effect is to deny all resources that are not part of the defined list.
- **Allowed locations**. This policy enables you to restrict the locations that your organization can specify when deploying resources. Its effect is used to enforce your geographic compliance requirements.

<div style="background: yellow;">
TODO: 
Edit this list of example policies to include more variety (eg enforcing MFA, CORS, Azure Security Center enrollment, windows updates)
</div>


More sample policies are available on the [Azure policy samples](https://docs.microsoft.com/azure/governance/policy/samples?azure-portal=true) page.

### 2. Assign the definition to a scope of resources

To implement your policy definitions, you assign them to resources. A policy assignment is a policy definition that has been assigned to take place within a specific scope. This specific scope could be a management group (a collection of multiple subscriptions), one particular subscription or a resource group. Policy assignments are inherited by all child resources in that scope. This means that if a policy is applied to a resource group, it is applied to all the resources within that resource group. However, you can exclude a sub-scope from the policy assignment, if there are specific child resources you wish to be exempt from the policy assignment.
<div style="background: yellow;">
TODO: 
Diagram?
</div>

### 3. Review the policy evaluation results

When a condition is evaluated against your existing resources it is marked compliant or non-compliant. You can review the non-compliant policy results and take any action that is needed.

Policy evaluation happens about once an hour, which means that if you make changes to your policy definition and create a policy assignment then it will be re-evaluated over your resources within the hour.
<div style="background: yellow;">
TODO: 
Screenshot of non-compliance?
</div>

## Azure Policy Initiatives 

An Azure Policy Initiative is a way of grouping related policies into one set. The initiative definition contains all of the policy definitions to help track your compliance state for a larger goal. 

For example, Azure Policy includes an initiative named *Enable Monitoring in Azure Security Center*, with a goal to monitor all the available security recommendations for all Azure resource types, in the Azure Security Center.

Under this initiative, the following policy definitions are included:

+ *Monitor unencrypted SQL Database in Security Center* – For monitoring unencrypted SQL databases and servers.
+ *Monitor OS vulnerabilities in Security Center* – For monitoring servers that do not satisfy the configured baseline.
+ *Monitor missing Endpoint Protection in Security Center* – For monitoring servers without an installed endpoint protection agent.

In fact, the *Enable Monitoring in Azure Security Center* initiative contains over 100 separate policy definitions. 

### Defining an initiative
You can define initiatives using the Azure portal, or command-line tools. In the portal, you use the "Authoring" section. Search the list of built-in initiatives that are already provided by Azure, or create your own.

![Screenshot showing Azure portal defining initiatives and definitions](../media/3-define-initiatives.png)

### Assigning an initiative
Like a policy assignment, an initiative assignment is an initiative definition assigned to a specific scope of a management group, a subscription or a resource group. 


> [!Tip]
> Even if you have a single policy, we recommend using initiatives if you anticipate increasing the number of policies over time. This makes it easier to add and remove policies without needing to change the policy assignment, as the associated initiative remains assigned. 





