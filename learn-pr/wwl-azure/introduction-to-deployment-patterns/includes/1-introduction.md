This module introduces deployment patterns and explains microservices architecture to help improve the deployment cycle and examine classical and modern deployment patterns.

Continuous Delivery is an extension of Continuous Integration. It's all about getting changes to customers quickly and using sustainable methods.

Continuous Delivery goes further, and changes that pass through production pipelines are released to customers.

Continuous Delivery is more than release management.

Continuous Delivery is all about the process, the people, and the tools that you need to make sure that you can deliver your software on demand.

Deployment is only one step within the Continuous Delivery process. To deploy on-demand or multiple times a day, all the prerequisites need to be in place.

For example:

## Testing strategy

Your testing strategy should be in place. If you need to run many manual tests to validate your software, it is a bottleneck to delivering on-demand.

## Coding practices

If your software isn't written in a safe and maintainable manner, the chances are that you can't maintain a high release cadence.

When your software is complex because of a large amount of technical Debt, it's hard to change the code quickly and reliably.

Writing high-quality software and high-quality tests are an essential part of Continuous Delivery.

## Architecture

The architecture of your application is always significant. But when implementing Continuous Delivery, it's maybe even more so.

If your software is a monolith with many tight coupling between the various components, it's challenging to deliver your software continuously.

Every part that is changed might impact other parts that didn't change. Automated tests can track many these unexpected dependencies, but it's still hard.

There's also the time aspect when working with different teams. When Team A relies on the service of Team B, Team A can't deliver until Team B is done. It introduces another constraint on delivery.

Continuous Delivery for large software products is complex.

For smaller parts, it's easier. So, breaking up your software into smaller, independent pieces is a good solution in many cases.

One approach to solving these issues is to implement microservices.

Continuous Integration is one of the key pillars of DevOps.

Once you have your code in a version control system, you need an automated way of integrating the code on an ongoing basis.

Azure Pipelines can be used to create a fully featured cross-platform CI and CD service.

It works with your preferred Git provider and can deploy to most major cloud services, including Azure.

This module details continuous integration practice and the pillars for implementing it in the development lifecycle, its benefits, and properties.

## Learning objectives

After completing this module, students and professionals can:

 -  Describe deployment patterns.
 -  Explain microservices architecture.
 -  Understand classical and modern deployment patterns.
 -  Plan and design your architecture.

## Prerequisites

 -  Understanding of what DevOps is and its concepts.
 -  Familiarity with version control principles is helpful but isn't necessary.
 -  Beneficial to have experience in an organization that delivers software.
