
When you have a clear view of the different stages you'll deploy, you need to think about when you want to deploy to these stages.

As we mentioned in the introduction, Continuous Delivery is about deploying multiple times a day and can deploy on-demand.

When we define our cadence, questions that we should ask ourselves are:

 -  Do we want to deploy our application?
 -  Do we want to deploy multiple times a day?
 -  Can we deploy to a stage? Is it used?

For example, a tester testing an application during the day might not want to deploy a new version of the app during the test phase.

Another example is when your application incurs downtime, you don't want to deploy when users use the application.

The frequency of deployment, or cadence, differs from stage to stage.

A typical scenario we often see is continuous deployment during the development stage.

Every new change ends up there once it's completed and builds.

Deploying to the next phase doesn't always occur multiple times but only at night.

When designing your release strategy, choose your triggers carefully and consider the required release cadence.

Some things we need to take into consideration are:

 -  What is your target environment?
 -  Does one team use it, or do multiple teams use it?
     -  If a single team uses it, you can deploy it frequently. Otherwise, it would be best if you were a bit more careful.
 -  Who are the users? Do they want a new version multiple times a day?
 -  How long does it take to deploy?
 -  Is there downtime? What happens to performance? Are users affected?
