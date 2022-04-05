TODO

## Define your infrastructure as code

You can use Bicep to deploy resource groups, subscriptions, management groups, policies, RBAC role assignments, monitoring/alerting (will link to monitoring scenarios page in Bicep docs), etc. By using this approach you can get the benefits of IaC throughout your Azure estate. Will's comment: "By bringing alerting into our IaC, we have a way of tracking how those alerts have been setup through our commit history. Since setting up alerting is a change in our Azure environment, that's why I'd lean towards bringing that into our IaC code and automating the setup."

## Controlled environments

When you plan to deploy your infrastructure automatically, it's helpful to list out the environments you plan to use. In many organizations, there are a variety of environment types. Environments often have different characteristics. For example, some environments run production code. Others run non-production versions of the same code. Some are long-lived environments that are never intended to be deleted. Others are ephemeral, which might be created automatically and destroyed when they're no longer used. Some might be used by your infrastructure or software development team. Others might be used by your security team, or even by your sales team when they need to demonstrate a product to potential customers.

In some of these environments, it makes sense to require a formal process to review and apply changes. These are *controlled environments*. Production should always be a controlled environment. In addition, in many organizations, it's a good practice to control some of the non-production environments, too. By doing this, you can ensure that any restrictions imposed by the controls are well understood and tested before the production deployment.

In contrast, *uncontrolled environments* don't have many, or any, formal controls. They still might have the same code and similar configuration to your other environments, but they allow for more experimentation and ad hoc configuration changes.

For example, your toy company might have these environments:

| Environment name | Description | Owner | Lifetime | Control level |
|-|-|-|-|-|
| Production | TODO | Production Operations team | Long-lived | Controlled |
| Staging | TODO | Operations team | Long-lived | Controlled |
| QA | TODO | Operations team | Long-lived | Controlled |
| Test | TODO | Operations team | Long-lived | Controlled |
| Development | TODO | Operations team | Long-lived | Controlled |
| Demo | TODO | Sales team | Long-lived | Uncontrolled |
| Performance testing | TODO | Test team | Short-lived | Uncontrolled |
| Penetration testing | TODO | Security team | Short-lived | Uncontrolled |
| Ephemeral PR reviews | TODO | Development team | Short-lived | Uncontrolled |
| Development sandboxes | TODO | Development team | Short-lived | Uncontrolled |

## Gates and checks

Encourage the use of automated checks, like preflight validation, functional testing, and deployment to ephemeral environments, during code review. Also discuss how manual testing and approvals can be integrated into a release process, such as propagating changes between environments.

## Governance

Emphasise the role of tooling to support governance, including policies, locks, and logging. Mention landing zones as a way to build governance into your environment from the start, and there are prebuilt Bicep files for Azure's landing zones.

## Apply controls

It's much easier to lint, test, and review your code when you do it from the start, and it's much easier to work with security controls when they're present from the start (and in your non-production environments). In this Learn content we've introduced the concepts gradually, but it's often a good idea to add those elements in before you start to write your IaC.
