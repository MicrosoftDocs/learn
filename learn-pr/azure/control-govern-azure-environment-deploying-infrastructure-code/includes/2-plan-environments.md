TODO

## Define your infrastructure as code

You can use Bicep to deploy resource groups, subscriptions, management groups, policies, RBAC role assignments, monitoring/alerting (will link to monitoring scenarios page in Bicep docs), etc. By using this approach you can get the benefits of IaC throughout your Azure estate. Will's comment: "By bringing alerting into our IaC, we have a way of tracking how those alerts have been setup through our commit history. Since setting up alerting is a change in our Azure environment, that's why I'd lean towards bringing that into our IaC code and automating the setup."

## Controlled environments

Understand that there are different categories of environments. *Controlled* environments are those that require a formal process for code review and deployment. Production should be a controlled environment, and in many organisations, they will also control some or all of their non-production environments. *Uncontrolled* environments don't need IaC - for example, sandboxes used by the development teams, ephemeral environments used in pull request reviews, and maybe environments for specialised purposes like penetration testing and performance testing. Maybe mention that controlled/uncontrolled isn't the same as long-lived vs. short-lived.

## Gates and checks

Encourage the use of automated checks, like preflight validation, functional testing, and deployment to ephemeral environments, during code review. Also discuss how manual testing and approvals can be integrated into a release process, such as propagating changes between environments.

## Governance

Emphasise the role of tooling to support governance, including policies, locks, and logging. Mention landing zones as a way to build governance into your environment from the start, and there are prebuilt Bicep files for Azure's landing zones.

## Apply controls

It's much easier to lint, test, and review your code when you do it from the start, and it's much easier to work with security controls when they're present from the start (and in your non-production environments). In this Learn content we've introduced the concepts gradually, but it's often a good idea to add those elements in before you start to write your IaC.
