DevOps practices involve frequent release cycles that benefit organizations and their end users in many ways. Because individual deployments are smaller, they're faster and less stressful, but things can still go wrong. To reduce the possibility of problems, you need to adopt a deployment strategy that best suits your organization's needs.

You already know about the "epic deployment" approach, which some refer to as the "big bang" strategy. You know this method doesn't work well for modern applications. There are a number of other deployment strategies that have become popular in the context of modern ops, and each has its own strengths and weaknesses depending on the situation.

## Rolling deployment strategy

The rolling deployment strategy takes a gradual approach to introducing new versions of code. The new version is phased in over a period of time, gradually increasing the instances of the new code while decreasing instances of the old. As a result, old and new instances coexist across the deployment target during the rollout. For example, you might upgrade the software on one server, virtual machine, or container at a time.

An advantage of this strategy is that you can monitor the new code in the production environment to ensure that it meets your performance, security, reliability, and other standards before it's widely deployed.

## Blue-green deployment strategy

The blue-green deployment strategy uses two separate environments that are kept as similar as possible and are both capable of serving production traffic. One environment handles the current production load while the other hosts the new version of the software so you can validate it before shifting traffic. When you're satisfied that the new version is healthy, you can switch traffic all at once or gradually increase the share of traffic going to the new environment while you monitor the results.

The blue environment is the one currently serving production traffic. The green environment is its parallel counterpart. You first deploy the new version of the software to green, validate it, and then route production traffic from blue to green. After the cutover, the roles can switch: green becomes the live environment, and blue can be prepared for the next release.

An advantage of this strategy is that you can switch quickly, often with little or no downtime. It's also relatively easy to direct traffic back to the previous environment if a problem occurs after the new environment goes live.

## Canary deployment strategy

The canary deployment strategy combines some elements of the rolling deployment with that of the blue-green deployment. You don't make the switch all at once, but instead deploy the new version into a limited part of the production environment and then gradually shift all the traffic to the new version. The software deploys in incremental steps to a limited number of instances or users until you've verified that it works properly, then rolls out to the rest of the infrastructure.

The name comes from the practice of using canaries in coal mines as an early warning system. In a canary deployment, you can do automated testing and use monitoring and analytics to get an early warning of any problems with the new version within the subset of instances or users. That way, the entire production environment isn't affected.

## Feature flags

The feature flag idea is another strategy that requires slightly more sophistication on the developers' part. Instead of having two separate versions of the same software (an old one and a new one with new features), you ship a single version that contains the old behavior plus the new changes. The new changes are dormant by default and aren't visible until the corresponding "feature flag" is activated. A flag can take many forms, including a line in a configuration file, a command-line argument, or a value retrieved from a remote configuration service and evaluated at runtime.

A strong advantage of this approach is the ease of rolling back if a problem occurs and the ease of slowly rolling out changes. In many cases, you don't need to ship a new release to expose or hide the feature. You can simply turn the appropriate flag off or on and let the running application react to the new setting.

On Azure, the **feature management** capability of [Azure App Configuration](/azure/azure-app-configuration/feature-management-overview?azure-portal=true) provides a managed feature-flag store that your applications can read from at runtime, with SDK support for .NET, Java, Python, JavaScript, and Go.

## Ring-based deployments

A ring-based deployment is a structured form of progressive rollout used widely inside Microsoft and Azure. New code is released to a sequence of "rings". For example, an internal or dogfood ring, an early adopter ring, a broad deployment ring, and finally a general availability ring. Each ring is larger than the previous one, and the deployment only advances to the next ring after health signals from the current ring meet defined criteria. Ring-based deployments combine the gradual exposure of canary deployments with explicit, named audiences and approval gates between rings.

## Progressive delivery

The strategies above (canary, ring-based, and feature flags) are often grouped under the umbrella term **progressive delivery**. The unifying idea is that a release is exposed to a controlled, growing audience, instrumented with health and business metrics, and either advanced or rolled back automatically based on those signals. Progressive delivery is increasingly the default model for high-reliability cloud services because it limits the blast radius of any individual change.

## Deployment best practices

Regardless of which deployment strategy you use, some best practices help you minimize risk when rolling out new software or a new version of existing software:

- Use proper tools, such as Azure Pipelines or GitHub Actions, to create a continuous integration and deployment pipeline.

- Integrate automated testing.

- Use communication channels to notify the right parties of test results. For example, alert teams when deployments fail or encounter problems.

- Monitor for issues immediately after the deployment.

- Have a plan for rolling back if a new version doesn't pass health checks or work properly.
