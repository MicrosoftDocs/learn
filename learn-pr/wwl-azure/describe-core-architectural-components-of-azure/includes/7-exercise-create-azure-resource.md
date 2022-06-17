In this exercise, you’ll use the Azure portal to create a resource. The focus of the exercise is observing how Azure resource groups populate with created resources.

## Task 1: Create a virtual machine

In this task, you’ll create a virtual machine using the Azure portal.

1.  Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
2.  Select Create a resource &gt; Compute &gt; Virtual Machine &gt; Create.
3.  The Create a virtual machine pane opens to the basics tab.
4.  Verify or enter the following values for each setting. If a setting isn’t specified, leave the default value.

**Basics tab**

:::row:::
  :::column:::
    **Setting**
  :::column-end:::
  :::column:::
    **Value**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Subscription
  :::column-end:::
  :::column:::
    Concierge Subscription
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Resource group
  :::column-end:::
  :::column:::
    &lt;rng&gt;&lt;/rng&gt;
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Virtual machine name
  :::column-end:::
  :::column:::
    my-VM
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Authentication type
  :::column-end:::
  :::column:::
    Password
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Username
  :::column-end:::
  :::column:::
    azureuser
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Password
  :::column-end:::
  :::column:::
    Enter a custom password
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Confirm password
  :::column-end:::
  :::column:::
    Reenter the custom password
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Public inbound ports
  :::column-end:::
  :::column:::
    None
  :::column-end:::
:::row-end:::


4.  Select Review and Create.

> [!IMPORTANT]
> Product details will include a cost associated with creating the virtual machine. This is a system function. If you’re creating the VM in the Learn sandbox, you won’t actually incur any costs.

5.  Fill in the Preferred e-mail address field.
6.  Fill in the Preferred phone number field.
7.  Select Create

Wait while the VM is provisioned. Deployment is in progress will change to Deployment is complete.

## Task 2: Verify resources created

Once the deployment is created, you can verify that Azure created not only a VM, but all of the associated resources the VM needed.

1.  Select Home
2.  Select Resource groups
3.  Select the &lt;rgn&gt;&lt;/rgn&gt; resource group

You should see a list of resources in the resource group. The storage account and virtual network are associated with the Learn sandbox. However, the rest of the resources were created when you created the. By default, Azure gave them all a similar name to help with association and grouped them in the same resource group.

Congratulations! You've created a resource in Azure and had a chance to see how resources get grouped on creation.

## Clean up

The sandbox automatically cleans up your resources when you're finished with this module.

When you're working in your own subscription, it's a good idea at the end of a project to identify whether you still need the resources you created. Resources that you leave running can cost you money. You can delete resources individually or delete the resource group to delete the entire set of resources.
