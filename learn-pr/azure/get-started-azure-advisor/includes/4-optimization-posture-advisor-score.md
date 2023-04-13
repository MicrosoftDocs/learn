When you reviewed your Advisor recommendations in the last unit, you may have discovered that you have a long list of recommendations for cost, security, reliability, performance, and operational excellence. Do you know which recommendations you should take first, and which will have the greatest impact toward making your workloads well-architected? That's why we created Azure Advisor Score.

## What is  Advisor Score?

Advisor aggregates its findings into a single number – **Advisor Score**.

Advisor Score is a rating of your Azure subscriptions on a scale from 0% to 100%. It's intended to help you understand how well the resources in those subscriptions are optimized, based on our documented best practices. It's also further broken down into five individual category scores, each representing one of the five pillars of Azure Advisor and the Azure Well-Architected Framework.

With just a quick glance, Advisor Score helps you to:

- Understand how well you're following the best practices defined by Advisor and the Well-Architected Framework
- Prioritize which optimizations you should make to maximize your impact
- Track and report on your progress

### How is your Advisor Score calculated?

Advisor displays your category scores and your overall Advisor Score as percentages.

:::image type="content" source="../media/azure-advisor-score-page.png" alt-text="Screenshot showing your Advisor score page." lightbox="../media/azure-advisor-score-page.png":::

- A score of 100% in any category means all your resources, assessed by Advisor, follow the best practices that Advisor recommends.
- By contrast, a score of 0% means that none of your resources, assessed by Advisor, follows Advisor recommendations.

Each of the five categories has a highest potential score of 100%. Your overall Advisor Score is calculated as a sum of each applicable category score, divided by the sum of the highest potential score from all applicable categories. For most subscriptions, that means Advisor adds up the score from each category and divides by 500. But each category score is calculated only if you use resources that are assessed by Advisor.

As an example, for a single subscription, the Advisor Score is the simple mean of all Advisor category scores for your subscription. So, if the Advisor category scores are:

- Cost = 73
- Security = 81
- Reliability = 89
- Operational excellence = 77
- Performance = 100

The Advisor Score would be 0.84 or **84%** as shown in the following equation:

<!-- $$\frac{73 + 81 + 89 + 77 + 100}{5 x 100} = 0.84$$ -->

:::image type="content" source="../media/advisor-equation.png" alt-text="(73 + 81 + 89 + 77 + 100)/(5 x 100) = 0.84" border="false":::

The scores for multiple subscriptions are calculated a bit differently. Each category score is aggregated according to resources consumed by each subscription.

### Scoring methodology

How Advisor calculates your score can be summarized in four steps. At the category level:

1. Advisor calculates the retail cost of impacted resources. These resources are the ones in your subscriptions that have at least one recommendation in Advisor.
1. Advisor calculates the retail cost of assessed resources. These resources are the ones monitored by Advisor, whether they have any recommendations or not.
1. For each recommendation type, Advisor calculates the healthy resource ratio. This ratio is the retail cost of impacted resources divided by the retail cost of assessed resources.
1. Advisor applies three additional weights to the healthy resource ratio in each category:
    - Resources with long-standing recommendations count more against your score.
    - Recommendations with a greater impact estimate are weighted more heavily than recommendations with lower impact.
    - Resources that you postpone or dismiss in Advisor are removed from your score calculation entirely.

> [!IMPORTANT]
> Your Advisor Score gives you an at-a-glance view of how closely the resources in your subscriptions follow our documented well-architected best practices in Advisor. But remember, a 100% score doesn't mean your workloads are perfectly well-architected. Advisor only understands your telemetry, configuration, and usage data, not your broader context. Still, a 100% score will help you go a long way toward achieving your well-architected goals.

## Use Advisor Score to prioritize your workflow

As we've learned, the higher the Advisor Score, the more in line your subscriptions are with Azure best practices. Understanding the different components of Advisor Score helps you to prioritize the actions you take when addressing the issues that are raised by Azure Advisor.

- The **Advisor Score** gives you a baseline for how your subscriptions are doing overall. You can also see the historical trends to understand and track your progress.
- The **Score by category** tells you how each individual category rates on its own and lets you see which categories are most impacting your overall score.
- The **Category score impact** lets you quickly see which outstanding recommendations would improve your score the most. This value reflects both the importance of the recommendation and how easy it would be to apply the recommendation.

Your Advisor Score changes as you remediate issues by adopting the best practices that Advisor recommends. By focusing on the Advisor recommendations that most affect your Advisor Score, you'll make the most progress as you address these issues.

### Monitor your progress over time

You can track your progress over time by seeing how much your overall score and your category scores change on a daily, weekly, and monthly basis. That way, you can set baselines to help you achieve your goals. Your ultimate goal probably isn't to achieve a 100% Advisor Score, but to design, build, and operate well-architected Azure workloads. Advisor Score is a great way to help you get there.

You can tailor your use of Advisor Score to fit your particular needs, but here's a recommended general workflow for how to manage your Advisor Score:

:::image type="content" source="../media/advisor-score-workflow.png" alt-text="Diagram showing the four steps of the Azure Advisor Score workflow - check, analyze, review, apply." border="false":::

- **Check** in to your Advisor Score dashboard to see if your target score is being met. (Ideally, you'd set your target at 100%, but depending on your current situation you might need to start with a different target.)
- **Analyze** the category scores to see what needs to be addressed (if the score falls below your target).
- **Review** the category score impact for each recommendation to see which ones produce the most benefit when addressed.
- **Apply** the recommendations that get you back to your target score as quickly as possible.

That's it! Then just repeat this process regularly to help you reach and maintain your well-architected goals.
