As you've learned, Azure Advisor continually analyzes your cloud environment to determine whether your workloads are following documented best practices for cost, security, reliability, performance, and operational excellence.

## What is  Advisor Score?

Advisor aggregates its findings into a single number – **Advisor Score**.

Advisor Score consists of an overall rating for your entire workload. It's also further broken down into five individual category scores, each representing one of the five pillars of Azure Advisor and the Azure Well-Architected Framework.

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

As an example, for a single subscription, the Advisor Score is the simple mean of all Advisor category scores for your subscription. So, if the Advisor category scores are

- Cost = 73
- Reliability = 85
- Operational excellence = 77
- Performance = 100

The Advisor Score would be 0.84 or **84%** as shown in the following equation:

<!-- $$\frac{73 + 85 + 77 + 100}{4 x 100} = 0.84$$ -->

:::image type="content" source="../media/advisor-equation.png" alt-text="(73 + 85 + 77 + 100)/(4 x 100) = 0.84 " border="false":::

The scores for multiple subscriptions are calculated a bit differently. Each category score is aggregated according to resources consumed by each subscription.

### Scoring methodology

How Advisor calculates your score can be summarized in four steps. At the category level:

1. Advisor calculates the retail cost of impacted resources. These resources are the ones in your subscriptions that have at least one recommendation in Advisor.
1. Advisor calculates the retail cost of assessed resources. These resources are the ones monitored by Advisor, whether they have any recommendations or not.
1. For each recommendation type, Advisor calculates the healthy resource ratio. This ratio is the retail cost of impacted resources divided by the retail cost of assessed resources.
1. Advisor applies these more weights to the healthy resource ratio in each category:
    - Resources with a higher spend are weighted more heavily than resources with a lower spend (since they're probably more important to you).
    - Resources with long-standing recommendations count more against your score.
    - Recommendations with greater impact are weighted more heavily than recommendations with lower impact.
    - Resources that you postpone or dismiss in Advisor are removed from your score calculation entirely.

## Use Advisor Score to prioritize your workflow

As we've learned, the higher the Advisor Score, the more in line your workloads and subscriptions are with Azure best practices for optimization. Understanding the different components of Advisor Score helps you to prioritize the actions you take when addressing the issues that are raised by Azure Advisor.

- The **Advisor Score** gives you a baseline for how your workloads or subscriptions are doing overall. You can also see the historical trends to understand and track your progress.
- The **Score by category** tells you how each individual category rates on its own and lets you see which categories are most impacting your overall score.
- The **Category score impact** lets you quickly see which outstanding recommendations will improve your score the most. This value reflects both the importance of the recommendation and how easy it would be to apply the recommendation.

Your Advisor Score changes as you remediate issues by adopting the best practices that Advisor recommends. By focusing on the Advisor recommendations that most affect your Advisor Score, you'll make the most progress as you address these issues.

### Monitor your progress over time

You can track your progress over time by seeing how much your overall score and your category scores change on a daily, weekly, and monthly basis. That way, you can set baselines to help you achieve your goals.

You can tailor your use of Advisor Score to fit your particular needs, but here is a recommended general workflow for how to manage your Advisor Score.

:::image type="content" source="../media/advisor-score-workflow.png" alt-text="Diagram showing the four steps of the Azure Advisor Score workflow - check, analyze, review, apply." border="false":::

Once you set a target goal for your overall Advisor Score, you can:

- **Check** in to your Advisor Score dashboard to see if your target goal is being met.
- **Analyze** the category scores to see what needs to be addressed (if the score falls below your target).
- **Review** the category score impact for each recommendation to see which ones will produce the most benefit when addressed.
- **Apply** the recommendations that will get you back to your goal as quickly as possible.

That's it! Then just repeat this process regularly to make sure you're achieving your goals.
