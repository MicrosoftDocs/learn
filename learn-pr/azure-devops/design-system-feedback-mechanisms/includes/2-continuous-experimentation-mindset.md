Copied from ILT

## Continuous experimentation mindset

We are in the era of continuous delivery, where we are expected to quickly deliver software that is stable and performant. We see development teams embracing a suite of continuous integration/delivery tools to automate their testing and QA, all while deploying at an accelerated cadence.

However, no matter how hard we try to mitigate the risk of software delivery, almost all end-user software releases are strictly coupled with some form of code deployment. This means that companies must rely on testing and QA to identify all issues before a release hits production. It also means that companies primarily rely on version control systems or scraped together config files to control feature releases and mitigate risk. Once a release is in production, it is basically out in the wild. Without proper controls, rolling back to previous versions becomes a code deployment exercise, requiring engineering expertise and increasing the potential for downtime.

One way to mitigate risk in feature releases is to introduce feature flags(feature toggles) into the continuous delivery process. These flags allow features (or any code segment) to be turned on or off for particular users. Feature Flags are a powerful technique, allowing teams to modify system behavior without changing code.

In this new reality, software development and operations capabilities set the boundaries for success. The first step to creating a company-wide culture of experimentation is for executives, the business, developers, and ops–and other key stakeholders–to understand how changes in engineering productivity align with business outcomes. Innovation is the key to success, and success depends on hypothesis-testing through experimentation. By adopting a culture of continuous experimentation, features can be tested by creating an instrumented minimal viable product rapidly and release to a subset of customers in production for testing, this enables the team to make fact based decisions and quickly evolve towards an optimal solution.

![A a graphic showing software delivery timelines](../media/2-software-delivery.png)

By using feature flags in the continuous delivery process, teams are able to efficiently integrate release, deployment, and operational management into the software development cycle.

![A a graphic showing continuous delivery timelines](../media/2-continuous-delivery.png)

From their onset, feature flagging platforms have accelerated the progression of DevOps practices. Feature flags have always fit into DevOps practices due to the increased control over the delivery cycle that they offer, but the mitigation of risk and prevention of associated technical debt has brought flagging platforms to the spotlight as quintessentially “DevOps”. These changes alongside the newly offered ability to monitor all changes to a flag via an audit log have widened the reach of the methodology. Simultaneously, these systems deeply supplement the methodology as it currently exists and provide additional use cases and benefits that push the limits of DevOps beyond what was possible before.

## Feature Flags

Satya video on feature flags and a lab on feature flags
