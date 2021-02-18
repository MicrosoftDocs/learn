## What is Advisor Score?

As you've learned, Azure Advisor continually analyzes your cloud environment to determine whether your workloads are following documented best practices for cost, security, reliability, performance, and operational excellence. As part of the process, Advisor then aggregates its findings into a single score – the **Advisor Score**.

The Advisor Score consists of an overall score of your entire workload. It is also further broken down into five individual category scores, each representing one of the five pillars of the Azure Well-Architected Framework.

With just a quick glance, Advisor Score helps you to:

- Understand where you are in your workload optimization process
- Know which services or resources are consumed well and which are not
- Prioritize your actions, based on recommendations, to maximize the outcome
- Track and report the progress you're making

### How is an Advisor Score calculated?

Advisor displays your category scores and your overall Advisor Score as percentages.

- A score of 100% in any category means all your resources, assessed by Advisor, follow the best practices that Advisor recommends.
- By contrast, a score of 0% means that none of your resources, assessed by Advisor, follows Advisor recommendations.

Each of the five categories has a highest potential score of 100%. Your overall Advisor Score is calculated as a sum of each applicable category score, divided by the sum of the highest potential score from all applicable categories. For most subscriptions, that means Advisor adds up the score from each category and divides by 500. But each category score is calculated only if you use resources that are assessed by Advisor.

As an example, for a single subscription, the Advisor Score is the simple mean of all Advisor category scores for your subscription. So, if the Advisor category scores are

- Cost = 73
- Reliability = 85
- Operational excellence = 77
- Performance = 100

The Advisor Score would be:

$$\frac{73 + 85 + 77 + 100}{4 x 100} = 0.84$$

:::image type="content" source="../media/advisor-equation.png" alt-text="(73 + 85 + 77 + 100)/(4 x 100) = 0.84 " border="false":::

or 84%.

The scores for multiple subscriptions are calculated a bit differently. Each category score is aggregated according to resources consumed by each subscription.

## Use Advisor Score to prioritize your workflow

As we've learned, the higher the Advisor Score, the more in line your workloads and subscriptions are with Azure best practices for optimization. Understanding the different components of Advisor Score helps you to prioritize the actions you take when addressing the issues that are raised by Azure Advisor.

- The **Advisor Score** gives you a baseline for how your workload or subscriptions are doing overall. You can also see the historical trends to understand and track your progress.
- The **Score by category** tells you how each individual category rates on it's own and lets you see which categories are most impacting your overall score.
- The **Category score impact** lets you quickly see which outstanding recommendations will improve your score the most. This value reflects both the importance of the recommendation and how easy it would be to apply the recommendation.

Your Advisor Score changes as you remediate issues by adopting the best practices that Advisor recommends. Focusing on applying Advisor recommendations that will have the greatest impact on your Advisor Score will help you make the most progress as you address these issues.

### Monitor your progress over time

You can track your progress over time by seeing how much your overall score and your category scores change on a daily, weekly, and monthly basis. This lets you set benchmarks to help you achieve your goals.

You can tailor your use of Advisor Score to fit your particular needs, but here is a recommended general workflow for how to manage your Advisor Score.

:::image type="content" source="../media/advisor-score-workflow.png" alt-text="Diagram showing the 4 steps of the Azure Advisor Score workflow - check, analyze, review, apply." border="false":::

Once you set a target goal for your overall Advisor Score, you can:

- Check in to your Advisor Score dashboard to see if your target goal is being met
- If the score falls below your target, analyze the category scores to see what is most in need of addressing
- Look at the category score impact for each recommendation to see which ones will produce the most benefit when addressed
- Apply the recommendations that will get you back to your goal as quickly as possible

That's it! Then just repeat this process regularly to make sure you are achieving your goals.
