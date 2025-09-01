Cloud cost management is a discipline that includes people, processes, tools, and data. This discipline helps ensure that cloud resources are sized correctly, meet business requirements for application performance, and that their cost is relative to the benefit they give the business.

With the consumption-based model of the cloud (pay for what you use), it's natural to ask both "how much will this cost?" and "why is this costing so much?". So, cloud cost management is considered at every stage in an application's lifecycle - from estimating costs before deployment, through to saving money by decommissioning resources that are no longer needed.

## Preparing your cloud environment

There are several design decisions for your Microsoft Azure cloud environment that will help your cost management processes and align the structure of your cloud resources with your organization's structure. These include:

- **Establishing your subscriptions** - Subscriptions provide a billing container for Azure resources, with all of your cloud resources in that subscription appearing on one invoice. They often mirror environment types, with separate subscriptions for Development or Production workloads. They aren't limited to a geographical region and can also be used for enforcing policies. For cost management, they're top level of cloud cost data. 
- **Adopting consistent naming conventions** - When investigating costs, you want to know what a resource is, what it's being used for and who is using it. This is easier if you have defined a structure naming convention for your Azure resources that is used by everyone who has access to create new cloud resources.  
- **Applying resource tags** - Azure resource tags add additional metadata to your Azure resources that can be helpful when analyzing cost data. For example, you can add department or business unit values as tags, and use this for cost report filtering or for cost allocation (also known as chargeback or internal cross-charging). 

The Microsoft Cloud Adoption Framework provides additional recommendations for planning and structuring your Microsoft Azure environment. 

## Estimating costs

With your Microsoft Azure environment established, cost becomes a consideration when you are designing your application architecture. Premium resource features may be necessary for highly available, production applications, but excessive for test or development environments. Your business requirements are going to influence the cost of your application, as well as any additional usage costs (like storage amounts and network traffic). 

You can estimate the cost of your Microsoft Azure resources with the [Microsoft Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/).  

## Monitoring costs

It's important to identify who needs access to cost data and how often, given the range of roles that can have an interest in cloud costs. This can include business decisions makers, developers, IT operations, and finance teams, with each of these personas having a different responsibility related to cloud costs. Tools can include the Cost analysis reports in Microsoft Cost Management, or cost data exports to build more detailed, custom reports. But you need to understand how cost and usage are related, and the specific billing models for your cloud resources. 

Establishing budgets and alert thresholds helps you drive organizational accountability proactively, before the end of the billing cycle. They give people visibility of how spend is progressing over time. 

## Optimizing costs

Cost optimization requires comparing cost data with business usage data and business requirements. Cost reduction for the sake of saving money can negatively impact application performance. For example, if you're using an Azure Machine Learning Compute Instance to train deep learning models, CPU-based virtual machines are significantly cheaper than GPU virtual machines, but deep learning training will be orders of magnitude slower and could take days instead of hours. But cost optimization can include right-sizing underutilized resources, removing unused resources, rearchitecting applications, and taking advantage of rate discounts with savings plans and reserved instances.
