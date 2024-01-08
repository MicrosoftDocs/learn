| :::image type="icon" source="../media/goal.svg"::: Avoid overengineering the architecture design, application code, and operations. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

It's often what you remove rather than what you add that leads to the most reliable solutions. Simplicity reduces the surface area for control, minimizing inefficiencies and potential misconfigurations or unexpected interactions. On the other hand, oversimplification can introduce single points of failure. Maintain a balanced approach.

**Example scenario**

Contoso Travel is buying and integrating a small startup company with a popular web-based travel app. The app’s popularity is due to its business model of negotiating deep discounts with hotel chains and airlines, and the use of social media to do intense and highly targeted marketing campaigns.

The existing version of the startup product was developed in nodejs, and is running on VMs that are hosted between the on-premises data center, and AWS.

## Minimize the workload components

**Add components to your architecture only if they help you achieve target business values. Keep the critical path lean.**

Designing for business requirements can lead to a straightforward solution that's easy to implement and manage. Avoid having too many critical components, because each one is a significant point of failure.

*Contoso's challenge*

- One of the components of the newly acquired application facilitates collecting feedback from the users directly on the website after they’ve made a reservation. The feature is rarely used because most users just skip over it. There’s a strong feedback loop mechanism from users that works through the company’s social media accounts, which is heavily used for marketing user interaction. This mechanism is used significantly more frequently than the website's feedback function.

*Applying the approach and outcomes*

- As part of the initial release of the Contoso Travel-branded version of the app, the team decides to remove the website feedback component of the workload. 
- A smaller codebase lowers the cost of maintenance and operations. And, in this case, there’s no impact to the business requirements.

## Standardize your software development lifecycle

**Establish standards in code implementation, deployment, and processes, and document them. Identify opportunities to enforce those standards by using automated validations.**

Standards provide consistency and minimize human errors. Approaches like standard naming conventions and code style guides can help you maintain quality and make assets easy to identify during troubleshooting.

*Contoso's challenge*

- The development team from the startup doesn’t have many development and process standards defined. There are a number of libraries being used that overlap in functionality, coding styles aren’t enforced, and the release pipelines lack formal release gates that use automated testing.
- The Contoso workload team realizes the cost of maintenance of the new codebase is too high because  of the lack of consistency in styles and the inconsistent use libraries and design patterns.
- There are frequent incidents after major updates in production, sometimes requiring rollbacks of the updates or mid-deployment hot-fixes. The frequency of these types of deployment issues forces the team to use an all-hands-on-deck support model when releasing updates to production. To make matters worse, the frequent issues are negatively impacting Contoso's reputation through a poor user experience.

*Applying the approach and outcomes*

- The team taking over support of the new app makes an effort to achieve greater consistency by enforcing coding styles, standardizing on a common set of libraries and design patterns, and formalizing the use of release gates based on automated tests.
- While these changes are being implemented, the workload team adheres to their standard documentation requirements. All of the new tools, design patterns, and styles being adopted are thoroughly documented, allowing the team to understand and maintain the workload more efficiently going forward. The team can now more easily identify deviations in the standards when performing code reviews.

## Minimize your operations and development burden

**Take advantage of platform-provided features and prebuilt assets that can help you effectively meet business targets.**

This approach minimizes development time. It also enables you to rely on tried and tested practices that have been used with similar workloads.

*Contoso's challenge*

- For the initial release under the Contoso Travel branding, the nodejs solution will be migrated from VMs to App Services, to take advantage of the many native reliability features the service provides. 
- The version deployed on VMs contains a significant amount of custom code needed for instrumentation.

*Applying the approach and outcomes*

- During the initial migration to App Services, the team was able to remove all custom instrumentation code by implementing App Insights autoinstrumentation in App Services.
- The team is also able to take advantage of several other native App Service functions like autoscaling, Key Vault integration, and zonal redundancy.