Your Azure estate consists of many components, including basic configuration, organization-wide resources and settings, and application workloads. You likely also have spread your estate across multiple environments, each with a different purpose.

In this unit, you'll learn about the benefit of consistently using code for all of your deployment and configuration. Then, you'll learn about how you can consider your environments, and the levels of control and automation that you might apply to each one. You'll consider how your changes progress through each stage of the deployment process, and the controls and types of governance you need to support your chosen deployment strategy.

## Define your infrastructure as code

Azure deployment and configuration cover far more than applications, virtual machines, storage services, networking, and the like. For example, each of the following items is a form of configuration, with corresponding Azure resources:

- Creating resource groups, subscriptions, and management groups to organize your resources.
- Defining and applying Azure Policy definitions, initiatives, and assignments to control how other resources should be configured.
- Assigning roles to allow users, groups, and service principals to access Azure resources.
- Configuring monitoring, including alerting, to observe your Azure resources and ensure they behave the way you expect.

When you first start defining your infrastructure as code, you might not be aware that all of these items can be defined in your templates or definitions. But as your use of automation matures, it's a good practice to define everything about your environment as code. By doing so, you can use a consistent, tested, and approved process for *all* of your Azure configuration. And because the code is versioned and tracked in a Git repository, you can review how your Azure environment has changed over time, and trace the history of each change.

For example, suppose you need to configure your Azure Monitor alerts. At first, you might think that alerts don't make sense to be deployed by using automation. But alerts are an important part of your Azure configuration, and if an alert isn't created correctly you might miss notifications of critical production issues. By defining your alerts in code, your team members can review the alerts and their configuration, you can deploy them to non-productions environments first if you need to test them, and you'll have full traceability of the changes to your Azure configuration.

## Environments

When you plan to deploy your infrastructure automatically, it's helpful to list out the environments you plan to use. In many organizations, there are a variety of environment types, each with different characteristics. For example, some environments run production code, while others run non-production versions of the same code but maybe with different configuration. Some are long-lived environments, which are never intended to be deleted, while others are ephemeral, which might be created automatically and destroyed when they're no longer used. Some might be used by your infrastructure or software development team, while others might be used by your security team, or even by your sales team when they need to demonstrate a product to potential customers.

For example, consider the environments that your toy company might use for your website:

:::image type="content" source="../media/2-environments.png" alt-text="Diagram showing the sequence of environments." border="false":::

When you make and commit changes to your application or to your infrastructure, your pipeline deploys your changes through a sequence of non-production environments: **Development**, **Test**, and **Staging**. You might have manual approval steps at different points as well which enable defined team members to verify the configuration or look at the pipeline log before the deployment continues. Then, your pipeline eventually deploys your changes to your **Production** environment.

But in addition to those environments, your sales team has their own **Demo** environment that they use when they talk to customers. They take a copy of the production environment to create their demo environment. And, your security and test team occasionally create temporary copies of the production environment for **Penetration testing** and **Performance testing**, respectively.

Your development team has their own sets of environments, too - they have **Sandboxes** for development team members to use when they're exploring new features or experimenting with Azure services, and they create **PR review** environments for each pull request that they review and merge.

### Controlled environments

In some of these environments, it makes sense to require a formal process to review and apply changes. These are *controlled environments*. **Production** should always be a controlled environment. In addition, it's a good practice to apply controls to some of the non-production environments, too. By doing this, you can ensure that any restrictions imposed by the controls are well understood and tested before the production deployment.

In contrast, *uncontrolled environments* don't have many, or any, formal controls. They still might have the same code and similar configuration to your other environments, but they allow for more experimentation and ad hoc configuration changes. In an uncontrolled environment, users might be allowed to modify the configuration by using the Azure portal, or through direct Azure CLI statements, and they might be able to create resources without using the organization's approved process. But, changes made in uncontrolled environments must be captured in code before they can start to be applied to controlled environments like **Production**.

> [!NOTE]
> Sometimes, an *environment* might actually represent multiple physical environments or deployments. For example, when you create ephemeral environments for pull request reviews, you might have multiple such environments active at a single time because your team has multiple pull requests open. But, for the purpose of planning your environments, you can consider them to be equivalent because they have the same characteristics and controls.

After some discussions with your team, you designate which environments are controlled and uncontrolled, as well as who owns each environment:

| Environment name | Description | Owner | Lifetime | Control level |
|-|-|-|-|-|
| Development | Integrates changes from multiple developers into a single environment. | Operations team | Long-lived | Controlled |
| Test | An environment for running manual and automated tests against changes. | Operations team | Long-lived | Controlled |
| Staging | The final non-production environment that changes are deployed to before production, with production-like configuration. | Operations team | Long-lived | Controlled |
| Production | Runs your production workloads. | Operations team | Long-lived | Controlled |
| Demo | Used by the sales team to demonstrate the product to new customers. | Sales team | Long-lived | Uncontrolled |
| Performance testing | Dynamically created as a duplicate of the production environment for running performance and stress tests, then deleted when the tests are completed. | Test team | Short-lived | Uncontrolled |
| Penetration testing | Dynamically created as a duplicate of the production environment for running penetration and security tests, then deleted when the tests are completed. | Security team | Short-lived | Uncontrolled |
| PR reviews | Dynamically created for each pull request that a team member creates to change the application or infrastructure, then deleted when the pull request is closed. | Development team | Short-lived | Uncontrolled |
| Development sandboxes | Created by development team members to experiment or explore, and deleted when they no longer need them. | Development team | Short-lived | Uncontrolled |

The above is just an example list of environments. In your own organization, you need to decide which environments you use, what their lifetime should be, and what level of control each environment needs.

> [!TIP]
> It's much easier to lint, test, and review your infrastructure code when you apply those processes early in your deployments, instead of adding it later and having to fix lots of broken code.
>
> Similarly, it's much easier to work with security controls when they're present from the start, and when they're also applied to some of your non-production environments, so that your team gets used to working within a controlled environment.
> 
> Throughout the learning paths, we've introduced some of these concepts gradually. But it's often a good idea to add these elements into your deployment process as early as you can.

### Isolate each environment

It's important to separate each of your environments, and to make them self-contained wherever possible. Using dedicated Azure subscriptions for each environment can help, but you still need to be careful to keep your environments separated.

Avoid connecting from one environment to another. For example, don't peer a production environment's virtual network to a non-production environment's virtual network. Otherwise, it's easy for somebody to accidentally change production data from within a non-production environment, or to leak sensitive production data to a non-production environment.

## Checks and gates

As your deployment process proceeds, it should run a series of checks to increase your confidence in the deployment. Checks for infrastructure often include:

- Code reviews.
- Deployment of your in-review code to ephemeral environments, and running automated or manual tests against the environment.
- Linting.
- Preflight validation.
- Manual testing.
- Manual approval.
- Automated functional testing.
- Automated smoke testing.
- Waiting for health signals from a previous environment before progressing to the next environment.

You might run some of these checks multiple times within your deployment process, such as for each controlled environment.

> [!TIP]
> When you design your deployment process, list all of the steps you need to perform for a deployment, no matter how small or obvious.  Be as detailed as you can. You might not choose to automate everything at first, but following this practice will help you to create a blueprint for your automated deployment processes in future.

When automated or manual checks need to succeed in order to continue with a deployment or deploy to a new environment, these are called *gates*.

### Manual intervention

It's a good idea to automate as many checks as possible during your code review and deployment processes. However, your organization might require manual approval for deployment to production or other controlled environments.

If you use manual approval gates for deployments, follow these recommended practices:

> [!div class="checklist"]
>
> * **Clearly define who is allowed to approve a deployment.** Use Azure AD groups to define approvers instead of specifying individual users, so that you can easily change the list of approvers in the future.
> * **Ensure you have a process for emergency deployments.** Understand who can approve a deployment if the normal approvers aren't available.
> * **Limit human intervention to just approving or rejecting the deployment.** Avoid having humans executing the deployment operations, unless there's a step that you can't automate.

## Governance
Azure provides a set of tools and capabilities to help you to govern your environment, including:

- Azure Policy, to detect resources that have been configured in ways that don't fit with your organization's requirements, or even to prevent resources from being created or reconfigured in a way that will cause them to be out of compliance.
- Locks, to prevent changes to or deletion of important resources.
- Management groups, to help you organize your Azure subscriptions and configure role-based access control and policies consistently across your environments.
- Azure Monitor, to record metrics and logs from your resources, present them in dashboards, and automatically alert you when they deviate from your expected values.

When you build your Azure estate, you can consider using the *Azure landing zones*. By using a landing zone, you can build governance into your environment from the start. Many landing zones include prebuilt Bicep and Terraform files to help you to configure your environment. We link to more information in the summary.
