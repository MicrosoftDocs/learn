Policy is the backbone of Azure implementation and compliance. Compliance is an evolving scenario that you'll always need to assess and adjust according to the needs of the moment at your organization. You also need to carefully plan your policies so you don't interrupt other teams that require a more flexible policy than the one you've defined. 

Through Azure Policy, you can control the types of resources that can be provisioned. Or, you can restrict the locations where resources can be provisioned. Unlike role-based access control (RBAC), the policy is a standard system of explicit permission and denial.

:::image type="content" source="../media/1-azure-policy.png" alt-text="Screenshot that shows an Azure Policy overview example." lightbox="../media/1-azure-policy.png":::

## Example scenario

Due to a new cost optimization initiative in your company, you want more granular control over the resources deployed in your Azure environment. You also want to avoid deploying resources in regions where the costs are higher.

The cloud administration team brings to you the following definitions:

* For the production subscription, only the regions Central US and East US2 will be used for new deployments.
* For the dev/test subscription, only three specific types of virtual machines SKUs will be allowed.

For this use-case scenario, you can use Azure Policy to meet those requirements: 

* Create a new assignment by using a built-in policy called **Allowed locations** that's associated with the production subscription, and then specify the regions Central US and East US2.
* Create another assignment by using a built-in policy called **Allowed virtual machine SKUs** that's associated with the dev/test subscription, and select properly with the three SKUs of virtual machines allowed.

## What will we be doing?

In this module, you'll learn what Azure Policy is and how you can use it to meet compliance requirements in your environment.

## What is the main goal?

By the end of this session, you'll be able to create policies and initiatives, and to validate the compliance status of your environment, by using Azure Policy.
