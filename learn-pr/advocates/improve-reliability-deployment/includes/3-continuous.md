You've learned about the many disadvantages of the "epic deployment" as a software-delivery model, but knowing what _doesn’t_ work well is only half the battle. In this unit, you’ll learn about the alternative to that monolithic method, and how it can further your goal of improved reliability.

## What is continuous delivery?

_Continuous delivery_ is a method by which you can make software changes available for use in a faster, less stressful, less risky, and more reproducible way. Rather than making each software deployment or update an epic event, continuous delivery strives to turn it into a quick, routine, predictable experience that happens on demand.

- **Deployment frequency**: With a continuous delivery model, deployments happen often. This often could be monthly, weekly, daily, even hourly. The key is that you deploy _smaller, more focused changes, more often_.

- **Initiated by code commit**: Instead of being scheduled far in advance, deployments take place as code is committed. This code can be software, infrastructure, or even things like software configurations.

- **Automated testing**: You can use integrated automated testing not only to test the code, but to also provide quick feedback on the results of those tests. It's this quick feedback that allows you to iterate and recover from failed tests quickly.

  Once your code has been tested, you can test the deployment end to end in a series of staged environments such as test, QA, and so forth. Rolling your deployments through these environments becomes an integrated part of the deployment experience.

- **Historical records**: Not only do you want a historical record of deployment activities, you also want to be able to reconcile your production environment at any given time. You want to understand which  deployment created your current production environment. With this knowledge, you can trace such things as configurations, test results, and the code itself all the way back to the individual pull request that triggered the deployment.

## Deployment goals

Now that you know how continuous delivery works, consider the goals you can achieve by using DevOps practices such as this for deploying software solutions.

### Goal 1: Reduce the stress involved with deploying services while increasing the reliability of those services

This is a win-win; not only do you increase job satisfaction by reducing the stress involved with software and infrastructure deployments, you also increase both job satisfaction and end-user satisfaction by making your systems more reliable. Given this positive impact on the customer experience, technically this is a win-win-win.

### Goal 2: Reduce the time between when you know a change is required and when that change is deployed to production

For example, assume that you've identified a revenue-impacting code defect. You know exactly what the issue is and how to code up the fix. How long does it take for you to get that code into production? How many strings do you need pull? How do you test? With DevOps practices, you can code commit, take lunch, and get a notification that the issue has been resolved before returning to your desk.

### Goal 3: Reduce the time between having an idea and delivering useable software

This is very similar to the previous goal, but instead of implementing changes, we're talking about pure innovation. How long does it take for you to act on innovation? With this deployment model, you can integrate a new concept into a production system and have the confidence that the added innovation won't break of hinder the current system in any way. With this confidence, you can then quickly deliver the new feature.

## Deployment results

The goals discussed in this unit aren't just theoretical aspirations, they're achievable. Here are some statistics from the _2019 Accelerate State of DevOps Report_ by DevOps Research and Assessment (DORA) and Google Cloud DevOps & SRE. In it, they've found that "high performing" DevOps companies:

- Have 208x the number of deployments.
- Are 106x faster from commit to deploy.
- Have a 7x lower change failure rate.
- Have a 2,604x faster incident recovery time.

This all leads to increased revenue and faster time to market.

These numbers validate the idea that deployment practices matter.
