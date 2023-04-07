Organizations use cloud-based apps to spin up solutions quickly to meet their business needs. For Tailwind Traders, we can deploy Elastic Cloud on Azure to get Elasticsearch capabilities built in. Here, you'll learn about the steps involved and key considerations for deploying Elastic Cloud on Azure.

## Start through the Azure Marketplace or Azure portal

You can get started with Elastic on Azure through the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/elastic.ec-azure-pp) using your existing Azure account for integrated billing or through the search page in Azure portal by searching for "Elasticsearch (Elastic Cloud)".

This directs you to an Elastic sign-up form where you'll create a new account. If you've previously signed up with an Elastic Cloud account, you must create a new account to receive integrated billing. Using your Elastic Cloud account will incur a charge, but you can keep costs minimal by selecting the smallest option.

## Select a preconfigured solution that’s right for your needs

After you complete the subscription process, you'll choose from four different preconfigured solutions when deploying Elastic Cloud on Azure. If you're not sure what to start with, Elastic General Purpose template offers a versatile solution that supports most use cases and makes a great first choice. The preconfigured solutions are:

- [Elastic Observability](https://www.elastic.co/observability): Unify logs, metrics, traces, and more from your ecosystem in a scalable stack that is open and built for speed. Monitor, search, and analyze all your operational data for insights to quickly resolve issues and consistently deliver exceptional digital experiences.
- [Elastic Enterprise Search:](https://www.elastic.co/enterprise-search) Search everything, anywhere. Elastic App Search provides all the tools you need to design and deploy powerful search experiences for your websites and mobile apps. Elastic Workplace Search gives your teams a unified search experience across all their collaboration, productivity, and storage tools, helping them find whatever they need, wherever it may be.
- [Elastic Security](https://www.elastic.co/security): Effective cybersecurity requires data at scale. Elastic Security solves for core data and scale problems. Leading security teams use the free and open solution for SIEM, endpoint security, threat hunting, cloud monitoring, and more. An intuitive UI and vast ecosystem of integrations help arm every analyst with the tools they need to succeed.
- [General Purpose](https://www.elastic.co/elastic-stack): Choose this option if you aren’t certain yet what kind of deployment you want.

:::image type="content" source="../media/elastic-cloud-deployment-options.png" alt-text="Image of the four Elastic deployment options.":::

## Set the size and location for your deployment

The region you select for your deployment is important when coordinating with other Azure resources and planning overall performance, as some regions have more availability zones, support different compliance requirements, and offer lower pricing. Some services are only available in certain regions.

If you’re unsure what you need when you start, that’s okay. Elastic Cloud lets you customize your deployment once it's been created, so if you do need to change zones down the road, you can come to your deployment in Elastic Cloud and edit the number of zones.

## Get the latest Elastic version and updates by default

Elastic Cloud receives the latest versions of Elastic on day one. That means the latest version will always be selected, allowing you to take full advantage of the latest features and security updates. However, if you need to deploy a different version that's compatible with existing environments, you can choose to do so.

Once deployed, upgrades are simple to execute, making it easy to take advantage of newer features and the latest security patches the day they are released. You should receive email notifications as new releases are made available.

## Customize your deployment

While it's possible to customize your deployment, it's outside the scope of this learning module. Check out the resources in the summary unit to find more information.

## Estimate how much Elastic you need to start

Elastic Cloud on Azure makes it easy for users to start at any size of deployment and monitor resource usage with out-of-the box deployment performance metrics to make the decision to grow or shrink the deployment. Elastic Cloud's autoscaling feature offloads operational burden from users.

For use cases where users need to have a better idea of how much Elastic they need before starting with Elastic Cloud, [Rally](https://github.com/elastic/rally) (a macro benchmarking framework by Elastic) is a tool that many users use to test the performance of a self-managed Elastic deployment and iteratively tune it to be more precise about required capacity.

There are a few general best practices to note:

- **Multi-zone deployments**: By default, Elastic Cloud selects two availability zones for your deployment. This is helpful to ensure there's protection against interruptions in the underlying infrastructure rather than if the deployment was only a single-zone deployment. You can change to a single-zone deployment for development or less critical data sources, but for most production environments we recommend a two zone deployment at minimum.
- **2 Availability Zones for Kibana**: Kibana is the window into Elastic stack, whether it's the data in Elasticsearch that you're exploring or management of the Elastic components. Given its value to all the Elastic use cases, we recommend selecting two availability zones for Kibana to provide uninterrupted access to Elastic. For the deployments where Kibana isn’t exposed to end users, the default single-zone deployment is sufficient.  
