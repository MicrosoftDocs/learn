Whether your organization is planning to build a new application on Azure, or you're looking to move an entire data center to the cloud, estimating costs is a key part of your planning process to ensure a successful project. For example, how do you know which services to select, or which service tier or VM size to choose? Do you provision virtual machines for your workload, or do you take advantage of higher-level services that can reduce operational costs?

Proper planning is incredibly important to any cloud project. Let's take a look at what you need to consider.

## Capture requirements

Before beginning any cloud project, it's important to take time to plan properly, and that's especially important when considering costs. Start by identifying the stakeholders for the project. This should include the business teams that are driving the organizational outcomes. It should also include the technical teams involved in the project. Bring everyone to the same table and foster a culture of transparency. All teams involved in the project should have visibility into the decisions that will impact costs.

Identify the requirements of your project. Make sure you include both the business and technical requirements of the project, because both of these requirements can directly impact cost:

- Business requirements may be an API interface to enable partner communications or a reporting interface for the accounting department to view financial transactions.

- Technical requirements could be the ability to store relational data or the ability for users to use a personal identity to access applications.

All of these requirements would have impact on the overall cost of the project, and will influence the selection of services that are used to meet these requirements.

After you have identified your requirements, you'll want to define the workloads that are in scope to use cloud services and identify the services and resources you'll use. This will include evaluating and comparing service options in order to select the best services to meet your requirements.

When you have listed all of the requirements, services and resources for your project, you can begin to estimate your costs.

## Estimate costs

With your list of services captured, you can use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/?azure-portal=true) to create estimates of the cost of your application. The pricing calculator allows you to create, save, and share estimates for all Azure services. 

:::image type="content" source="../media/2-azure-pricing-calculator.png" alt-text="Screenshot of the Azure Pricing Calculator site" border="true":::

As part of your cost estimation, it's also important to understand the different subscription and billing models that are available on Azure. Two of the most common models are *pay-as-you-go* and *enterprise agreement*:

- Pay-as-you-go subscriptions give you the flexibility to purchase and use the services you need, with the advantage of having no up-front commitments.

- Enterprise agreements enable organizations to take advantage of discounts through up-front commitments. These agreements enable organizations to centralize their Azure costs and billing, and they can include other Microsoft services such as Office 365.

There are additional billing models, each giving you access to the full suite of Azure services with the flexibility to purchase only what you need, when you need it.

No architecture is static, so you'll want your estimates to include any investments that you may be planning to make in the future. In the long run, taking the extra time to plan effectively for your application's future will give you better visibility into the long-term costs for your project, even if your costs may shift over time. Evolving your architecture can reduce resources costs, such as moving from virtual machines to app services, and can reduce operational costs by requiring less downtime for maintenance.

## Create organization for cost-awareness

It's also important to set up an organizational framework to enable the control, reporting, and attribution of costs throughout your environment.

Use Azure policy to create limitations for the size or tier of resources that can be provisioned. For example, you can prevent users from creating virtual machines from the G or M series, which have higher costs. Should a need arise for VMs of those sizes, requests for those VMs could flow through an exception process, where individual scenarios can be reviewed and approved on a case by case basis. These types of policies will prevent your organization from facing unexpected large bills from your users creating resources that are larger than your projects actually need.

Enable your users to view reports and billing as needed by creating roles that allow them to view services such as Azure Cost Management. Allowing your users to view costs will give them the ability to see the impact of their business decisions, and provides for transparency across the organization in respect to cloud resource costs.

Organize your resources into resource groups or subscriptions, which can serve as boundaries for projects, business units, or services. You can also use Azure Policy to enforce the tagging of resources. Subscriptions, resource groups and tags are exposed in billing reports, which will enable you to account for the usage of resources by product, business unit, or project.

## Budget for education

Educating your engineers, developers, and users is an important piece of a successful cloud project. The cloud is a transformational shift for an organization, and is an ever-changing set of services and technologies. Your organization will need to ensure that your staff is properly trained to build and maintain resources on Azure. Microsoft provides full product documentation on Microsoft Docs, self-paced learning on Microsoft Learn, and has a large network of partners to deliver in-person and custom training for your staff.

Identify both the initial and ongoing training needs for your organization, and include this as part of the cost of your project.
