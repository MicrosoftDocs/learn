One of the more compelling features of moving your app to the cloud is the ability to grow or shrink your compute power and availability based on what you need. If you find your users are using your app more regularly or intensively or your user base is growing and your application resources are struggling to keep up, adding more compute power is a matter of bumping up the tier you're in. You also can scale compute resources you use based on demand. Perhaps you're doing a large event and need to ensure your application can handle a spike in traffic but for a limited time. Azure's scaling features have you covered.

## Scale up

When onboarding to Azure, you have the option of choosing between three pricing and compute tiers.

### Dev / Test

This tier is the least expensive but can be adequate for an initial onboard while you're testing and building out features. You can start here as long as the tier provides the features you need (for example, in this tier, you can't use custom domains or SSL).

### Production

As the name implies, this tier provides the features and compute power you'll most likely need for most production workloads. Even the least expensive tier supports custom domains, SSL, and autoscale. The various options under this category provide more RAM, disk storage or [ACUs](/azure/virtual-machines/acu) (Azure Compute Units).

### Isolation

While the most costly, this tier provides network isolation and more advanced scaling options. This option will most likely appeal to those application developers that need the highest level of security and the most control over their environment.

For those applications that have variable usage or variability in growth, using Azure's cloud to help manage that variability can save an enormous amount of time in build outs, reduce wasted compute power, and provide a much better user experience in terms of availability and application responsiveness.

## Scale out

Anticipating demand can be tricky even for the best planners. There have been numerous examples of sites going down due to a misaligned anticipation of demand. It also can be frustrating to pay for resources that sit unused in times of low demand. The Scale Out feature of Azure's app service plan attempts to address that by scaling resources based on demand.

You can create "rules" that determine when your app scales out and in. Metrics include things like when the CPU Percentage reaches a certain number, disk queue length, socket count of inbound/outbound requests, and memory percentage among others. You can create multiple scale conditions that scale out to a set instance count and set multiple rules per scale condition. This gives you an enormous amount of power to control how your application performs under load and modest conditions.

Unless you have this data based on your current implementation, spending time gathering some data to see how your application performs under "normal" conditions may help you create rules for those scenarios when you expect more demand.

## Always On

Between scaling up (more sustained needs) and scaling out (on-demand needs), you can ensure your application provides the performance and availability your users need and want.
