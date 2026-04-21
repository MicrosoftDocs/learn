You've learned about the many disadvantages of the "epic deployment" as a software-delivery model, but knowing what _doesn't_ work well is only half the battle. In this unit, you learn about the alternative to that monolithic method, and how it can further your goal of improved reliability.

It's also worth distinguishing two related terms that are sometimes used interchangeably:

- **Continuous delivery**: every change that passes automated tests is _ready_ to be deployed to production, but the actual release to production is gated by a manual approval.
- **Continuous deployment**: every change that passes automated tests is _automatically_ released to production, with no manual gate.

Both depend on the same foundations (frequent integration, automated tests, repeatable pipelines). This module focuses on those shared foundations.

## What is continuous delivery?

_Continuous delivery_ is a method by which every change to your codebase is kept _releasable_ in a faster, less stressful, less risky, and more reproducible way. Rather than making each software deployment or update an epic event, continuous delivery turns it into a quick, routine, predictable experience that happens on demand.

- **Deployment frequency**: With a continuous delivery model, deployments happen often. Cadence could be monthly, weekly, daily, or even hourly. The key is that you deploy _smaller, more focused changes, more often_.

- **Triggered by code commit**: Instead of waiting for a release window scheduled far in advance, the delivery pipeline starts when code is committed. This code can be software, infrastructure, or even things like software configurations. Each change is then built, tested, and kept ready for release. Depending on your organization's controls, promotion to production can still happen later, after an approval.

- **Automated testing**: You can use integrated automated testing not only to test the code, but to also provide quick feedback on the results of those tests. It's this quick feedback that allows you to iterate and recover from failed tests quickly.

  Once your code has been tested, you can test the deployment end to end in a series of staged environments such as test, QA, and so forth. Rolling your deployments through these environments becomes an integrated part of the deployment experience.

- **Historical records**: Not only do you want a historical record of deployment activities, you also want to be able to reconcile your production environment at any given time. You want to understand which deployment created your current production environment. With this knowledge, you can trace such things as configurations, test results, and the code itself all the way back to the individual pull request that triggered the deployment.

## Deployment goals

Now that you know how continuous delivery works, consider the goals continuous delivery and other DevOps practices help you achieve when deploying software solutions.

### Goal 1: Reduce the stress involved with deploying services while increasing the reliability of those services

Reducing the stress of software and infrastructure deployments improves the day-to-day experience of the engineers who run them. The resulting increase in reliability also benefits end users, who see fewer outages and disruptions.

### Goal 2: Reduce the time between when you know a change is required and when that change is deployed to production

For example, suppose you've identified a revenue-impacting code defect and you know exactly how to fix it. With mature DevOps practices, the path from commit to production is short and predictable. The change is built, automatically tested across the relevant environments, and prepared for release within minutes. Once the required approval is given, it can be promoted to production instead of being held for a future release window.

### Goal 3: Reduce the time between having an idea and delivering usable software

This goal is similar to the previous one, but it focuses on innovation rather than fixes. How long does it take you to act on a new idea? With this deployment model, you can integrate a new concept into a production system with confidence that the addition won't break or hinder the current system. That confidence lets you deliver new features quickly.

## Deployment results

The goals discussed in this unit aren't just theoretical aspirations, they're measurable. Since 2014, the DevOps Research and Assessment (DORA) team has published annual State of DevOps research on software delivery performance. In recent years, this work has been published as the _Accelerate State of DevOps Report_. The current DORA model tracks five delivery metrics:

- Deployment frequency
- Change lead time
- Change fail rate
- Failed deployment recovery time
- Deployment rework rate

Year after year, the research shows that higher-performing teams deliver changes more frequently, move from commit to production faster, recover from failed deployments sooner, and spend less time fixing deployment-related issues. For the latest research and metric definitions, see [DORA's software delivery metrics](https://dora.dev/guides/dora-metrics/).

These results validate the idea that deployment practices matter.
