TODO

## Define your infrastructure as code

You can use Bicep to deploy resource groups, subscriptions, management groups, policies, RBAC role assignments, monitoring/alerting (will link to monitoring scenarios page in Bicep docs), etc. By using this approach you can get the benefits of IaC throughout your Azure estate. Will's comment: "By bringing alerting into our IaC, we have a way of tracking how those alerts have been setup through our commit history. Since setting up alerting is a change in our Azure environment, that's why I'd lean towards bringing that into our IaC code and automating the setup."

## Controlled environments

When you plan to deploy your infrastructure automatically, it's helpful to list out the environments you plan to use. In many organizations, there are a variety of environment types. Environments often have different characteristics. For example, some environments run production code. Others run non-production versions of the same code. Some are long-lived environments that are never intended to be deleted. Others are ephemeral, which might be created automatically and destroyed when they're no longer used. Some might be used by your infrastructure or software development team. Others might be used by your security team, or even by your sales team when they need to demonstrate a product to potential customers.

For example, consider the environments that your toy company might use:

:::image type="content" source="../media/2-environments.png" alt-text="Diagram showing the sequence of environments." border="false":::

When you make and commit changes to your application or to your infrastructure, your pipeline deploys your changes through a sequence of non-production environments: **Development**, **Test**, and **Staging**. You might have manual approval gates at different points as well. Then, your pipeline eventually deploys your changes to your **Production** environment.

But in addition to those environments, your sales team has their own **Demo** environment that they use when they talk to customers. They take a copy of the production environment to create their demo environment. And, your security and test team occasionally create temporary copies of the production environment for **Penetration testing** and **Performance testing**, respectively.

Your development team has their own sets of environments, too - they have **Sandboxes** for development team members to use when they're exploring new features or experimenting with changes, and they create **PR review** environments for each pull request that they review and merge.

In some of these environments, it makes sense to require a formal process to review and apply changes. These are *controlled environments*. Production should always be a controlled environment. In addition, in many organizations, it's a good practice to control some of the non-production environments, too. By doing this, you can ensure that any restrictions imposed by the controls are well understood and tested before the production deployment.

In contrast, *uncontrolled environments* don't have many, or any, formal controls. They still might have the same code and similar configuration to your other environments, but they allow for more experimentation and ad hoc configuration changes.

> [!NOTE]
> Sometimes, an *environment* might actually represent multiple physical environments or deployments. For example, when you create ephemeral environments for pull request reviews, you might have multiple such environments active at a single time because you have multiple pull requests open. But, for the purpose of planning your environments, you can consider them to be consistent because they have the same characteristics and controls.

After some discussions with your team, you might designate which environments are controlled and uncontrolled:

| Environment name | Description | Owner | Lifetime | Control level |
|-|-|-|-|-|
| Development | Integrates changes from multiple developers into a single environment. | Operations team | Long-lived | Controlled |
| Test | An environment for running manual and automated tests against changes. | Operations team | Long-lived | Controlled |
| Staging | The final non-production environment that changes are deployed to before production. | Operations team | Long-lived | Controlled |
| Production | Runs your production workloads. | Production Operations team | Long-lived | Controlled |
| Demo | Used by the sales team to demonstrate the product to new customers. | Sales team | Long-lived | Uncontrolled |
| Performance testing | Dynamically created as a duplicate of the production environment for running performance and stress tests, then deleted when the tests are completed. | Test team | Short-lived | Uncontrolled |
| Penetration testing | Dynamically created as a duplicate of the production environment for running penetration and security tests, then deleted when the tests are completed. | Security team | Short-lived | Uncontrolled |
| Ephemeral PR reviews | Dynamically created for each pull request (PR) that a team member creates to change the application or infrastructure, then deleted when the pull request is closed. | Development team | Short-lived | Uncontrolled |
| Development sandboxes | Created by development team members to experiment or explore, and deleted when they no longer need them. | Development team | Short-lived | Uncontrolled |

> [!IMPORTANT]
> This is an example list of environments. In your own organization, you need to decide which environments you use, what their lifetime should be, and what level of control each environment needs.

## Gates and checks

Encourage the use of automated checks, like preflight validation, functional testing, and deployment to ephemeral environments, during code review. Also discuss how manual testing and approvals can be integrated into a release process, such as propagating changes between environments.

## Governance

Emphasise the role of tooling to support governance, including policies, locks, and logging. Mention landing zones as a way to build governance into your environment from the start, and there are prebuilt Bicep files for Azure's landing zones.

## Apply controls

It's much easier to lint, test, and review your code when you do it from the start, and it's much easier to work with security controls when they're present from the start (and in your non-production environments). In this Learn content we've introduced the concepts gradually, but it's often a good idea to add those elements in before you start to write your IaC.
