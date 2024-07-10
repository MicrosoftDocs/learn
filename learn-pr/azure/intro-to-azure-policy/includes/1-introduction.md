Policy is the backbone of Azure implementation and compliance. Compliance is an evolving scenario that you always need to assess and adjust according to the needs of the moment. You also need to carefully plan your policies so as not to interrupt other units that require a more flexible policy than the one you defined. Through Azure Policy, you can control the types of resources that can be provisioned, or you can restrict the locations where resources can be provisioned.

:::image type="content" source="../media/1-azure-policy.png" alt-text="Screen with the Azure Policy overview example." lightbox="../media/1-azure-policy.png":::

## Example scenario

Because of a new cost-optimization initiative in your company, you should be able to have a more granular control over the resources deployed in your Azure environment. You should also avoid deploying resources in regions where the costs are higher.

The cloud administration team brings you the following definitions:

- For the production subscription, only the regions Central US and East US2 can be used for new deployments.
- For the dev/test subscription, only three specific types of virtual machines SKUs are allowed.

You can use Azure Policy to meet the requirements of this use-case scenario:

- Create a new assignment using a built-in policy called **Allowed locations** associated with the production subscription, then specify the regions Central US and East US2.
- Create another assignment using a built-in policy called **Allowed virtual machine size SKUs** associated with the dev/test subscription, and properly select from the three SKUs of virtual machines allowed.

## What will we be doing?

In this module, we learn about what Azure Policy and how you can use it to meet compliance requirements in your environment.

## What is the main goal?

By the end of this session, you understand why you should use Azure Policy.
