The software development team at Tailwind Traders works on many different projects, both for internal and external usage.  The team needs to give project sponsors and managers executive level reporting, including burndown charts, track progress against epics, and track custom information that's specific to Tailwind Traders in each work item and bug report.

As Tailwind Traders grows and hires contractors and outside vendors for short-term work, the upper management team wants to ensure that these individuals have access only to the information they need to do their work.

### Which services should we choose?

Apply the decision criteria you learned about in the preceding unit to find the right option.

First, does Tailwind Traders need to automate and manage test lab creation? No. So, in this scenario, Azure DevTest Labs is not a candidate, because it isn't intended for this specific use case.

Second, is Tailwind Traders building open-source software? Though it's not stated specifically, Tailwind Traders is building internal and external systems, such as their e-commerce system, which isn't open source.  So that isn't a consideration in this scenario.

Third, what level of granularity does Tailwind Traders need for permissions? Earlier, we stated that Tailwind Traders will hire temporary employees and vendors for short-term work, which makes a granular permissions requirement an important consideration for upper management. Based on our description in the preceding unit, this feature would make Azure DevOps a leading candidate. By using Azure DevOps, Tailwind Traders administrators would also have a more robust set of options for controlling permissions across the entire portfolio of work.

Fourth, does Tailwind Traders require a sophisticated project management and reporting solution? Yes, robust project management and reporting features are one of the primary considerations. Here again, because of the amount of work-item customization and reporting the management team wants, Azure DevOps would likely be a good choice.

Fifth, does Tailwind Traders require tight integration with any third-party DevOps tools? Tool integration was not listed as a primary consideration for this scenario.  As you learned in the preceding unit, most third-party DevOps tools integrate with both Azure DevOps and GitHub, which makes it likely that the team will find the tools it needs.
