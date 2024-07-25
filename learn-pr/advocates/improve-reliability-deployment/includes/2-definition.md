According to Wikipedia, "software deployment" is composed of _all of the activities that make a software system available for use._ The general deployment process consists of several interrelated activities, with possible transitions between them. Every software system is unique; therefore, "deployment" should be interpreted as a general process that has to be customized according to specific requirements or characteristics.

Some use the terms "deployment" and "installation" interchangeably, but the software installation is only a part of the process of deploying it. Deployment involves much more. Deployment activities can include:

- "Racking and stacking" a server.
- Deploying an updated piece of software onto that server.
- Using things such as scripts and infrastructure as code.
- Even walking around an office with a USB drive, manually installing software on computers.

Manually deploying software is labor-intensive and doesn’t scale well. Automation makes it easier and more cost effective to ensure consistency when you roll out new software or update existing  software across an organization.

Our focus as part of this learning path is how to best deploy software for reliability. This module addresses not only software deployment, but deploying cloud infrastructure, as well. References to deploying a service or a solution can mean deploying software, cloud infrastructure, configuration, and all of the things that are needed to reliably make a software system available to use.

## Scenario: The epic deployment

The word _epic_ means "grand, monumental, or vast," but in the context of this discussion, it's not a good thing. The term "epic" was coined by Jez Humble in his book _Continuous Delivery:  Reliable Software Releases through Build, Test, and Deployment Automation_ because it represents a massive (and massively disruptive) undertaking. Here’s an example of how it typically happens:

- An organization develops a sales-related application. This application is updated exactly twice per year.
- During these updates, all the new features, bug fixes (large and small), and dependency updates are deployed.
- The first deployment of the year is scheduled to happen over Labor Day weekend, and the second takes place the weekend after Thanksgiving.
- Each update is an "all hands-on deck" situation. The application team, support team, infrastructure team, management; everyone is involved in the deployment.
- Services temporarily go offline while the deployment is in progress.
- History has shown that the deployment is always fraught with issues, on-demand engineering, troubleshooting, and configuration-management changes.
- It seldom goes well, and when it’s complete, it generally feels patched together in an unreproducible way.

This is not a good deployment situation. The epic deployment method is an intense manual task that presents a number of problems:

- It's complex.
- It's stressful.
- It's risky.
- It's slow.
- It's not reproducible because of all the complex steps.
- It often requires several individual experts to complete the deployment.

Because this process is long and arduous, it has to be scheduled at times that will cause the least disruption of user productivity, which means times that are likely to be inconvenient for the deployment team, such as weekends and holidays.

Team members might feel rushed to get the mammoth operation completed within the time frame, causing them to make configuration mistakes. Also, long times between deployments might cause you to forget exactly how things work.

## The deployment dilemma

Software deployment is a complex task, and when you "save up" multiple major changes, fixes, and feature additions to deploy all in one fell swoop, you increase the complexity and thus increase the probability of something going wrong. In addition, when things do go wrong, this complexity makes it more difficult to track down exactly what caused the problem.

Complexity can also create problems for the end users, as they might have to deal with learning many new features and changes all at once, not to mention any bugs that are introduced by the epic deployment's complexity.

There should a better way, and there is. The good news is that the traditional epic deployment strategy is not the only option. We'll learn a better way of going about this process in the next unit.
