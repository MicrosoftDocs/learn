| :::image type="icon" source="../media/goal.svg"::: Put guardrails in place during the deployment process to reduce the impact of errors or unexpected conditions. |
| :----------------------------------------------------------------------------------------------------------------------------- |

During the development cycle, workload artifacts go through many changes as they get implemented and tested and as bugs are fixed.

The deployment process needs to stick to a standard operating procedure. Every change—whether it’s code, configuration, or anything related—should be deployed with the same level of care. The idea is to start using safe practices as early as possible so things stay predictable in production. And if something does slip through to customers, you should be able to roll out a fix fast.

The deployment process must follow a standard operating procedure. Every change, whether it’s code, configuration, or related components, should be deployed with the same level of care. The idea is to start using safe practices as early as possible so production is predictable. And if problems slip through to customers, you should be able to roll out a fix fast.

**Example scenario**

Contoso Air has developed a web application that allows customer to book flights directly. The app has been running in production for over a year. 

The app is fully deployed in Azure and is built on Azure App Service, Azure Cosmos DB, Azure Functions, Azure Logic Apps, and Azure Service Bus. 

## Codify automated deployment standards

**Standardize how changes get deployed by using automated deployment processes, like pipelines. All environments must use pipelines. Ensure that assets and their versions are clearly labeled by environment so they’re easy to track and identify.**

Consistent deployment methods reduce problems caused by process errors and variance, so you can focus more on the actual workload. When everything’s standardized, deployments become safer, more reliable, and repeatable.

Classification makes it easy to view logs of previous deployments and find problems that came up. That information can help speed up recovery, whether you’re rolling back or moving forward with a fix.

*Contoso's challenge*

- The Contoso Air workload team uses automated build and deployment pipelines, but they usually have to step in manually during the process to tweak and check different configuration settings.

- Because of all that manual work, deployment errors happen often. Every release is a stressful, disruptive event for the whole team. And when a deployment fails, rolling back isn’t easy either.

*Applying the approach and outcomes*

- The team set aside time to automate the configuration changes as part of the deployment and to add the new functionality into the existing deployment pipelines.

- Configuration settings for each environment are now stored in separate JSON files, which are saved in source control so they’re easy to track. Any settings that are considered secrets are stored in secret vaults, with one set up for each environment.

- Every change is now logged during deployment, providing full traceability to help with troubleshooting and audits. The team also adds automated tests to the pipeline to check that configuration changes are working as expected.
- Next, the team plans to fully automate rollbacks to make the process even smoother.
- As a result of the new automation, deployments have been more reliable and predictable, and team morale has gone up too.

## Deploy often

**Deploy small, incremental updates at a regular cadence.**

Doing this approach makes tasks and user stories easier to manage and helps avoid large problems if deployments fail.

*Contoso's challenge*

- The team used to do major releases every three to four months, which made it tough to validate everything properly. With so many moving parts, troubleshooting was a real challenge.

- There were several rough releases that needed hot-fixes midstream or had to be rolled back entirely.
- Each release turned into a situation that required everyone's help. They were very stressful and draining for the whole team, which really took a toll on morale.

*Applying the approach and outcomes*

- After the latest problematic release, stakeholders asked the team to rethink how they handle deployments. The team decided to shift gears and go with smaller, more frequent changes. Each release will now focus on just one, or a few closely related, updates that get thoroughly tested as they move through the lower environments.

- This change has made releases more efficient, and quality has increased. It’s easier to validate each release, and tracking down problems is a lot simpler.
- A steady rhythm of predictable releases has really helped restore team morale and confidence. Users are seeing the benefits too, with fewer disruptions and quicker access to new features.

## Use a progressive exposure approach

**Roll out updates gradually and with care. Use deployment models that let you slowly ramp up starting with just a few instances or customers, so you can make sure everything’s working smoothly before going all in.**

Test each update in a controlled way so you can catch and fix problems early in production. You can avoid pushing out a faulty update that could affect all your customers.

Test whether the update is backward and forward compatible to see if it works well with other versions.

*Contoso's challenge*

- The team is seeing some great benefits from switching to smaller releases. They’re spending less time managing deployments and feeling motivated to keep pushing for improvements in how they run processes.

- But as they try out new features, not everything has landed well. Some changes have confused users or led to more support calls because of steep learning curves.
- Now they’re thinking about how to keep innovating in ways that really boost user productivity, without causing too much disruption when a new feature might not be as popular or easy to use.

*Applying the approach and outcomes*

- The team decided to roll out new features gradually by using feature flags, so users get access to new features incrementally.

- During planning, they define who should see the feature first. Usually a small group of users gets early access. Based on how that group responds, the team expands the rollout to more users until everyone’s on the new version. As more people start using the features, the support team tracks what comes up in support cases and shares those insights internally, and possibly in the external FAQ too.
