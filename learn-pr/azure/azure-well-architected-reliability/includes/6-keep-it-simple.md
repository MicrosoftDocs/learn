| :::image type="icon" source="../media/goal.svg"::: Don't make the architecture design, application code, and operations too complex. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

It's often what you take away rather than what you add that makes solutions more reliable. Keeping things simple helps avoid control problems, cuts down on inefficiencies, and prevents misconfigurations or unexpected problems. But oversimplification can introduce single points of failure. It's all about finding a balance.

**Example scenario**

Contoso Travel is buying and integrating a small startup company that has a popular web-based travel app. The app is popular because it gets great deals with hotels and airlines and uses social media for targeted marketing.

The startup's app was built by using Node.js and runs on VMs hosted both in their datacenter and on Amazon Web Services (AWS).

## Keep workload components simple

**Only add components to your setup if they help you reach your business goals. Focus on the essentials.**

Designing for business requirements can lead to a straightforward solution that's easy to run and manage. Avoid having too many critical parts, because each one can be a potential failure point.

*Contoso's challenge*

- A component of the new app lets users give feedback on the website after they make a reservation. Most users skip this feature. Instead, they prefer using the company's social media for feedback, which is used more often for marketing and user interaction.

*Applying the approach and outcomes*

- As part of the initial release of the Contoso Travel-branded version of the app, the team removes the website feedback feature.

- A smaller codebase means lower maintenance and operation costs. And it doesn't affect the business requirements.

## Standardize your software development life cycle

**Set clear standards for coding, deployment, and processes, and document them. Use automated checks to enforce these standards.**

Standards help keep things consistent and reduce human errors. Using standard naming conventions and code style guides can maintain quality and make it easy to identify assets for troubleshooting.

*Contoso's challenge*

- The startup's development team lacks defined standards. They use overlapping libraries, don't enforce coding styles, and their release pipelines lack formal, automated testing gates.

- The Contoso team finds the new codebase hard to maintain because of inconsistent styles and library usage.
- There are a lot of problems after major updates in production. Sometimes the team needs to roll back the updates or apply hot-fixes during deployment. Because of these frequent problems, the entire teams needs to help whenever they release updates to production. To make matters worse, these problems are hurting Contoso's reputation and giving users a bad experience.

*Applying the approach and outcomes*

- The team that supports the new app works to enforce coding styles, standardize libraries and design patterns, and formalize release gates on automated tests.

- They document all new tools, design patterns, and styles so that it's easier to maintain the workload and spot deviations during code reviews.

## Minimize your operations and development burden

**Use platform-provided features and prebuilt assets to meet business targets effectively.**

This approach saves development time and relies on proven practices used in similar projects.

*Contoso's challenge*

- For the initial release of the Contoso Travel-branded app, the team moves the Node.js solution from VMs to Azure App Service to benefit from its built-in reliability features.

- The VM version has a lot of custom code for instrumentation.

*Applying the approach and outcomes*

- During the initial migration to App Service, the team removes all custom instrumentation code by using Application Insights autoinstrumentation.

- They also take advantage of other App Service functions like autoscaling, Azure Key Vault integration, and zonal redundancy.