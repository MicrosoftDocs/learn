To prepare for executing your digital-transformation strategy, it's important to understand the technical considerations that drive the implementation of the strategy. This unit helps you evaluate those technical considerations through the selection and completion of your first technical project.

## How does cloud pricing work?

Cloud costs are tied to compute and storage and include the underlying software licensing fees. The cloud uses a pay-for-what-you-consume model versus the up-front server infrastructure and software licensing costs that you would typically pay on-premises in your data center. On-premises, you typically have a combination of upfront costs and operating expenditures. When you move to the cloud, you shift to the pay-as-you-consume model and mainly operating expenditures.

To take advantage of the best pricing in the cloud, you must understand how you consume resources for your specific workloads. Once you have a consumption plan, you can establish your fixed- and variable-cost models to maximize your investment.

## Understand your workloads

On-premises, your architecture is typically provisioned for peak capacity. Migrating from on-premises to the cloud gives you the flexibility of scalability, and you can scale up and down as needed. It’s critical to understand your workloads to realize the full benefits of the cloud.

**Idle capacity**: Azure helps eliminate the idle capacity created by overprovisioned architecture for coverage during peak usage. Rightsizing and eliminating workloads you don’t need helps reduce your idle capacity when moving to the cloud. This exercise delivers immediate savings and cash flow reductions.

**Unpredictable workloads**: You can scale your compute resources up and down in the cloud as the demands of your business change. You're able to scale your capacity up and down and use a variable-cost model as opposed to a fixed-cost model. This elasticity of the cloud makes the pay-for-what-you-consume model possible and works well for your unpredictable workloads. Consider using virtual machine scale sets and snoozing VMs to only pay for the resources you need when you need them.

**Predictable workloads**: For your predictable workloads, you can take advantage of the cost-savings offers such as Azure Reservations.

:::image type="content" source="../media/capacity-usage-optimization.png" alt-text="Image of a capacity usage optimization chart." border="false":::

**Initial clean-up, right-sizing, and optimization**: When planning to move to Azure, review which workloads are no longer needed. This process of cleanup can help you build a stronger business case and show an immediate effect on your budgets. For workloads you still want to use and bring to the cloud, you can use tools to help optimize them, like Azure Migrate.

## Take advantage of cost-savings offers

Cloud billing models and offers differ from on-premises, and they can create meaningful savings opportunities for you to reduce cloud costs. Saved costs from cloud adoption can be reinvested into iterative modernization. Cloud costs are flexible and can be reduced with:

**Azure Hybrid Benefit**: Reduce the costs of running your workloads in the cloud by using this licensing benefit. You can use your on-premises Software Assurance-enabled Windows Server and SQL Server licenses on Azure. This benefit applies to RedHat and SUSE Linux subscriptions, too. To learn more, see [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit?azure-portal=true).

**Azure Spot Virtual Machines**: You can use Spot Virtual Machines with deep discounts for workloads that can be interrupted and don't need to complete within a specific time frame. For example, high-performance computing scenarios, batch processing jobs, or visual rendering applications. Also, dev and test environments, including continuous integration and continuous delivery workloads, or large-scale stateless applications. To learn more, see [Spot Virtual Machines](https://azure.microsoft.com/pricing/spot?azure-portal=true).

**Reservations**: Receive a discount on your workloads when you reserve your resources in advance. In return, Microsoft passes the savings on to you as discounts of up to 72 percent. For more information, see [Azure reservations](https://azure.microsoft.com/reservations?azure-portal=true).

**Azure Dev/Test pricing**: Take advantage of discounted rates for your development and testing. Including, the Microsoft software charges on Azure Virtual Machines and special dev and test pricing on other services. For more information, see [Azure Dev/Test pricing](https://azure.microsoft.com/pricing/dev-test/#overview?azure-portal=true).

**Extended security updates**: Receive continued support in the cloud for SQL Server 2008 and SQL Server 2008 R2 that have reached the end of their support lifecycle. You can migrate your on-premises SQL Server instances to Azure Virtual Machines, Azure SQL Database, or stay on-premises and purchase extended security updates. You receive free extended security patches by migrating to an Azure Virtual Machine. To learn more, see [Lifecycle FAQ: Extended Security Updates](/lifecycle/faq/extended-security-updates?azure-portal=true).

## Continually optimize your environment

Microsoft provides frameworks and tools to help you understand your costs and continually optimize your environment:

Learn more:

- Read about [Azure Advisor](/azure/advisor/advisor-overview?azure-portal=true)
- Get Azure [Advisor cost recommendations](/azure/advisor/advisor-cost-recommendations?azure-portal=true)
- Learn about the [Microsoft Azure Well-Architected Review](/assessments/?mode=pre-assessment&session=local?azure-portal=true)
- Learn about the [Microsoft Azure Well-Architected Framework](/azure/architecture/framework?azure-portal=true)

Understand and forecast your costs: Monitor your bill, set budgets, and allocate costs to teams and projects with Microsoft Cost Management.

Learn more:

- [Optimize costs from recommendations](/azure/cost-management-billing/costs/tutorial-acm-opt-recommendations?azure-portal=true)
- [Prevent unexpected charges](/azure/cost-management-billing/cost-management-billing-overview)
- Cost-optimize your workloads: Optimize your resources and architecture with Azure best practices from Azure Advisor and the Microsoft Azure Well-Architected Framework

Save with Azure offers and licensing terms like the Azure Hybrid Benefit and Azure Reservations.

Learn more:

- Learn about the [Azure Hybrid Benefit](https://azure.microsoft.com/pricing/hybrid-benefit?azure-portal=true)
- Learn about [Azure Hybrid Benefit for Windows Server](https://azure.microsoft.com/overview/azure-vs-aws/cost-savings?azure-portal=true)
- Review [pricing guidance for SQL Server Azure VMs](/azure/azure-sql/virtual-machines/windows/pricing-guidance?azure-portal=true)
- Learn about [Azure Reservations](/azure/cost-management-billing/reservations/save-compute-costs-reservations?azure-portal=true)
- Read the [reserved instances FAQ](https://azure.microsoft.com/pricing/reserved-vm-instances?azure-portal=true#faq)

Control your costs: Establish spending goals and policies with guidance from the Microsoft Cloud Adoption Framework for Azure. Implement cost controls with Azure Policy, so your teams can go fast while complying with policy. For more information, see [enforce tagging conventions using Azure Policy](/azure/governance/policy/tutorials/govern-tags?azure-portal=true).

## Achieve more with your investment

The goal of your cloud business case is to achieve more with every dollar invested. You can accomplish this goal by releasing committed cash flows and budgets that can be reinvested into further modernization. This concept is the velocity of the dollar; you accelerate value per dollar through phased reinvestment driving modernization and value.

The initial technical benefits of a cloud migration focus on the lift and shift model, where you migrate workloads to infrastructure-as-a-service (IaaS) in the cloud. The goal is to get the most out of your on-premises investment, then move those workloads to IaaS, potentially freeing up cash flow. Historically, this process would be considered a savings opportunity. This approach in the cloud is better viewed as a reinvestment opportunity.

As you free up cash flow, continue your cloud adoption, and mature your workloads, you can reinvest the savings to modernize to different service levels. Once you have your initial workloads in IaaS, you might consider shifting some workloads to platform-as-a-service (PaaS). You can still provide the same type of service delivery; however, you deliver it at a lower cost with more features and functionality. The next step in the iterative modernization process is moving some workflows and line-of-business applications to software-as-a-service (SaaS).

By planning your phases of cloud maturity and the reinvestment of your cloud savings, and aligning with [business outcomes](/azure/cloud-adoption-framework/strategy/business-outcomes?azure-portal=true), you can achieve more with every dollar you invest.

## Hands-on evaluation of technical considerations during your first project

There's a learning curve and a time commitment associated with cloud adoption planning. Even for experienced teams, proper planning takes time. Time to align stakeholders, to collect and analyze data, to validate long-term decisions, and to align people, processes, and technology. In the most productive adoption efforts, planning grows in parallel with adoption, improving with each release and with each workload migration to the cloud. It's important to understand the difference between a cloud adoption plan and a cloud adoption strategy. You need a well-defined strategy to facilitate and guide the implementation of a cloud adoption plan.

Beginning a first adoption process in parallel with developing the plan provides the following benefits:

- Establishes a growth mindset to encourage learning and exploration
- Provides an opportunity for the team to develop necessary skills
- Creates situations that encourage new approaches to collaboration
- Identifies skill gaps and potential partnership needs
- Provides tangible inputs to the plan

## First-project criteria

Your first adoption project should align with your motivations and any defined adoption horizons. Whenever possible, your first project should also demonstrate progress toward a defined business outcome.

## First-project expectations

Your team's first adoption project is likely to result in a production deployment of some kind, but it isn't always the case. Establish proper expectations early. Here are a few wise expectations to set for the first project:

- The project is a source of learning.
- The project might result in production deployments, but it's likely to require more effort first.
- The output of the project is a set of clear requirements to provide a longer-term production solution.

## First-project examples

To support the preceding criteria, this list provides an example of a first project for each motivation category:

- **Critical business events**: When a critical business event is the primary motivation, implementing a tool like Azure Site Recovery might be a good first project. During migration, you would use a tool like Azure Migrate to quickly migrate a few low-impact datacenter assets. But during the first project, you might also first use Site Recovery as a disaster recovery tool. You would be reducing dependencies on disaster recovery assets within the datacenter before pragmatically planning the migration.
- **Migration motivations**: When migration is the primary motivation, it's wise to start with the migration of a noncritical workload. The next module in this learning path, [Migrate to Azure through repeatable processes and common tools](/training/modules/cloud-adoption-framework-migrate?azure-portal=true), teaches the team how to deliver that type of project.
- **Innovation motivations**: When innovation is the primary motivation, the creation of a targeted dev/test environment can be a great first project.

<!-- docutune:ignore "data migration services" -->

Here are other examples of first adoption projects:

- **BCDR**: Beyond Site Recovery, you can implement multiple BCDR strategies as a first project.
- **Nonproduction**: Deploy a nonproduction instance of a workload.
- **Archive**: Cold storage can place a strain on datacenter resources. Moving that data to the cloud is a solid quick win.
- **End of support (EOS)**: Migrating assets that have reached EOS is another quick win that builds technical skills. It also might provide some cost avoidance from expensive support contracts or licensing costs.
- **Virtual desktop interface**: Creating virtual desktops for remote employees can provide a quick win. In some cases, this first adoption project might also reduce dependence on expensive private networks in favor of commodity public internet connectivity.
- **Dev/test**: Remove dev/test from on-premises environments to give developers control, agility, and self-service capacity.
- **Basic applications (fewer than five)**: Modernize and migrate a basic application to quickly gain developer and operations experience.
- **Performance labs**: When you need high-scale performance in a lab setting, use the cloud to quickly and cost-effectively provision those labs for a short time.
- **Data platform**: Create a data lake that has scalable compute for analytics, reporting, or machine learning workloads, and migrate to managed databases by using dump/restore methods or data migration services.

## Align your partner strategy

The Cloud Adoption Framework approaches cloud adoption as a self-service activity. The objective is to empower each of the teams supporting adoption through standardized approaches. In practice, however, you can't assume that a self-service approach is sufficient for all adoption activities.

Successful cloud-adoption programs typically involve at least one level of support. Some cloud-adoption efforts might require support from multiple partners working together toward a common goal.

## Steps to align the partnership strategy

It's important to start aligning your partnership strategy while strategizing adoption. The following steps can help remove roadblocks in later phases of the adoption lifecycle.

- Start to understand support needs
- Consider partnership options that fit your culture and needs
- Evaluate a shortlist of partner options
- Begin contract and paperwork reviews with selected partners

Completing these steps early helps ensure success of the team when the technical efforts begin. The following sections provide guidance for each of these steps:

## Understand support needs

Throughout the cloud adoption lifecycle, various teams might require support to be successful. The following are a few examples of the types of help commonly required.

- **Strategy**: Support defining the business strategy, building a business case, and supporting technology strategy
- **Plan**: Support with discovery of the portfolio, quantitative assessment of the digital estate, development of a cloud adoption plan, and the creation of a skilling plan
- **Ready**: Support deploying a landing zone or full cloud environment capable of supporting the cloud adoption plan
- **Migrate**: Assistance migrating workloads or building a migration factory to ensure sound migration processes
- **Innovate**: Assistance developing new solutions or rebuilding/rearchitecting existing solutions to drive innovation
- **Govern**: Support or ongoing managed services to provide governance and controls across the cloud environment
- **Manage**: Support or ongoing managed services to operate the cloud platform and the workloads hosted in the cloud

Few corporations have the diversity of skills required to support strategy, planning, readiness, adoption, governance, and management. Partners and other support models are often necessary to fill in the gaps in the team's skills and responsibilities.

Various partnership options can help develop needed skills, augment staffing requirements, or completely offload specific processes.

## Partnership options

You aren't alone in your cloud journey. There are several options to support your team throughout your cloud adoption journey.

- **Azure solution providers (partners)**: Get connected with Azure Expert Managed Services Providers (MSPs) and other Microsoft partners who have service offerings aligned to the Cloud Adoption Framework methodologies
- **FastTrack for Azure**: Use the Microsoft FastTrack for Azure program to accelerate migration
- **Azure Migration Program**: The Azure Migration Program aligns a mixture of partners and Microsoft employees to accelerate and support your migration
- **Solution assessments**: Get assistance from a Microsoft Solution Assessment expert or qualified partner as part of a Solution Assessment engagement

## Azure solution providers

Microsoft-certified solution providers specialize in providing modern customer solutions based on Microsoft technologies across the world. Optimize your business in the cloud with help from an experienced partner.

[Find a Cloud Solution Provider (CSP)](https://www.microsoft.com/solution-providers/home). A certified CSP can help you take full advantage of the cloud by assessing business goals for cloud adoption and identifying the right cloud solution to meet your business needs. A CSP can help your business become more agile and efficient.

Azure MSPs undergo a third-party audit to validate a higher tier of capability. They're evaluated on criteria such as, certified staff headcounts, customer references, and annual consumption of Azure at scale.

[Find a managed services partner](https://www.microsoft.com/solution-providers/home?cacheid=16a3b49b-fef2-449d-bdf0-628008114cca?azure-portal=true). An Azure MSP helps a business transition to Azure by guiding all aspects of the cloud journey. A Cloud MSP shows customers all the benefits that come with cloud adoption, from consulting to migrations and operations management. They also act as a one-stop shop for common support, provisioning, and the billing experience, all with a flexible pay-as-you-go business model.

The cloud strategy team should start to identify solution providers that can partner in the delivery of business objectives while developing the cloud-adoption strategy.

## FastTrack for Azure

[FastTrack for Azure](https://azure.microsoft.com/programs/azure-fasttrack?azure-portal=true) provides direct assistance from Azure engineers, working hand in hand with partners, to help customers build Azure solutions quickly and confidently. FastTrack brings best practices and tools from real customer experiences to guide customers from setup, configuration, and development to production of Azure solutions, including:

During a typical FastTrack for Azure engagement, Microsoft helps to define the business vision to plan and develop Azure solutions successfully. The team assesses architectural needs and provides guidance, design principles, tools, and resources to help build, deploy, and manage Azure solutions. The team matches skilled partners for deployment services on request and periodically checks in to ensure that deployment is on track and to help remove blockers.

## Azure Migration Program

[The Azure Migration Program](https://azure.microsoft.com/migration/migration-program?azure-portal=true) provides a mixture of technical skill building, step-by-step guidance, free migration tools, and potential offers to reduce migration costs.

The program uses FastTrack for Azure and Azure solution providers to improve customer success during migration.

Watch this short video to get an overview of how the Azure Migration Program can help you.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4D1vH] 

## Solution assessments

Get assistance from a Microsoft Solution Assessment expert or qualified partner as part of a [Solution Assessment engagement](https://www.microsoft.com/solutionassessments/). Microsoft Solution Assessments can help customers gain a deeper understanding of the opportunities available in their environments to improve productivity, reduce costs, and optimize investments. These assessments use modern tools to collect the customers' data estate, analyze the deployed environment, and provide insights for data-driven recommendations to help customers determine actionable steps for digital transformations, cloud migrations, and process improvement.

## Azure support

If you have questions or need help, [create a support request](https://ms.portal.azure.com/#blade/microsoft_azure_support/helpandsupportblade/newsupportreques?azure-portal=true). If your support request requires deep technical guidance, visit [Azure support plans](https://azure.microsoft.com/support/plans?azure-portal=true) to align the best plan for your needs.

## Shortlist of partner options

During strategy development, it's hard to define specific partnership needs. During development of the cloud adoption plan and skilling plan, those needs come into focus.

But, based on the culture and maturity of your team, it might be possible to decide on a partnership option that is more aligned with your expected needs.

Choose one or more of these partnership options to narrow down the options to investigate first.

## Begin contract and paperwork reviews

As the shortlist of options is reviewed, there's likely to be one or more partners that stand out. If there's a clear leader among the partners, start the process to review contracts and paperwork with the partner.

The contracting process can take time. Reviewing legal terms ahead of time can remove one barrier to engagement when your teams need help the most. Especially, if your company requires vendors to be added to an approved vendor list.

## Record your observations

If you haven't already, download the [Cloud Adoption Framework strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx?azure-portal=true). Under **First adoption project**, use the technical considerations discussed in this unit to define a first project for the team to use when evaluating technical considerations.
