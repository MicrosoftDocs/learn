| :::image type="icon" source="../media/goal.svg"::: Reach your desired state of deployment with predictability. |
| :----------------------------------------------------------------------------------------------------------------------------- |

Build a workload supply chain that helps keep all your environments predictable, whether it's apps, data, configurations, or hosting platforms. Your deployment process should be automated, testable, trackable, and easy to monitor. Think modular and flexible, not one big, clunky end-to-end setup. The goal isn't necessarily to go faster. It's about being consistent and making sure everything is clear and repeatable every time you run it.

The workload team owns their part of the supply chain and is responsible for keeping it running smoothly.

**Example scenario**

Contoso Manufacturing built a Java app to help monitor and improve their manufacturing processes. They recently moved the workload to Azure, and it's now running on Azure Spring Apps, Azure Database for MySQL, and Azure IoT Hub.

## Deploy infrastructure through code

**Use infrastructure as code (IaC) to define the repeatable aspects of the supply chain that are production ready. Prefer declarative approaches over imperative methods.**

Declarative IaC tools are built to make automation and reuse easy. They let you shift infrastructure setup from individuals to tools, so actions get done the same way every time, with fewer mistakes.

Fewer technology options also reduce variance in tooling, make it easier to see configuration drift, and simplify maintenance. If you pick tools that match your team's existing skills, it's easier for everyone to get on board.

*Contoso's challenge*

- When the app was running on-premises, the team used a mix of scripts and manual steps to set up infrastructure and deploy across environments. When they started moving things to Azure, they tweaked those existing imperative scripts to work with the new setup. They used this approach so they could reuse the existing automation codebase and because they weren't very familiar with Azure or IaC tools like Bicep yet.

- As the migration moved along and the team got more comfortable with Azure, they realized that switching to an IaC approach with Bicep would be a much better long-term move.

*Applying the approach and outcomes*

- The team didn't have deep Azure or IaC experience in-house, so they brought in some seasoned contractors to help migrate and improve the deployment scripts. These contractors worked side-by-side with the development team during the early phases and shared their knowledge along the way.

- The resulting Bicep-based implementation is a much more reliable, manageable, and efficient way to set up infrastructure in Azure. The code is now more readable and maintainable, and has great tooling support in Visual Studio Code. It's also fully idempotent and simplifies state management, which they were never able to fully accomplish with the previous imperative version. 

## Treat your IaC the same as your application code

**Use strong IaC practices. Modularize, but don't overdo it, and skip the overly complex or low-value custom setups. Use a layered approach that reflects how things change over time. The idea is to keep the base layers stable, while the top layers can change as needed.**

**Deployment pieces like app binaries, IaC templates, and parameters are all part of your attack surface. So they need to be treated with care. Make sure they're safe by using secret management, access controls, and other principles of the Security pillar.**

Treat deployment artifacts with the same care that you give your actual application code. Peer reviews and testing help give you confidence in deployment.

Using a layered approach also makes things easier to manage and helps define who's responsible for what.

And don't forget security. Adding the right controls to artifacts helps keep your system safer and more reliable during deployment.

*Contoso's challenge*

- At the start of the migration effort, the project had a generous budget, so the team brought in some experienced contractors who delivered high-quality work quickly. They worked out of a separate repo during development, but unlike the main app repo, the new one hasn't been regularly checked for security.

- The team is gearing up to roll out a major redesign, and the deployment code needs a lot of updates. Development resources are scarce, so two interns have been handling the latest changes. When one of the senior developers jumped in to help, they found several commits that aren't on par the team's standards, including some hardcoded secrets like API keys right in the code.

*Applying the approach and outcomes*

- The team decides to move the build and deployment codebase into the same repo as the main app code and start treating it with the same level of care. Before they make the first commit, they clean the code up to meet team standards. They remove hardcoded secrets and make sure all the usual quality checks and tools are in place.

- As a result, the team has secured this section of the codebase while increasing the code quality. From here on out, any changes will follow the same standards and use the same tools as the rest of the app code, including peer reviews and automated checks for quality and security.

## Standardize deployments on a single manifest

**Create a shared deployment manifest that works across all environments. Use it as the go-to setup for new projects, updates, or disaster recovery.**

This approach saves you the hassle of maintaining multiple assets. And if problems occur, recovery is easy because you already have a reliable, proven manifest ready to go instead of scrambling to build a proper environment.

*Contoso's challenge*

- Contoso Manufacturing has a fully automated pipeline that handles deploying infrastructure, app code, and configuration changes across both development and production. The app is set up to stay up and running in one region, and most components don't store data, except for the MySQL database. That database is backed up based on the usual recovery time objective (RTO) and recovery point objective (RPO) rules. And the backups get copied to another region just in case.

- If there's a major outage in the primary region, the team plans to build a new environment to host the app in the backup region. But during a recent diaster recovery drill, the deployment scripts hit a wall. Some resources weren't available and a few service limits got in the way, so the environment couldn't be recreated as planned.

*Applying the approach and outcomes*

- The team works around the problems in the secondary region by swapping out some resources for similar ones that are available in both places. And they make a few settings flexible so they could use valid alternatives if needed.

- After running through the exercise, they're feeling a lot more confident about bouncing back from major infrastructure failures.
