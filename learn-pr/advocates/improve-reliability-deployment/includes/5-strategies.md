DevOps practices involve frequent release cycles that benefit organizations and their end users in many ways. Because individual deployments are smaller, they're faster and less stressful, but things can still go wrong. To reduce the possibility of problems, you need to adopt a deployment strategy that best suits your organization's needs.

You already know about the "epic deployment" approach, which some refer to as the "big bang" strategy. You know this method doesn't work well for modern applications. There are a number of other deployment strategies that have become popular in the context of modern ops, and each has its own strengths and weaknesses depending on the situation.

## Rolling deployment strategy

The rolling deployment strategy takes a gradual approach to introducing new versions of code. The new version is phased in over a period of time, gradually increasing the instances of the new code while at the same time decreasing instances of the old. This means the old and new instances will coexist within the organization. For instance, you might upgrade the software on one server, virtual machine, or container at a time.

An advantage of this strategy is that you can monitor the new code in the production environment to ensure that it meets your performance, security, reliability, and other standards before it's widely deployed.

## Blue-green deployment strategy

The blue-green deployment strategy uses two separate environments that are identical to one another. One is a test environment containing the new version of the software, the other is the current production environment. When you're satisfied that the software is working properly and meets your standards, you can perform a complete switch from the current production environment to the new one so that it now handles all of the production traffic.

The blue environment is your current production environment. The green environment is an exact duplicate of it. You first deploy the new version of the software in the green environment, then when you're ready, you route the application traffic from the blue environment to the green, which is now your production environment.

An advantage of this strategy is that you can make the switch almost instantaneously, with no downtime. It's also easy to switch back to blue if a problem occurs after you take the green environment live.

## Canary deployment strategy

The canary deployment strategy combines some elements of the rolling deployment with that of the blue-green deployment. You don't make the switch all at once, but instead deploy the new version into a limited part of the production environment and then gradually shift all the traffic to the new version. The software deploys in incremental steps to a limited number of instances or users until you've verified that it works properly, then rolls out to the rest of the infrastructure.

The name comes from the practice of using canaries in coal mines as an early warning system. In a canary deployment, you can do automated testing and use monitoring and analytics to get an early warning of any problems with the new version within the subset of instances or users. That way, the entire production environment isn't affected.

## Feature flags

The feature flag idea is another strategy that requires slightly more sophistication on the developers' part. Instead of having two separate versions of the same software, an old one and a new one (presumably with new features in it), we ship a version of the software that contains both the old software plus the new changes (features, etc.). The new changes are by default dormant and not visible until the "feature flag" for that change is activated by flipping the flag. That flag can take many forms, including a line in a configuration file, a command-line argument, a special response from an online server the software consults upon startup, and so on.

One strong plus for this approach is the ease at which we can roll back if there's a problem, or the ease in slowly rolling out changes. We don't have to send a new release (with all of those bits) to our servers or our customers, we just need to turn the appropriate flag off or on to downgrade or upgrade them.

## Deployment best practices

Regardless of which deployment strategy you use, there are some best practices that will help you minimize the risk when rolling out new software or a new version of existing software:

- Use proper tools—such as Azure Pipelines—to create a continuous integration and deployment pipeline.

- Integrate automated testing.

- Use communication channels to notify proper parties of the results of the testing; that is, alert teams if deployments fail, encounter problems, and so on.

- Monitor for issues immediately after the deployment.

- Have a plan for rolling back if a new version deployment doesn't pass health checks or work properly.
