Whether your organization is planning to build a new application on Azure or you're looking to move an entire data center to the cloud, estimating costs is a key piece of ensuring a successful project. How do you know which services to select, or which size to choose? Do you provision virtual machines for your workload, or do you take advantage of higher-level servcies that can reduce operational costs? Proper planning is incredibly important to any cloud project, let's take a look at what to consider.

## Capture requirements

Before beginning any cloud project, it's important to take time to properly plan, and that's especially important when considering costs. Start by identifying the stakeholders for the project. This should include the business teams that are driving the organizational outcomes. It should also include the technical teams involved in the project. Bring everyone to the same table and foster a culture of transparency. All teams involved in the project should have visibility into the decisions that are made that impact cost.

Capture the requirements of the application. Include both the business requirements and the technical requirements of the application, as both can directly impact cost. Business requirements may be an API interface to enable partner communications or a reporting interface for the accounting department to view financial transactions. Technical requirements could be the ability to store relational data or the ability for users to use a personal identity to access applications. All of these requirements would have impact on the overall cost of the application, and will influence the selection of services that are used to meet these requirements.

Once you have the requirements identified, you'll want to define the workloads that are in scope to use cloud services and identify the services and resources you'll use. This will include evaluating and comparing service options to select the best service to meet your requirements. Once identified, you can then begin to estimate costs for your application.

## Estimate costs

With your list of services captured, you can use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/?azure-portal=true) to create estimates of the cost of your application. The pricing calculator allows you to create, save, and share estimates of all Azure services. 

:::image type="content" source="../media/2-azure-pricing-calculator.png" alt-text="Screenshot of the Azure Pricing Calculator site" border="true":::

As part of your cost estimation, it's also important to understand the different subscription and billing models available on Azure. Two of the most common models are *pay-as-you-go* and *enterprise agreement*:

- Pay-as-you-go subscriptions give you flexibility to purchase and use the services you need with the flexibility of no upfront commitments.
- Enterprise agreements enable organizations to take advantage of discounts through up-front commitments. They enable organizations to centralize their Azure costs and billing, and can include other Microsoft services such as Office 365.

There are additional billing models, but all of them will provide you access to the full suite of Azure services with the flexibility to purchase only what you need, when you need it.

No architecture is static, so you'll want to include in your estimates any future investments that you may be planning to make. This will give you longer term visibility into the costs for your application, and how those may shift over time. Often times the additional investment can reduce costs, such as moving from virtual machines to app services, reducing operational costs.

## Create organization for cost-awareness

It's also important to set up a framework of organization to enable the control, reporting, and attribution of costs throughout your environment.

Use Azure policy to create control policies to put limitations around the size or tier of resources that can be provisioned. For example, you can prevent users from creating virtual machines from the G or M series, which have a higher cost. Should VMs of those sizes be required, these could flow through an exception process. This would prevent unexpected large bills from users provisioning VMs of this size, and ensure they go through a process to be reviewed and approved.

Enable your users to view reports and billing as needed by creating roles that allow them to view services such as Azure Cost Managment. This gives them the ability to see the impact of their business decisions, and provides for transparency across the organization in respect to cloud resource costs.

Organize resources in a resource group or subscription as a boundary for projects, business units, or services. You can also use Azure Policy to enforce tagging of resources. Subscription, resource groups and tags are exposed in billing reports, enabling you to account for the usage of resources related to a product, business unit, or project.

## Budget for education

Educating your engineers, developers, and users is an important piece of a successful cloud project. The cloud is a transformational shift for an organization, and is an ever-changing set of services and technologies. Your organization will need to ensure that your staff is properly trained to build and maintain resources on Azure. Microsoft provides full product documentation on Microsoft Docs, self-paced learning on Microsoft Learn, and has a large network of partners to deliver in-person and custom training for your staff.

Identify both the initial and ongoing training needs for your organization, and include this as part of the cost of your project.
