Tailwind Traders hopes to publish an API that would allow third parties to integrate their own inventories of new and used items. This approach would allow Tailwind Traders to offer a wider variety of products directly from their e-commerce site.

Although the internal implementation of the API is closed source, Tailwind Traders wants to create a set of examples that call the API to perform various actions.  The team needs a platform to share example code, collect feedback on the API, allow contributors to report issues, and build a community around feature requests.

### Which service should you choose?

Apply the decision criteria you learned about earlier to find the right option.

First, does Tailwind Traders need to automate and manage test lab creation? No. In this scenario, Azure DevTest Labs is not a candidate because it isn't designed for this use case.

Second, is Tailwind Traders building open-source software?  Yes. As we noted in a previous unit, developers are used to seeing this kind of content available on GitHub.  With GitHub, Tailwind Traders developers can publish their code, accept community contributions to improve the code examples, accept feedback and bug reports, and more. Because this scenario involves open-source code, GitHub is a leading candidate.

Third, what level of granularity does the Tailwind Traders team need for assigning permissions? Though it's not stated explicitly, the fact that Tailwind Traders will be accepting community contributions, issuing reports, and generally attempting to build a community of developers around their API examples, the company's permission needs are basic: users can either *view only* or *view and write*. This is another reason why GitHub would be a good candidate for this scenario.

Fourth, does Tailwind Traders require a sophisticated project management and reporting solution? Again, because of the nature of this project, the team doesn't require a sophisticated project management and reporting solution. In this scenario, the strength of Azure DevOps Services isn't required.

Fifth, does Tailwind Traders require tight integration with any third-party DevOps tools? Tool integration wasn't listed as a primary consideration for this scenario and doesn't qualify or disqualify either tool.

GitHub is the best choice for this scenario. Although you could use Azure DevOps to make the repository public, some of the other features that involve the development community, such as feedback or bug reports, would be less accessible.
