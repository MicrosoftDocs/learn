An *application SLA* defines the SLA requirements for a specific application. This term typically refers to an application that *you* build on Azure.

Tailwind Traders runs an application that it built on Azure called "Special Orders." The application tracks special orders that customers have placed in the company's retail stores. A special order includes an item and any customizations the customer needs. For example, a folding door might include customizations such as dimension and hinge placement. Because customizations typically require special handling, the customized item needs to be ordered from the supplier when a customer needs it.

There are many design decisions you can make to improve the availability and resiliency of the applications and services you build on Azure. These decisions extend beyond just the SLA for a specific service. In this part, you'll explore a few of these considerations.

A good place to start is to have a discussion with your team about how important the availability of each application is to your business. The following sections cover a few factors that Tailwind Traders might consider.

## Business impact

If the Special Orders application goes down, what would the business impact be? In this case, customers can't place new orders through the store and staff can't check the status of existing orders. Customers will either need to try again later or possibly go to a competitor.

## Effect on other business operations

The Special Orders application doesn't affect other operations. So, the majority of the Tailwind Traders business will continue to function normally if the Special Orders application went down.

## Usage patterns

*Usage patterns* define when and how users access your application.

One question to consider is whether the availability requirement differs between critical and non-critical time periods. For example, a tax-filing application can't fail during a filing deadline.

For Tailwind Traders, retail stores aren't open 24 hours a day, so if the application were down in the middle of the night, the impact would be minimal. However, because Tailwind Traders has retail locations all over the world, it will need to ensure that each location has access to the service during its retail hours.

## What does the team decide?

Let's say that Tailwind Traders decides that an SLA of 99.9 percent is acceptable for the Special Orders application. This SLA gives the company an estimated downtime of 10.1 minutes per week. But how will it ensure that its technology choices support its application SLA?

In the next part, you'll see how the team maps its application requirements to specific Azure services. You'll learn about some of the techniques you can use to help ensure that your technology choices meet your application SLA.
