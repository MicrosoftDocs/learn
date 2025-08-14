The contraction of "Dev" and "Ops" refers to replacing siloed Development and Operations teams. The idea is to create multidisciplinary teams that work together with shared practices, tools, and accountability for outcomes. Essential DevOps practices include agile planning, continuous integration, continuous delivery, and comprehensive monitoring of applications. DevOps is a continuous journey of improvement, not a destination.

## The business value of DevOps

Organizations implementing DevOps practices typically see measurable improvements across key operational metrics:

- **Deployment frequency**: Increased from infrequent releases to regular, predictable deployments
- **Lead time**: Reduced from extended development cycles to shorter delivery timeframes
- **Mean time to recovery (MTTR)**: Faster incident resolution and system restoration
- **Change failure rate**: Fewer production issues due to improved testing and automation

**Expected benefits include:**

- Reduced time-to-market for new features
- Decreased deployment-related incidents
- Improved developer productivity and satisfaction
- Lower operational costs through automation

:::image type="content" source="../media/devops-cycle-98924900-a8ba6dc4.png" alt-text="Diagram showing the collaborative DevOps cycle with plan, build, continuous integration, deploy, operate, and continuous feedback phases forming a continuous loop.":::

## Understand and calculate your cycle time

Let's start with a fundamental concept about software development using the OODA (Observe, Orient, Decide, Act) loop. Originally designed to keep fighter pilots from being shot out of the sky, the OODA loop is an excellent framework for staying ahead of your competitors in the business world.

**OODA Loop in Practice:**

- **Observe**: Monitor business metrics, market trends, user behavior, and telemetry data
- **Orient**: Analyze options for what you can deliver, possibly through experiments
- **Decide**: Determine what to pursue based on data and business priorities
- **Act**: Deliver working software to real users and collect feedback

**Cycle Time Calculation Exercise:**
Think about your current development process. How long does it take to go from:

1. Code commit → Production deployment?
2. Feature request → Customer feedback?
3. Bug report → Fix in production?

_Example: If it takes 2 weeks to deploy a one-line configuration change, your cycle time is 2 weeks. This becomes your velocity constraint._

:::image type="content" source="../media/devops-road-3eb79373-55826718.png" alt-text="Diagram showing the OODA loop cycle with Observe, Orient, Decide, and Act phases connected in a circular pattern, emphasizing continuous iteration.":::

## Become data-informed, not data-driven

We recommend using data to inform decisions in your next cycle, but avoid becoming paralyzed by analysis. Experience from many organizations suggests that deployments often have varied outcomes:

- **Some deployments** will have negative business results
- **Some deployments** will have positive results
- **Some deployments** will make no measurable difference

**The key principle**: Fail fast on initiatives that don't advance the business and double down on outcomes that support business goals. This approach is often called "pivot or persevere."

**Practical Application:**

- Set up A/B testing for new features
- Define success metrics before deployment
- Establish rollback procedures for failed experiments
- Create feedback loops to measure impact quickly

## Strive for validated learning

How quickly you can fail fast or double down depends on your cycle time - how long that feedback loop takes to complete. The feedback you collect with each cycle should be:

- **Factual**: Based on real user behavior and system metrics
- **Actionable**: Leading to clear next steps and decisions
- **Timely**: Available quickly enough to influence the next iteration

This evidence-based approach is called **validated learning** - making decisions based on empirical evidence rather than assumptions or opinions.

**Example Metrics for Validated Learning:**

- User engagement rates and feature adoption
- System performance and error rates
- Customer satisfaction scores and support tickets
- Business KPIs (revenue, conversion rates, retention)

:::image type="content" source="../media/devops-road-validated-learning-b7c460aa-622f7b18.png" alt-text="Diagram illustrating validated learning cycle showing good, indifferent, and bad outcomes with feedback loops for continuous improvement.":::

## Shorten your cycle time

When you adopt DevOps practices:

- You shorten your cycle time by working in smaller batches.
- Using more automation.
- Hardening your release pipeline.
- Improving your telemetry.
- Deploying more frequently.

:::image type="content" source="../media/devops-road-shorten-cycle-time-360c6a21-d01a6ac6.png" alt-text="Diagram of Validated learning versus deployment frequency. Good, indifferent, and bad cycle.":::

## Optimize validated learning

The more frequently you deploy, the more you can experiment. The more opportunity you have to pivot or persevere and gain validated learning each cycle. This acceleration in validated learning is the value of the improvement. Think of it as the sum of progress that you achieve and the failures that you avoid.

:::image type="content" source="../media/devops-road-optimize-learning-3f77fb52-55675a69.png" alt-text="Diagram of Validated learning versus deployment frequency. Good, indifferent, and bad cycle. Value of improvement metric.":::
