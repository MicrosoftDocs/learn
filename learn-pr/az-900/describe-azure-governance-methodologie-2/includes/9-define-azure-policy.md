Now that you've identified your governance and business requirements, how do you ensure that your resources _stay_ compliant? How can you be alerted if a resource's configuration has changed? 

<div style="background: yellow;">
TODO: 
TWT scenario? Or leave for exercise?
</div 

[Azure Policy](https://azure.microsoft.com/services/azure-policy?azure-portal=true) is a service in Azure that enables you to create, assign, and manage policies that control or audit your resources. These policies enforce different rules and effects over your resources so that those resources stay compliant with corporate standards.

## How does Azure Policy define policies?

Azure Policy enables you to define both individual policies and groups of related policies, known as _initiatives_. Azure Policy evaluates your resources and highlights those which are not compliant with the policies you've created. Azure Policy can also prevent non-compliant resources from being created.

Azure Policy comes with a number of built-in policy and initiative definitions that you can use, under categories such as Storage, Networking, Compute, Security Center, and Monitoring.

For example, say you define a policy that allows only a certain stock keeping unit (SKU) size of virtual machines (VMs) to be used in your environment. After you enable this policy, that policy is applied when you create new VMs or resize existing VMs. Azure Policy also evaluates any current VMs in your environment.

In some cases, Azure Policy can automatically remediate non-compliant resources and configurations to ensure the integrity of the state of the resources. For example, if all resources in a certain resource group should be tagged with the **AppName** tag and a value of "SpecialOrders", Azure Policy can automatically reapply that tag if it has been removed.

Azure Policy also integrates with Azure DevOps by applying any continuous integration and delivery pipeline policies that apply to the pre-deployment and post-deployment phases of your applications.

<div style="background: yellow;">
TODO: 
Add a screenshot of Allowed SKUs policy or a non-compliant resource?
</div>

## Azure Policy in action

Implementing a policy in Azure Policy involves these three steps:

1. Create a policy definition.
1. Assign the definition to resources.
1. Review the evaluation results.

Let's examine each step in more detail.

<!--
TODO: Remove, as it's only text? It's nice eye candy, but can burden localization.

![Three-step process for implementing policy definitions as discussed in the text](../media/policy-process.png)
-->

### 1. Create a policy definition

A policy definition expresses what to evaluate and what action to take. For example, you could prevent VMs from being deployed in certain Azure regions. You also could audit your storage accounts to verify that they only accept connections from allowed networks.

Every policy definition has conditions under which it is enforced. A policy definition also has an accompanying effect that takes place when the conditions are met. Here are some example policy definitions:

* **Allowed storage account SKUs**

    This policy determines whether a storage account that's being deployed is within a set of allowed SKU sizes. Its effect is to deny all storage accounts that do not adhere to the set of defined SKU sizes.
* **Allowed Virtual Machine SKUs**

    This policy enables you to specify a set of VM SKUs that your organization can deploy.
* **Allowed resource type**

    This policy enables you to specify the resource types that your organization can deploy. Its effect is to deny all resources that are not part of the defined list.
* **Allowed locations**

    This policy enables you to restrict the locations that your organization can specify when deploying resources. Its effect is used to enforce your geographic compliance requirements.

<div style="background: yellow;">
TODO: 
Edit this list of example policies to include more variety (eg enforcing MFA, CORS, Azure Security Center enrollment, windows updates)
</div>

### 2. Assign the definition to resources

To implement your policy definitions, you assign definitions to resources. A _policy assignment_ is a policy definition takes place within a specific scope. This scope could be a management group (a collection of multiple subscriptions), a single subscription, or a resource group.

Policy assignments are inherited by all child resources within that scope. This means that if a policy is applied to a resource group, that policy is applied to all resources within that resource group. However, you can exclude a sub-scope from the policy assignment if there are specific child resources you need to be exempt from the policy assignment.

<div style="background: yellow;">
TODO: 
Diagram?
</div>

### 3. Review the policy evaluation results

When a condition is evaluated against your existing resources, each resource is marked as compliant or non-compliant. You can review the non-compliant policy results and take any action that's needed.

Policy evaluation happens about once per hour, which means that if you make changes to your policy definition and create a policy assignment, that policy is evaluated over your resources within the hour.

<div style="background: yellow;">
TODO: 
Screenshot of non-compliance?
</div>

## What are Azure Policy initiatives?

An Azure Policy initiative is a way of grouping related policies into one set. The initiative definition contains all of the policy definitions to help track your compliance state for a larger goal.

For example, Azure Policy includes an initiative named **Enable Monitoring in Azure Security Center**. Its goal is to monitor all of the available security recommendations for all Azure resource types in Azure Security Center.

Under this initiative, the following policy definitions are included:

* **Monitor unencrypted SQL Database in Security Center**

    This policy monitors for unencrypted SQL databases and servers.
* **Monitor OS vulnerabilities in Security Center**

    This policy monitors servers that do not satisfy the configured OS vulnerability baseline.
* **Monitor missing Endpoint Protection in Security Center**

    This policy monitors for servers that don't have an installed endpoint protection agent.

In fact, the **Enable Monitoring in Azure Security Center** initiative contains over 100 separate policy definitions.

### How do I define an initiative?

You define initiatives by using the Azure portal or by using command-line tools. From the Azure portal, you can search the list of built-in initiatives that are already provided by Azure or you can create your own custom policy definition.

The following image shows a few example Azure Policy initiatives in the Azure portal. 

![Screenshot showing Azure portal defining initiatives and definitions](../media/3-define-initiatives.png)

### How do I assign an initiative?

Like a policy assignment, an initiative assignment is an initiative definition that's assigned to a specific scope of a management group, a subscription, or a resource group.

Even if you have just a single policy, an initiative enables you to increase the number of policies over time. Because the associated initiative remains assigned, this makes it easier to add and remove policies without the need to change your resources' policy assignment.
