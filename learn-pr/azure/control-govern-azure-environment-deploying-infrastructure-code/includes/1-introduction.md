When you deploy your infrastructure as code, you can automate your deployments, improve your confidence in your deployments, and increase the efficiency of your team's work. But these benefits apply only if you and your team are diligent and avoid making manual changes to your environment. 

In this module, you learn how to apply configuration and governance to your Azure environment and pipelines to avoid unexpected or uncontrolled changes.

> [!NOTE]
> The GitHub Actions term for a pipeline is *workflow*. For simplicity, we use *pipeline* throughout this module to refer to both pipelines in Azure Pipelines and workflows in GitHub Actions.

## Example scenario

Suppose you work as the Azure administrator at a toy company. Over the last several months, you and your team have been converting your Azure deployments to use Bicep. You've automated your deployment processes by using pipelines. But your team still has some members who haven't yet adopted the mindset of deploying all of their changes as code.

Recently, you had several situations where people deployed to Azure by using different processes:

1. Somebody made a direct change to a website's configuration by using the Azure portal.
1. Somebody deployed a new Bicep file directly from their own computer.
1. Somebody copied a pipeline's service principal credentials and used them to access the production environment by using the Azure CLI.
1. Somebody committed a Bicep file change directly to the repository’s *main* branch, bypassing pull-request reviews.
1. Somebody updated a Bicep file by using a pull request. The changes were validated, tested, and deployed throughout the correct sequence of environments.

The following diagram illustrates these scenarios:

:::image type="content" source="../media/1-risks.png" alt-text="Diagram that shows several approaches to making Azure configuration changes." border="false":::

Of all of these changes, only number 5 was deployed through the automation tools you've adopted and the process on which your team agreed. None of the other changes caused any damage, but you don't want to push your luck. Your team has decided to enforce your process so that you can get the most benefit from your investment in automation. You and your team have agreed to close off the ability to deploy to your Azure environment, except through the approved process:

:::image type="content" source="../media/1-risks-controlled.png" alt-text="Diagram that shows several approaches to making Azure configuration changes, which are all blocked except for the approved process." border="false":::

## What will you be doing?

In this module, you learn how to enforce the deployment of your Azure infrastructure as code. You consider the controls that you need to apply to each of your environments, and apply governance and security policies to protect your Azure resources. You also learn how to help secure your pipelines and repositories by ensuring that all aspects of your Azure configuration follow a recommended and hardened process.

> [!TIP]
> This module will introduce you to many security features. The summary unit has links to more information about each feature.

## What is the main goal?

By the end of this module, you're able to identify the security controls and governance that you should apply to your Azure environment, repositories, and pipelines, allowing you to deploy all of your infrastructure as code.

## Prerequisites

You should be familiar with using:

- Infrastructure as code and its benefits, and technology such as Bicep or Terraform.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Git to manage your code, including branches and pull requests.
- Automated deployments through either GitHub Actions or Azure Pipelines.
