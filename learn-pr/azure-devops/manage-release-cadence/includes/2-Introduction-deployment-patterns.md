The Tailspin team is feeling good. Their CD pipeline has really speeded up their release process. Both Tim and Amita are happy about having automated tests that make their jobs easier. In general, they're seeing fewer delays and fewer bugs. But there is, as always, a problem. Let's drop in on their team meeting, where Tim is talking.

"It's so hard to keep everyone happy. Irwin thinks it takes too long to get new features out to users. I can't do anything until management approves the release and, right now, there's no smooth way to roll it out once they give the okay. Not only does it take a long time but it's messy, it's manual, and there's down time. The whole process can take five days. I know that's too long but what am I supposed to do?" He takes a big gulp of coffee. "Maybe if I just drink more of this the solution will come to me."

"Coffee," Andy says, "is essential to all effective problem solving, no doubt. I also think that what we're talking about is called a <i>deployment pattern</i>.

"A deployment pattern is an automated way to do the cut-over, where we move the software from the final testing stage to live production. Picking the right pattern definitely addresses your problems, like minimizing down time. Another advantage is that a deployment pattern would give us a chance to run tests that should really happen in production. 

Here are the possibilities that Azure DevOps gives us." He starts writing on the white board.

* Blue-Green deployment
* Canary releases
* Feature toggles ***NOTE--ILT uses "toggles" rather than "flags"***
* Dark launches
* A/B testing
* Progressive exposure deployment

## Blue-green deployments

A blue-green deployment reduces risk and downtime by running two identical environments. These environments are called blue and green. At any time, only one of the environments is live. Let's say blue is live. As we prepare a new release,we would do our final tests in the green environment. Once the software is working in the green environment, we would just switch the router so that all incoming requests go to the green environment. Blue-green deployment also gives us a fast way to do a rollback. If anything goes wrong we simply switch the router back to the blue environment. 

<ARTWORK>

## Canary releases
A canary release is a way to identify potential problems as soon as possible without exposing all our users to the issue at once. The idea is that we would expose a new feature only to a small subset of users before making it available to everyone. We would monitor what happens when we release the the feature. If the canary release has problems, we can apply a fix. After the canary release is known to be stable, we can move it to the actual production environment.

<ARTWORK>

## Feature toggles
Feature toggles let us "flip a switch” at runtime. We can deploy new software without exposing any other new or changed functionality to our users. Mara and I  would build new features behind a toggle. When a release occurs, the feature is “off” so it's not impacting the production software. Depending on how we configure the toggle, we can flip the switch to "on" and expose it how we want. For example, we could expose it to a small, select number of users to see how they react. We could expose it to a random sample of users. We could simply let it go live to everyone. I think, to implement toggles, we need to decide on a framework. There's probably a lot around. Also, I'm not sure if this isn't more of a convenience for Mara and me. The big advantage to feature toggles is that it helps us avoid too much branching. Merging branches can be painful.

<ARTWORK>

## Dark launches

A dark launch is similar to a canary release or switching a feature toggle. Rather than expose a new feature to everyone, we would release it to a small set of users. Those users don't know they're being used as test users and we wouldn't even highlight the new feature to them. That's why it's a dark launch. The Software is gradually or unobtrusively released to users so we can get feedback and test performance.

<ARTWORK>

## A/B testing
A/B testing compares two versions of a webpage or app against each other to determine which one performs better. A/B testing is like an experiment we would run. We would show two or more variations of a page to users at random, and then use statistical analysis to decide which variation performs better for our goals.

<ARTWORK>

## Progressive exposure deployment
Progressive exposure deployment, is sometimes called ring-based deployment. It's another way of limiting the impact changes have on users while making sure those changes are valid in a production environment. Rings are basically an extension of the canary stage. The canary release releases to a stage to measure impact. Adding another ring is essentially the same thing. With a ring-based deployment, we would deploy changes to risk-tolerant customers first, and then progressively roll out to a larger set of customers.

<ARTWORK>

## Implementing the Blue-Green deployment
Andy looks at Tim. "That's a lot, I know. Do you want to take some time to think about it, or you and I could..."

"Blue-green," Tim says. Everyone in the room laughs. "Is that the coffee talking?" Mara asks.

Tim grins. "Feature toggles involve a change in how you and Andy work. Let's do one thing at a time. The methods that gradually expose a feature require statistical analysis or feature toggles. A blue-green deployment is something I can control. Switching a router is straightforward. It's easy and it sounds safe. Let's start there."


### What is a deployment slot

****NOTE--as per conversation, I copied this section on slots from design-release-management-workflow (it's still in the original)**

"I like it," Andy says. Also, since we're using Azure App Service, we can take advantage of its <i>deployment slots</i>. Deployment slots are running apps that have their own host names. 

We can create a slot for each stage in our pipeline. We could have a slot for dev, a slot for test and a slot for pre-production. If, at some point, we extend the pipeline to have a production stage, we could have a slot for that. That would be where we run the live app. 

I know I'm getting a bit ahead of myself, but with slots we could deploy new features without any downtime. We could swap an application and its configuration between two deployment slots. Basically we'd be swapping the IP addresses of the two slots.

"Food for thought," says Tim.

***NOTE--copied from ILT***
When using a cloud platform like Azure, doing Blue-Green deployments is relatively easy. You do not need to write your own code or set up infrastructure. When using web apps, you can use an out-of-the-box feature called Deployment Slots.

Deployment Slots are a feature of Azure App Service. They are live apps with their own hostnames. You can create different slots for your application (e.g., Dev, Test or Stage). The Production slot is the slot where your live app resides. With deployment slots, you can validate app changes in staging before swapping it with your production slot.

You can use a deployment slot to set up a new version of your application, and when ready, swap the production environment with the new, staging environment. This is done by an internal swapping of the IP addresses of both slots.













[ILT Content Link](https://courses.microsoft.com/courses/course-v1:ELMS+AZ-400.3+2019_T1/course/?azure-portal=true)

Course > Design a Release Strategy > Choosing a Deployment Pattern > Choosing a deployment pattern

The team talks about the best way to get a feature deployed to production. 

Currently, a build is deployed to pre-production and the management team must set up a meeting to demo the feature and approve the deployment to production.
Tim has to manually deploy the build that is on staging over to production after approval. 
This process takes 5 days according to our map.
They decide to look into deployment patterns to see their best fit for faster deployments to production.

ILT also mentions that some things just have to be tested in production and these deployment patterns help facilitate that. This is a good point to make with the team.
Amita is on board with this too. 

