In this exercise, you'll apply what you've learned so far to configure your Azure Resource Manager templates, ready to onboard your first new customer to Azure Lighthouse.

> [!IMPORTANT]
> Your own Microsoft Azure subscription is required to complete this exercise, but the exercise can be viewed and this module completed without performing the exercise steps. The tasks incur no cost and a free Azure trial can be used.
>
> [Sign up for a free trial](https://azure.microsoft.com/free/).

## Exercise scenarios

As the administrator for Contoso, you're responsible for onboarding three new customers:

- **Customer 1** has a services contract for Contoso to manage and administer their entire Azure subscription and all of its resources. To achieve this, Contoso staff needs **Contributor** access to the customer's subscription.

- **Customer 2's** service contract requires **Reader** access to one resource group, called **"cust2-rg1"**.

- **Customer 3's** service contract requires **Reader** access to two resource groups in the same subscription, **"cust3-rg1"** and **"cust3-rg2"**.

In the opened lab, create a security group for your Contoso staff and prepare your Azure Resource Manager template files with your specific tenant and principal ID information. Save your template files so you can use them in the next exercise, where you'll onboard your customers.
