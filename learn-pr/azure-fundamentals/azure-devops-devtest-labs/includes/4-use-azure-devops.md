The software development team at Tailwind Traders works on many different projects, both for internal and external usage.  They need to provide project sponsors and managers executive level reporting, including burndown charts, track progress against epics, and track custom information specific to Tailwind Traders in each work item and bug report.

Furthermore, as Tailwind Traders grows and hires contractors and outside vendors for short-term work, upper management wants to ensure that these individuals have access to only the information they need to do their work.

### Which services should we choose?

Let's apply the decision criteria we learned about in the previous unit to find the right option.

First, does Tailwind Traders need to automate and manage test lab creation? No. So, in this scenario, Azure DevTest Labs is not a candidate since it's not intended for this specific use case.

Second, is Tailwind Traders building open-source software? While it's not stated specifically, Tailwind Traders is building internal and external systems, like their eCommerce system, which is not open source.  So, that is not a consideration in this scenario.

Third, what level granularity does Tailwind Traders need for permissions? In the opening paragraph, it stated that Tailwind Traders will hire temporary employees and vendors for short-term work, and so granular permissions is an important consideration to upper management. Given what we talked about in the previous unit, this feature would make Azure DevOps a leading candidate.  Using Azure DevOps, administrators would also have a more robust set of options to control permissions across the entire portfolio of work.

Fourth, does Tailwind Traders require a sophisticated project management and reporting solution? Yes, robust project management and reporting features are one of the primary considerations. Here again, given the amount of work item customization and reporting they want, Azure DevOps would likely be a good choice.

Fifth, does Tailwind Traders require tight integration with any third-party DevOps tools? Tool integration was not listed as a primary consideration for this scenario.  As stated in the previous unit, most third-party DevOps tools integrate with both Azure DevOps and GitHub, so it's likely that they'll find the tools they need for specific functionality they need.