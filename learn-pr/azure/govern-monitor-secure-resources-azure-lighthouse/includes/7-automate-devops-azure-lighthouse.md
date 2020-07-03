You’ve seen how Azure Lighthouse can help Relecloud manage Lamna Healthcare’s hybrid resources at scale. Azure Sentinel enables Relecloud to detect, investigate, and respond to threats across environments. Now you’ll explore how Relecloud can use Azure Lighthouse together with Azure DevOps to provide this service to multiple customers, including Lamna Healthcare, through automation. 

## Onboard customers into Azure Lighthouse

You onboard customers for your managed service through Azure Lighthouse first. You can onboard customers in the usual way, by using either an Azure Resource Manager template, or by the customers activating a Managed Services Offer from Relecloud on the Marketplace.

You define the correct roles Relecloud users need to provide the service in either the Marketplace Offer or the template. You need the built-in Sentinel roles, which are Azure Sentinel Reader, Azure Sentinel Responder, and Azure Sentinel Contributor. These roles can be mapped to users or service principals that belong to Relecloud. 

:::image type="content" source="../media/7-sentinel-plans.png" alt-text="":::

You can create multiple plans in one offer. Each plan can have separate permissions for access to the customer’s environment. For example, you can use one plan as a full Azure Sentinel managed services plan, while you can use the other one for limited services for customers that want less management. You use service principals, such as the Automation (SPN) in the plan, to connect Azure DevOps with the customer’s Azure subscription.

## Manage multiple customers using Azure DevOps

Azure DevOps consists of a collection of services that enables companies like yours to manage how they can build, develop, and deploy code for their applications and services. Azure DevOps can be used to automate the deployment of services like Azure Sentinel.

You do the following to set up Azure DevOps to work with multiple customers:

- **Create Azure DevOps Service connections**: You’ll create a service connection for each customer that you’re providing services to. These connections can all be assigned to the same service principal identified in the Managed Services Offer plan.
- **Create Azure DevOps variables**: You’ll also create one variable group for each of your customers. You will then be able to use these across its jobs, pipelines, and stages accordingly.
- **Code repositories**: You can decide how you want to manage the code repositories. For example, you can have:
    - *A single repository for all customers, and no further separation*: If you want to apply the same configurations (Analytics rules, Connectors, etc.) across all customers. Note that customers will diverge in their needs over time, so this option is mostly useful for initial set up.
    - *A single repository for all customers, but with separate folders for each customer*: This way, you can make changes to specific customer configurations, but keep shared Azure Sentinel artifact files in a single place.
    - *One Azure DevOps project per customer*: This offers even greater separation between customers. You are then able to configure separate permissions, repositories, service connections, etc., for each customer. You can also use independent Azure DevOps Board instances for each customer and collaborate with each customer separately.

- **Azure DevOps Pipelines**:

    You can organize your deployment pipelines in multiple ways to provide services to your customers:

    - *One pipeline for each customer*: This the recommended way to keep configuration files for customers separated. Each pipeline will only contain the configuration files for a single customer. Pipelines are only triggered when a configuration for a related customer has been changed.

    :::image type="content" source="../media/7-single-pipeline-customer.png" alt-text="Customer per pipeline":::

    - *Single pipeline for all customers, with a stage per customer*: You can create multiple stages in a single pipeline, each stage used for a particular customer. Useful for if you want to have a shared set of configuration files for all customers.  This structure enables you to manage fewer pipelines, but doesn’t give you as much control as the previous structure. The pipeline is triggered when any customer configuration has been modified. You can use this structure to define different approvals and conditions that must be met before a stage is allowed to run or is blocked from running.

    :::image type="content" source="../media/7-stage-customer.png" alt-text="Stage per customer":::

    -	*Single pipeline, single stage, but one job per customer*: You can also create a single pipeline, with a single stage.  The single release stage can have multiple jobs inside of it, one for each customer. The pipeline is triggered when any customer configuration has been modified. This structure enables you to manage fewer stages, but provides the least control over deployment.

    :::image type="content" source="../media/7-job-customer.png" alt-text="Job per customer":::