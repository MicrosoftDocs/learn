Deploying your infrastructure as code can help automate your deployments, increase confidence in your deployments, and increase efficiency and repeatability. But, these benefits only apply if you and your team are diligent and avoid making ad hoc manual changes to your environment. In this module, you'll learn how to apply configuration and governance to your Azure environment and pipelines to avoid unexpected or uncontrolled changes.

## Example scenario

Suppose you work as the Azure administrator at a toy company. Over the last several months, you and your team have been converting your Azure deployments to use Bicep, and automated them by using Azure Pipelines and GitHub Actions. But, you still have some team members who haven't quite adopted the mindset of deploying everything as code. Recently you had several situations where people haven't followed the recommended practices:

1. Somebody made a direct change to a resource by using the Azure portal.
1. Somebody deployed a Bicep file directly from their local computer.
1. Somebody used a pipeline's service principal to manually deploy a change to production.
1. Somebody commited a Bicep file change directly to the repository’s main branch, bypassing pull request reviews.
1. Somebody updated a Bicep file by using a pull request, and their changes were validated, tested, and deployed throughout the correct sequence of environments.

:::image type="content" source="../media/1-risks.png" alt-text="Diagram showing several approaches to making Azure configuration changes." border="false":::

Of all of these changes, only number 5 was deployed using the automation tools you've adopted and using your team's agreed process. Now, you want to enforce this rule so that you and your team can get the most benefit from your investment in automation. You've agreed with your team that you'll close off the ability to deploy to your Azure environment, except through the approved process:

:::image type="content" source="../media/1-risks-controlled.png" alt-text="Diagram showing several approaches to making Azure configuration changes, which are all blocked except for the approved process." border="false":::

## What will you be doing?

In this module, you'll learn how you can enforce the deployment of your Azure infrastructure as code. You'll look at how to consider the controls you need to apply to each of your environments, and you'll apply Azure governance and controls to protect your resources. You'll also learn how to secure your pipelines and repositories, ensuring that all of the aspects of your Azure configuration follow a recommended and hardened process.

> [!TIP]
> In this module, you'll be introduced to many security features. Links to more information about each feature are provided in the summary unit.

## What is the main goal?

By the end of this module, you'll be able to identify the security controls and governance that you should apply to your Azure environment, repositories, and pipelines, so that you can deploy all of your infrastructure as code.

## Prerequisites

You should be familiar with using:

- Infrastructure as code and its benefits, and technology such as Bicep or Terraform.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Managing your code in Git, including branching and pull requests.
- Automated deployments by using either GitHub Actions or Azure Pipelines.
