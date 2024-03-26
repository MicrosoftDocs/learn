| :::image type="icon" source="../media/goal.svg"::: Build a team culture that has awareness of budget, expenses, reporting, and cost tracking. |
| :----------------------------------------------------------------------------------------------------------------------------------------- |

Cost optimization is conducted at various levels of the organization. It's important to understand how your workload is aligned with organizational goals and FinOps practices. A view into the business units, resource organization, and centralized audit policies allows you to apply a standardized financial system and approach to your workload.

**Example scenario**

Contoso organizes and hosts trade shows. Contoso sees an opportunity to gain efficiencies with their ticket sales process for trade shows by developing a mobile app in-house. The scenarios below follow the development process from ideation through implementation, focusing on cost optimization concerns. The mobile app is a web app written in .NET that is hosted on Azure App Service infrastructure and uses Azure SQL Database for its database.

## Develop a cost model

**Develop a cost model. This fundamental exercise is a prerequisite to setting up a financial tracking system.**

A cost model helps segment expenses and estimate and forecast the total cost of ownership, including infrastructure, support, and implementation. It enables you to identify cost drivers early and predict how usage growth or shrinkage will affect overall revenue and spending in your projected business model for the workload.

*Contoso's challenge*

- Going into the ideation phase, the workload team cannot predict what the total cost of ownership for delivering an experience like this might be, especially as a ticketing system usually deals with burst demand. They know they want to start small and grow over time, but they don't know how to model this to predict the cost of an incremental approach to building and maintaining the workload. 
- Without these initial estimates, it will be hard to get initial funding for the project and predict long term funding needs.

*Applying the approach and outcomes*

- The workload team spends some time to model estimated costs in various scenarios: they know the types of resources that will be needed to build the workload and they look at different configurations that could support varying load patterns to understand what their Azure costs may look like initially and over time.
- They use the rough estimated infrastructure costs, combined with estimates for team expenditures and revenue from the offering to build a cost model.
- This model then allows them to start predicting cost, and understand how costs will increase as usage increases over time. They know they can refine the model as architectural and operational decisions are decided to increase its predictive power.

---

## Estimate realistic budgets

**Estimate realistic budgets that cover all non-negotiable functional and nonfunctional requirements, personnel and training costs, and processes that provide for anticipated growth.**

You'll be able to set financial boundaries and establish ways to check your spending against the allocated budget. You'll also get notifications when certain thresholds are exceeded, which prevents overspending at the tenant scope, resource scope, and other scopes that are applied to the budget.

*Contoso's challenge*

- In this scenario, the app is in the design phase and initial resource SKUs have been determined.
- Contoso needs to allocate funding to the mobile ticketing workload.
- The workload can't be allowed to run with a blank check. A realistic budget needs to be determined for the workload because having a pre-allocation shortfall could put the workload timeline and success in jeopardy, and over-allocating can lead to unnecessary up-front expenditures that don't align with the short term needs of the workload.

*Applying the approach and outcomes*

- As the cost model is refined with more precise numbers, the team provides stakeholders with a budget that is estimated with a high degree of confidence and can be defended.
- With a budget in place, the workload architect can start designing against financial constraints. As more is learned about the implementation and the operations necessary, the workload team expects to need to renegotiate a bit.
- They want a small buffer, but ultimately will be driving toward fiscal responsibility by adhering to the budget allocation.

---

## Encourage upstream communication

**Encourage upstream communication from architects to application owners.**

Costs are reduced when you act on feedback, which should be considered as meaningful as numeric data. You'll empower employees by using their input to drive realistic design changes and business strategies.

*Contoso's challenge*

- Contoso's mobile ticketing workload has been successfully implemented and is in production.
- After analyzing the usage patterns over time, the workload team members find that the implementation isn't really as optimized for cost efficiency as it could be.
- Since project management and finance seems pleased with the workload's success so far, they don't know if they should say anything.

*Applying the approach and outcomes*

- The workload team is encouraged to "spend it like it's theirs" and as such are empowered to speak up to product management when they see alternative approaches to the current design that can address the functional requirements of the application without sacrificing security, reliability or performance, but in a more cost efficient way.
- The workload team therefore brings their findings to stakeholders and talks over what the design change pros and cons would be.
- The design changes are approved and the cost savings are realized.
