
Just as a blueprint allows an engineer or an architect to sketch a project's design parameters, Azure Blueprints enables cloud architects and central information technology groups to define a repeatable set of Azure resources that implements and adheres to an organization's standards, patterns, and requirements. Azure Blueprints allows development teams to rapidly build and stand up new environments with the trust they're building within organizational compliance with a set of built-in components, such as networking, to speed up development and delivery.

Blueprints are a declarative way to orchestrate the deployment of various resource templates and other artifacts, such as:

 -  Role Assignments
 -  Policy Assignments
 -  Azure Resource Manager templates
 -  Resource Groups

The Azure Blueprints service is supported by the globally distributed Azure Cosmos Data Base. Blueprint objects are replicated in multiple Azure regions. This replication provides **low latency**, **high availability**, and **consistent access** to your blueprint objects, regardless of which region Blueprints deploys your resources to.

## How is it different from Azure Resource Manager templates?

The service design helps with environment setup. This setup often includes **resource groups**, **policies**, **role assignments**, and **Resource Manager template deployments** assigned to a subscription in a single audited and tracked operation. A blueprint is a package to bring each artifact type together and allows you to compose and version that package into a continuous integration and pipeline.

Nearly everything that you want to include for deployment in Blueprints is also with a Resource Manager template. However, a Resource Manager template is a document that doesn't exist natively in Azure – it's stored either locally or in source control. The template gets used for deployments of one or more Azure resources, but once those resources deploy, there's no active connection or relationship to the template.

Blueprints save the relationship between the blueprint definition and the blueprint assignment. This connection supports improved tracking and auditing of deployments. Blueprints can upgrade several subscriptions governed by the exact blueprint.

There's no need to choose between a Resource Manager template and a blueprint. Each blueprint can consist of zero or more Resource Manager template artifacts. This support means that previous efforts to develop and maintain a library of Resource Manager templates are reusable in Blueprints.

## How it's different from Azure Policy

A blueprint is a package or container for composing focus-specific standards, patterns, and requirements for implementing Azure cloud services, security, and design reused to maintain consistency and compliance.

An Azure policy is a **default allow** and **explicit deny** system focused on resource properties during deployment and for existing resources. It supports cloud governance by validating that help within a subscription adhere to requirements and standards.

Including an Azure policy in a blueprint enables the creation of the correct pattern or design during the assignment of the blueprint. The policy inclusion ensures that only **approved** or **expected changes** can be made to the environment to protect ongoing compliance with the intent of the blueprint.

An Azure policy is available as one of many artifacts in a blueprint definition. Blueprints also support using parameters with **policies** and **initiatives**.

## Blueprint definition

A blueprint is composed of ***artifacts***. Azure Blueprints currently supports the following resources as artifacts:

| **Resource**      | **Hierarchy options**        | **Description**                                                                                                                                                                                                                                                                                                                  |
| ----------------- | ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Resource Groups   | Subscription                 | Create a new resource group for use by other artifacts within the blueprint. These placeholder resource groups enable you to organize resources exactly how you want them structured and provide a scope limiter for included policy and role assignment artifacts and ARM templates.                                            |
| ARM template      | Subscription, Resource Group | Templates, including nested and linked templates, are used to compose complex environments. Example environments: a SharePoint farm, Azure Automation State Configuration, or a Log Analytics workspace.                                                                                                                         |
| Policy Assignment | Subscription, Resource Group | Allows assignment of a policy or initiative to the subscription the blueprint is assigned to. The policy or initiative must be within the scope of the blueprint definition location. If the policy or initiative has parameters, these parameters are assigned at the creation of the blueprint or during blueprint assignment. |
| Role Assignment   | Subscription, Resource Group | Add an existing user or group to a built-in role to make sure the right people always have the right access to your resources. Role assignments can be defined for the entire subscription or nested to a specific resource group included in the blueprint.                                                                     |

## Blueprint definition locations

When creating a blueprint definition, you'll define where the blueprint is saved. Blueprints can be saved to a **management group** or **subscription** that you have **Contributor access** to. If the location is a management group, the blueprint is available to assign to any child subscription of that management group.

## Blueprint parameters

Blueprints can pass parameters to either a **policy/initiative** or an **ARM template**. When adding either ***artifact*** to a blueprint, the author decides to provide a defined value for each blueprint assignment or to allow each blueprint assignment to provide a value at assignment time. This flexibility provides the option to define a pre-determined value for all uses of the blueprint or to enable that decision to be made at the time of assignment.

> [!NOTE]
> Assigning a blueprint definition to a management group means the assignment object exists in the management group. The deployment of artifacts still targets a subscription. To perform a management group assignment, the **Create** Or **Update REST API** must be used, and the request body must include a value for **properties.scope** to define the target subscription.
