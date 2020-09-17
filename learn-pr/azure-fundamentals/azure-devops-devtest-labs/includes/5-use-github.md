Tailwind Traders hopes to publish an API that would allow third-parties to integrate their own inventories of new and used items that would allow Tailwind Traders to offer a wider variety of products directly from their ecommerce site.

While the internal implementation of the API is closed source, Tailwind Traders wants to create a set of examples that call the API to perform various actions.  They need a platform to share example code, collect feedback on the API, allow contributors to report issues, and build a community around feature requests.

### Which service should we choose?

Just like we did in the previous unit, let's apply the decision criteria we learned about in the previous unit to find the right option.

First, does Tailwind Traders need to automate and manage test lab creation? No. So, in this scenario, Azure DevTest Labs is not a candidate since it's not intended for this specific use case.

Second, is Tailwind Traders building open-source software?  Yes!  As we noted in a previous unit, developers are used to seeing this kind of content available on GitHub.  With GitHub, Tailwind Traders can publish their code, accept community contributions to improve the code examples, accept feedback and bug reports, and more. The fact that this scenario involves open-source code, GitHub is a leading candidate.

Third, what level granularity does Tailwind Traders need for permissions? While not stated explicitly, the fact that Tailwind Traders will be accepting community contributions, issue reports, and generally attempting to build a community of developers around their API examples, the permission needs are basic: users can either "view only" or "view and write". This is another reason why GitHub would be a good candidate for this scenario.

Fourth, does Tailwind Traders require a sophisticated project management and reporting solution? Again, given the nature of this project, it does not require a sophisticated project management and reporting solution. In this scenario, one of Azure DevOps Services' greatest strengths is not required.

Fifth, does Tailwind Traders require tight integration with any third-party DevOps tools? Tool integration was not listed as a primary consideration for this scenario and doesn't qualify or disqualify either tool.

GitHub is the best choice for this scenario.  While Azure DevOps could be used to make the repository public, some of the other features that involve the development community like feedback, bug reports, and so on, would be less accessible.