This unit focuses on common SaaS pricing models and packaging strategies.

## Pricing models

When you determine the pricing model for your product, you need to balance the return on value (ROV) for your customers with the cost of goods sold (COGS) to deliver the service. Offering more flexible commercial models for a solution might increase the ROV for customers, but it might also increase the architectural and commercial complexity of the solution and therefore also increase your COGS.

### Consumption-based

The consumption-based model is also called *pay-as-you-go*. As the use of your service increases, your revenue also increases.

From your customers' perspective, minimal upfront investment is required to use your solution, so this model has a low barrier to entry. From your perspective as the service operator, your hosting and management costs increase as your customers' usage and your revenue increase.

These corresponding increases in costs, usage, and revenue make consumption a highly scalable pricing model. Consumption pricing models work especially well when the Azure services used in the solution are also consumption-based.

### Seat-based

When you bill your customers for each user, it's easy to calculate and forecast your revenue stream. Also, assuming that you have fairly consistent usage patterns for each user, revenue increases at the same rate as service adoption, making seat-based pricing a scalable model.

Per-user pricing models are common because of their simplicity to implement in multitenant solutions. Multitenant solutions are shared across all customers and users, while single-tenant solutions give each customer its own installation of the solution.

However, multitenant solutions have several commercial risks, such as different customer consumption patterns resulting in reduced profitability. For example, heavy users of the solution might cost more to serve than light users.

There's also a limit on how much you can earn on each customer. If each customer has only 100 employees, the maximum potential deal for this customer is limited to 100 seats.

A better business approach might be to focus on the value your service provides to customers and tie pricing to this value. In this case, the more customers use the product and the more value they gain, the more revenue they provide.

### Unit-based

In many systems, the number of users isn't the element that has the greatest effect on the overall COGS. For example, in device-oriented solutions, also referred to as the internet of things or IoT, the number of devices often has the greatest impact on COGS. These systems can use a per-unit pricing model that defines what a unit is, such as a device.

## Packaging

An optimal pricing strategy that works well in B2C or B2B for small businesses is packaging. A package is a set of features that are bundled together. SaaS providers can create optimal packages with certain sets of features and overall pricing.

## Contoso scenario

For example, consider how Contoso defines a packaging pricing strategy for their lawyer solution.

Contoso creates three packages, starting from a minimal "Free" plan that allows only one website and doesn't include user behavioral analysis.

The "Basic" plan costs £40 per month and includes more functionality, such as:

- Up to five designs per website. Customers often want to compare different designs and how they perform, or have different designs for special occasions and promotions.
- Up to five external integrations.
- Ability to track and analyze users' behavior on the website and get autosuggestions for improvement.

The "Premium" plan costs £800 per month and has more extensive capabilities than the Basic plan, such as dedicated support service.

![This diagram illustrates the progressive pricing for three Contoso packages that include different functionality, Free, Basic, and Premium.](../media/pricing-packaging.png)

Contoso aligns their pricing to the most valuable features their customers are using within the Contoso SaaS solution.

