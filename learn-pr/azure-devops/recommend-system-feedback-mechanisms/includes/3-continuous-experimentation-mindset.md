In the era of continuous delivery, we are expected to rapidly deliver software that is stable and performs well. Development teams embrace CI/CD tools to automate their builds, test passes, and deployments, all at an accelerated pace.

Teams rely on various forms of testing to identify all issues before a release hits production. Teams primarily rely on version control systems or configuration files to control feature releases. Once a release is in production, it is basically out in the wild. Without proper controls, rolling back to previous versions becomes a code deployment exercise, requiring engineering expertise and increasing the potential for downtime.

One way to mitigate risk in feature releases is to introduce _feature flags_ (also known as _feature toggles_) into the continuous delivery process. These flags allow features (or any piece of code) to be turned on or off for particular users. Feature flags are a powerful technique that enable teams to modify behavior without changing code.

Software development and operations capabilities set the boundaries for success. The first step to creating a company-wide culture of experimentation is for executives, business planners, developers, and ops, as well as other key stakeholders, to understand how changes in engineering productivity align with business outcomes.

Innovation is the key to success, and success depends on testing hypotheses through experimentation. By adopting a culture of continuous experimentation, you can test features by creating an instrumented minimal viable product rapidly and release to a subset of customers in production for testing. This enables the team to make decisions based on facts and quickly evolve towards the optimal solution.

The following illustrates a typical software delivery timeline:

![A a graphic showing software delivery timelines](../media/3-software-delivery.png)

By including feature flags in the continuous delivery process, teams can more efficiently integrate release, deployment, and operational management into the software development cycle.

Here are some of the benefits of a standard continuous delivery pipeline compared to a similar pipeline that includes feature flags:

| Continuous delivery provides:      | Continuous delivery plus feature flags provides:     |
|------------------------------------|--------------------------------------------|
| Faster software development        | Decoupled rollout from code deployment     |
| Smaller and more frequent releases | Releases with substantially mitigated risk |
| Automated testing                  | Improved customer feedback loop           |
| Reduced development risk           | Percentage rollouts and targeted releases  |
| Better development coordination    | Feature rollbacks without redeploying      |
| Quickly adapt to shifting markets  | Configuration and long-term management     |