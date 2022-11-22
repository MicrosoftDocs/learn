Use the Microsoft Sentinel Content hub to centrally discover and install out-of-the-box (built-in) content.

The Microsoft Sentinel Content Hub provides in-product discoverability, single-step deployment, and enablement of end-to-end product, domain, and/or vertical out-of-the-box solutions and content in Microsoft Sentinel.

In the Content hub, filter by categories and other parameters, or use the powerful text search, to find the content that works best for your organization's needs. The Content hub also indicates the support model applied to each piece of content, as some content is maintained by Microsoft and others are maintained by partners or the community.

Manage updates for out-of-the-box content via the Microsoft Sentinel Content hub, and for custom content via the Repositories page.

Customize out-of-the-box content for your own needs, or create custom content, including analytics rules, hunting queries, notebooks, workbooks, and more. Manage your custom content directly in your Microsoft Sentinel workspace, via the Microsoft Sentinel API, or in your own source control repository, via the Microsoft Sentinel Repositories page.


## Solutions
Microsoft Sentinel solutions are packaged content or integrations that deliver end-to-end product value for one or more domain or vertical scenarios.

The solutions experience is powered by Azure Marketplace for solutions’ discoverability and deployment. 

Microsoft Sentinel solutions provide in-product discoverability, single-step deployment, and enablement of end-to-end product, domain, and/or vertical scenarios in Microsoft Sentinel. This experience is powered by for solutions’ discoverability, deployment, and enablement, and by for solutions’ authoring and publishing.

- **Packaged content** are collections of one or more pieces of Microsoft Sentinel content, such as data connectors, workbooks, analytics rules, playbooks, hunting queries, watchlists, parsers, and more.

- **Integrations** include services or tools built using Microsoft Sentinel or Azure Log Analytics APIs that support integrations between Azure and existing customer applications, or migrate data, queries, and more, from those applications into Microsoft Sentinel.

You can also use solutions to install packages of out-of-the-box content in a single step, where the content is often ready to use immediately. Providers and partners can use solutions to productize investments by delivering combined product, domain, or vertical value.

Use the Content hub to centrally discover and deploy solutions and out-of-the-box content in a scenario-driven manner.


### Find a solution

- From the Microsoft Sentinel navigation menu, under Content management, select Content hub.

- The Content hub page displays a searchable and filterable grid of solutions.

- Filter the list displayed, either by selecting specific values from the filters, or entering any part of a solution name or description in the Search field.

    Each solution in the grid shows the categories applied to the solution, and types of content included in the solution.

    For example, in the Cisco Umbrella solution shows a category of Security - Others, and that this solution includes 10 analytics rules, 11 hunting queries, a parser, three playbooks, and more.


### Install or update a solution
- In the content hub, select a solution to view more information on the right. Then select Install, or Update, if you need updates. For example:

- On the solution details page, select Create or Update to start the solution wizard. On the wizard's Basics tab, enter the subscription, resource group, and workspace to which you want to deploy the solution. 

- Select Next to cycle through the remaining tabs (corresponding to the components included in the solution), where you can learn about, and in some cases configure, each of the content components.

- Finally, in the Review + create tab, wait for the Validation Passed message, then select Create or Update to deploy the solution. You can also select the Download a template for automation link to deploy the solution as code.