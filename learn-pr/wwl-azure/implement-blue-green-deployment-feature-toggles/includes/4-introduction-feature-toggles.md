Feature Flags allow you to change how our system works without making significant changes to the code. Only a small configuration change is required. In many cases, it will also only be for a few users.

Feature Flags offer a solution to the need to push new code into the trunk and deploy it, but it isn't functional yet.

They're commonly implemented as the value of variables used to control conditional logic.

Imagine that your team is all working in the main trunk branch of a banking application.

You've decided it's worth trying to have all the work done in the main branch to avoid messy operations of merge later.

Still, you need to ensure that significant changes to the interest calculations can happen, and people depend on that code every day.

Worse, the changes will take you weeks to complete. You can't leave the main code broken for that period.

A Feature Flag could help you get around it.

You can change the code so that other users who don't have the Feature Flag set will use the original interest calculation code.

The members of your team who are working on the new interest calculations and set to see the Feature Flag will have the new interest calculation code.

It's an example of a business feature flag used to determine business logic.

The other type of Feature Flag is a Release Flag. Now, imagine that after you complete the work on the interest calculation code, you're nervous about publishing a new code out to all users at once.

You have a group of users who are better at dealing with new code and issues if they arise, and these people are often called Canaries.

The name is based on the old use of the Canaries in coal mines.

You change the configuration so that the Canary users also have the Feature Flag set, and they'll start to test the new code as well. If problems occur, you can quickly disable the flag for them again.

Another release flag might be used for AB testing. Perhaps you want to find out if a new feature makes it faster for users to complete a task.

You could have half the users working with the original version of the code and the other half working with the new code version.

You can then directly compare the outcome and decide if the feature is worth keeping. Feature Flags are sometimes called Feature Toggles instead.

By exposing new features by just "flipping a switch" at runtime, we can deploy new software without exposing any new or changed functionality to the end-user.

The question is, what strategy do you want to use in releasing a feature to an end-user.

 -  Reveal the feature to a segment of users, so you can see how the new feature is received and used.
 -  Reveal the feature to a randomly selected percentage of users.
 -  Reveal the feature to all users at the same time.

The business owner plays a vital role in the process, and you need to work closely with them to choose the right strategy.

Just as in all the other deployment patterns mentioned in the introduction, the most crucial part is always looking at how the system behaves.

The idea of separating feature deployment from Feature exposure is compelling and something we want to incorporate in our Continuous Delivery practice.

It helps us with more stable releases and better ways to roll back when we run into issues when we have a new feature that produces problems.

We switch it off again and then create a hotfix. By separating deployments from revealing a feature, you make the opportunity to release a day anytime since the new software won't affect the system that already works.

## What are feature toggles?

Feature toggles are also known as feature flippers, feature flags, feature switches, conditional features, and so on.

Besides the power they give you on the business side, they also provide an advantage on the development side.

Feature toggles are a great alternative to branching as well. Branching is what we do in our version control system.

To keep features isolated, we maintain a separate branch.

When we want the software to be in production, we merge it with the release branch and deploy it.

With feature toggles, you build new features behind a toggle. Your feature is "off" when a release occurs and shouldn't be exposed to or impact the production software.

## How to implement a feature toggle

In the purest form, a feature toggle is an IF statement.

:::image type="content" source="../media/feature-toggle-0a27e13b.png" alt-text="Diagram showing feature toggle.":::


When the switch is off, it executes the code in the IF, otherwise the ELSE.

You can make it much more intelligent, controlling the feature toggles from a dashboard or building capabilities for roles, users, and so on.

If you want to implement feature toggles, many different frameworks are available commercially as Open Source.

For more information, see also [Explore how to progressively expose your features in production for some or all users](/azure/devops/articles/phase-features-with-feature-flags).
