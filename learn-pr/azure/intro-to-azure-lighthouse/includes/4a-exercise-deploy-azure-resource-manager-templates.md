In this exercise, you will apply what you've learned so far to configure and deploy Azure Resource Manager templates to onboard three new customers to Azure Lighthouse.

> [!IMPORTANT]
> Your own Microsoft Azure subscription is required to complete this exercise, but the exercise can be viewed and this module completed without performing the exercise steps. The tasks incur no cost and a free Azure trial can be used.
>
> [Sign up for a free trial](https://azure.microsoft.com/free/).

## Exercise scenarios

As the administrator for Contoso, you are responsible for onboarding three new customers:

**Customer 1** has a services contract for Conotoso to manage and administer their entire Azure subscription and all of its resources. To achieve this, Contoso staff will need **Contributor** access to the customer's subscription.

**Customer 2's** service contract requires **Reader** access to one resource group, called **"cust2-rg1"**.

**Customer 3's** service contract requires **Reader** access to two resource groups in the same subscription, **"cust3-rg1"** and **"cust3-rg2"**.

First, you will create a security group for your Contoso staff and prepare your Azure Resource Manager template files with your specific tenant and principal ID information.

Next, you'll configure and deploy your Azure Resource Manager template to Customer 1, using PowerShell.

Finally, you'll configure and deploy the appropriate Azure Resource Manager templates from GitHub to Customer 2 and Customer 3.  
