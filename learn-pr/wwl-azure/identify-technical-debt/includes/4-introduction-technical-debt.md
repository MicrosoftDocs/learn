**Technical debt** is a term that describes the future cost that will come from choosing an easy solution today instead of using better practices that would take longer to complete.

The term "technical debt" was chosen because it's similar to financial debt. It's common for people in financial debt to make decisions that seem right or like the only option at the time, but by doing so, interest increases.

The more interest that builds up, the harder it becomes for them in the future and the fewer options they have later. With financial debt, soon interest increases on interest, creating a snowball effect. Similarly, technical debt can build up to the point where developers spend almost all their time fixing problems and doing rework, either planned or unplanned, rather than adding value.

So, how does it happen?

The most common excuse is tight deadlines. When developers are forced to create code quickly, they'll often take shortcuts. For example, instead of refactoring a method to include new functionality, they might copy it to create a new version. Then they only test the new code and can avoid the level of testing required if they change the original method because other parts of the code use it.

Now they have two copies of the same code that need to be modified in the future instead of one, and they run the risk of the logic becoming different. There are many causes. For example, there might be a lack of technical skills and maturity among the developers or no clear product ownership or direction.

The organization might not have coding standards at all, so the developers didn't even know what they should be producing. The developers might not have clear requirements to target, or they might be subject to last-minute requirement changes.

Necessary refactoring work might be delayed. There might not be any code quality testing, manual or automated. In the end, it just makes it harder and harder to deliver value to customers in a reasonable time frame and at a reasonable cost.

Technical debt is one of the main reasons that projects fail to meet their deadlines.

Over time, it increases in much the same way that monetary debt does. Common sources of technical debt are:

- Lack of coding style and standards
- Lack of or poor design of unit test cases
- Ignoring or not understanding object-oriented design principles
- Monolithic classes and code libraries
- Poorly planned use of technology, architecture, and approach (forgetting that all system attributes, affecting maintenance, user experience, scalability, and others, need to be considered)
- Over-engineering code (adding or creating code that isn't required, adding custom code when existing libraries are sufficient, or creating layers or components that aren't needed)
- Insufficient comments and documentation
- Not writing self-documenting code (including class, method, and variable names that are descriptive or indicate intent)
- Taking shortcuts to meet deadlines
- Leaving dead code in place

> [!NOTE]
> Over time, the technical debt must be paid back. Otherwise, the team's ability to fix issues and implement new features and enhancements will take longer and eventually become cost-prohibitive.

We have seen that technical debt adds problems during development and makes it much more difficult to add extra customer value.

Having technical debt in a project reduces productivity, frustrates development teams, makes code both hard to understand and fragile, increases the time to make changes and validate those changes. Unplanned work frequently gets in the way of planned work.

Longer-term, it also weakens the organization's strength. Technical debt tends to creep up on an organization. It starts small and grows over time. Every time a quick hack is made or testing is skipped because changes need to be rushed through, the problem gets worse and worse. Support costs get higher and higher, and eventually, a serious issue arises.

Eventually, the organization can't respond to its customers' needs in a timely and cost-efficient way.

## Automated measurement for monitoring

One key way to minimize the constant build-up of technical debt is to use automated testing and assessment.

In the demos that follow, we'll look at one of the common tools used to assess the debt: SonarCloud. (The original on-premises version was SonarQube).

There are other tools available, and we'll discuss a few of them.

Later, in the next hands-on lab, you'll see how to configure your Azure Pipelines to use SonarCloud, understand the analysis results, and finally how to configure quality profiles to control the rule sets that are used by SonarCloud when analyzing your projects.

For more information, see [SonarCloud](https://sonarcloud.io/about).

## To review:

Azure DevOps can be integrated with a wide range of existing tools used to check code quality during builds.

What code quality tools do you currently use (if any)?

What do you like or don't you like about the tools?
