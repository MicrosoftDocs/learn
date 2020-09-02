## What's DevOps

DevOps is a relatively new set of practices that improves collaboration between the development team (the Devs) and the operations team (the Ops), to achieve higher software quality and a shorter release cycle.

The cloud in general, and the container-related technologies, make this much easier than it was a few years ago. You could certainly say that it just wasn't possible a close as in year 2000.

Some of the key technologies that make DevOps specially easy today are:

- The cloud
- Microservices
- Containers
- Containers Orchestrators

The cloud is perhaps the maximum expression of "infrastructure as code" and the key enabler for DevOps. You can just create some scripts or a spec file ([ARM template](https://docs.microsoft.com/azure/azure-resource-manager/templates/overview), for example) and in few minutes you can have whatever you need and for as long as you want. Think of this just a moment, you're now waiting for a Kubernetes cluster to be ready, and you'll use it for about an our and then just delete it. And this can be completely free or cost probably less than three dollars. The cloud availability actually lowered the entry barrier for DevOps, that used to require a high capital expenditure, so it's now a viable option for any organization, regardless its size.

Microservices as architectural pattern that splits functionality in small "packages" that can be developed and deployed (and rolled back) independently. In a microservices architecture all services communicate using interface contracts that make it irrelevant the development language, so you can mix languages and technologies to find the best match for each service context.

Containers as a "light" virtualization technology that can isolate each microservice to avoid interferences, version conflicts. Containers also make it very easy to scale-out computing capacity to cope with any load.

Finally, container orchestrators like Kubernetes, allows you to easily manage any amount of containers, with the ability to scale 10x or more in a very short time, and to scale down when the load lowers.

## What's a CI/CD pipeline

You've probably read about CI/CD already, so we'll just brush out the main concepts in a very simple way.

CI, for Continuous Integration, just means that "all" the code is compiled and tested every time it's pushed to a certain branch in the repository. "All code" usually means code from different teams and testing includes both unit and integration testing.

CD, for Continuous Delivery, means that the code is deployed to some environment for further testing. These environments are usually used for manual testing and validation, as well as load testing or whatever is needed for the business.

The "pipeline" part just means that there's a chain of tasks or steps that need to be executed in some order. These can be, for example, building the source code, building the images, publishing packages and images to private repositories, and so on.

## Why DevOps

There are two key reasons here:

- Routinizing the deployment process, ensuring all tests are successfully run and
- Making it easy to experiment on new features and "improvements".

By routinizing the deployment process, getting out a new release becomes something that can be done in an almost continuous way and this is key to deliver value to the business or customer as fast as possible.

The other key idea behind DevOps is to make it easy to apply the [Scientific Method](https://en.wikipedia.org/wiki/Scientific_method) to guide the software development process. The Scientific Method is based on hypothesis, observation, experimentation, measurement and repeating the process. This is a know process to learn effectively.

DevOps aims to shorten the cycle time so it's easy (that is, not expensive) to make experiments and verify an hypothesis by measuring some key values and decide if the results improve on what you expect or not, based on actual measurements and not just vague ideas or a hunch.

What kind of hypothesis are we talking about here? For example, a business hypothesis could be, "If we show this call out in the home page we're going to get higher [conversion](https://en.wikipedia.org/wiki/Conversion_marketing)". A technical hypothesis could be something like "If we change this key component, the e-commerce response time should improve by at least 10%".

Applying DevOps practices is an effective way to improve software quality and learn faster. This also means that getting metrics from your software operation is a key factor in the DevOps mindset.

For more information, see the [DevOps Resource Center](https://docs.microsoft.com/azure/devops/learn/).
