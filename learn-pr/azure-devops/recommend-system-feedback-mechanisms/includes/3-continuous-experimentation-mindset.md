The team is still discussing the repercussions of Irwin's announcement. The company is going to use some of their customers to do beta testing and Irwin expects fast responses from the team for bug fixes, new features and customer data. Right now, they're talking about the conflict between speed an stability.

## The discussion

**Mara**: I was wondering if one thing we could do to resolve the problem is to institute feature toggles, or flags. We talked about it once, when we were deciding on deployment patterns. Then, we opted for the blue-green pattern. Feature flags seemed too advanced at the time, but now might be a good time to think about them, especially since we'll be doing beta testing with a selected group.

## The expectations of continuous delivery

Mara is offering a solution to an issue that DevOps and CD has made very apparent. In the era of continuous delivery (CD), we're expected to quickly deliver software that is stable and performs well. Development teams embrace CD tools to automate their builds, their test passes, and their deployments, all at an accelerated pace.

Because teams want to deliver their new features and applications faster, there is always tension between the need for innovation and the need for stability. How can you encourage innovation while still mitigating risk?

On the innovation side, the first step is to create a culture where executives, business planners, developers, operations, and other stakeholders understand how innovations in engineering productivity align with business outcomes. Next, to prove that specific innovations improve those outcomes, test the hypotheses through continuous experimentation. 

A culture of continuous experimentation is an environment where you can quickly test features by creating an instrumented minimal viable product (MVP). You then release that MVP to a subset of customers for testing. This limited release enables the team to make decisions based on facts and to move quickly towards the optimal solution.

How do you reduce risk in such a culture? Teams have a number of ways to identify issues before a release reaches production. One is to rely on version control systems or configuration files to control feature releases. However, what happens after the release is in production? Without proper controls, rolling back to previous versions if there's a problem becomes a code deployment exercise, requiring engineering expertise and increasing the potential for downtime.

One way to mitigate risk in feature releases is to introduce _feature flags_ (also known as _feature toggles_) into the continuous delivery process. These flags allow features (or any piece of code) to be turned on or off for particular users. Feature flags are a power

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

## The decision

**Andy**: I agree, Mara. It's time to go with feature flags. We can even come up with a plan of how we want to disclose the features to the beta testers.

**Amita** So, the next issue we have to think about is customer satisfaction. How do we figure out what they think about our website? 