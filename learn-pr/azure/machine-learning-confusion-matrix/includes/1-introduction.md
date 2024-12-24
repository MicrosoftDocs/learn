Single-value metrics, like mean-squared error or log-loss, are fast ways to compare models in terms of performance. They aren't always intuitive, however, and can't always give a full picture about how the model is truly performing. For example, if we're trying to detect cancer but only 1 in 100,000 tissue samples actually contain cancer, a model that always says "no cancer" will have an excellent log-loss (cost), but will be completely useless in the clinic. Choosing more intelligent ways to assess models is important so that you can get a proper understanding as to how your model will work in the real world.

## Scenario: Mountain rescue with machine learning

Throughout this module, we’ll be using the following example scenario to explain and practice working with different metrics and data imbalances.

As winter rolls around again, concern has risen because hikers are ignoring avalanche risk warnings and are venturing out even when the mountain is closed. Not only does this risk causing more avalanches, but because hikers are rarely checking in before venturing out, there's no way to know if anyone was on the mountain when an avalanche took place. A generous donor has provided the avalanche-rescue team with a swarm of miniature drones that are capable of automatically scanning the mountainside for objects. Due to the extreme terrain and battery drain in the cold, their bandwidth remains too low to transmit video. Instead, the sensors onboard can extract basic information such as object shape, size, and movement and transmit this to home base. Can you build a model that can determine when the drone has come across a person, to keep track of who's on the mountain?

## Prerequisites

* Basic familiarity with classification models

## Learning objectives

In this module, you will:

* Assess performance of classification models.
* Review metrics to improve classification models.
* Mitigate performance issues from data imbalances.
