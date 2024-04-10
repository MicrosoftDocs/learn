| :::image type="icon" source="../media/goal.svg"::: Implement guardrails in the deployment process to minimize the effect of errors or unexpected conditions. |
| :----------------------------------------------------------------------------------------------------------------------------- |

During the development cycle, workload artifacts go through many changes as they get implemented and tested and as bugs are fixed.

The deployment process must follow a standard operating procedure. Any change must be deployed with the same level of rigor. This principle applies equally to code, configuration, and all related artifacts. The key is to apply safe practices as early as possible so that you have predictability in production. Even if errors reach the customers, you should be able to roll out recovery changes as soon as possible.

**Example scenario**

Contoso Air has developed a web application that allows customer to book flights directly through the app. The app has been running in production for over a year. 

The app is fully deployed in Azure and is built on Azure App Service, Azure Cosmos DB, Azure Functions, Azure Logic Apps, and Azure Service Bus. 

## Codify automated deployment standards

**Standardize the process to deploy any change by using automated deployment processes, such as pipelines. All environments must use pipelines.Classify assets and versions per environment to make them easily traceable and identifiable.**

Consistent deployment methods reduce issues caused by process errors and variance and allow you to focus your effort on the workload concerns.

Standardization ensures that the deployment is completed safely, reliably, and with repeatability.

Classification makes it easy to view logs of previous deployments and issues that have occurred. You might be able to use that information to expedite rollback and roll-forward operations.

*Contoso's challenge*

- The Contoso Air workload team uses automated build and deployment pipelines, but deployments normally requires manual intervention throughout the operation to change and validate various configuration settings.
- Because of the manual intervention, there are frequent errors in the deployment, making every release a highly stressful and disruptive event for the entire team. The manual intervention also makes it difficult to rollback when a deployment fails.

*Applying the approach and outcomes*

- The team allocates time to automate the configuration changes as part of the deployment, and to integrate the added functionality into the existing deployment pipelines.
- The configuration settings associated with each environment are externalized to respective JSON files which are saved to source control for additional traceability. Settings that are considered secrets are saved to secret vault stores, which are allocated to each environment as well.
- All changes are now logged during the deployment, achieving full traceability to assist with troubleshooting efforts and audits. The team also adds automated tests to validate the configuration changes to the pipeline.
- Next, the team will work on fully automating rollbacks to further optimize processes.
- As a result of the new automation, deployments have been more reliable and predictable, and team morale has risen as well.

## Deploy often

**Deploy small incremental updates at a regular cadence.**

Using this approach will help keep user stories and work items manageable from a project management standpoint and reduce the risk of large-scale issues when deployments fail.

*Contoso's challenge*

- The team's deployment processes historically have been to do major releases every three to four months. This practice makes it difficult to validate the release. The team has also had difficulty troubleshooting issues with so many moving parts.
- Problematic releases that require mid-release hot-fixes or must be rolled back and abandoned have occurred several times.
- Releases are highly stressful and have been treated as "all hands on deck" situations, which has been negatively impacting team morale.

*Applying the approach and outcomes*

- After the latest problematic release, stakeholders asked the team to come up with a better approach to deployments. The team decided to change their practices to favor frequent, small changes. They will limit the scope of each release to one or (at most) a few related changes 
that are thoroughly tested as the build is promoted across the lower environments.
- As a result, the releases have become much more efficient, and quality has increased. The releases are easier to validate and issues are simpler to troubleshoot.
- Having a regular cadence of predictable releases has helped restore the confidence and morale of the team. Users are benefiting as well. With higher release quality, they see less disruption and get access to new features much sooner.

## Use a progressive exposure approach

**Roll out updates gradually, with due diligence. Use deployment models that give you the control to progressively increase the number of instances and customers until the update is safely adopted by all.**

Test each update in a controlled manner so that issues are fixed early in production. Avoid rolling out a faulty update that impacts your entire customer base.

Test whether the update is backward and forward compatible.

*Contoso's challenge*

- The team is seeing great benefits from switching their approach to make smaller releases. They are dedicating less time now to the releases and feel energized to continue down the path of making additional operational excellence improvements.
- As they experiment with new features, some of the changes have not been well received by users or have caused an increase in support calls due to the steep learning curve they bring along.
- They wonder how they can continue innovating their applications to maximize their user’s productivity, while still minimizing the impact of releasing features that may not be as popular or easy to use.

*Applying the approach and outcomes*

- They decided to implement a feature release model that exposes new features to users incrementally, using Feature Flags.
- During the planning stages for new features, a criterion is defined to select which users will be exposed to the feature first. A small group of users is selected to receive the new feature first. Depending on user feedback, the feature is deployed to successively larger groups until the entire user population is running the new version. As more users are exposed to the new features, the support team is documenting the outcome of the support cases to share internally and potentially populate the external FAQ.