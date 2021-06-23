To prepare for executing your digital transformation strategy, it's important to understand the technical considerations that will drive the implementation of the strategy. This unit helps you evaluate those technical considerations through the selection and completion of your first technical project.

## Hands-on evaluation of technical considerations during your first project

There's a learning curve and a time commitment associated with cloud adoption planning. Even for experienced teams, proper planning takes time, to align stakeholders, to collect and analyze data, to validate long-term decisions, and to align people, processes, and technology. In the most productive adoption efforts, planning grows in parallel with adoption, improving with each release and with each workload migration to the cloud. It's important to understand the difference between a cloud adoption plan and a cloud adoption strategy. You need a well-defined strategy to facilitate and guide the implementation of a cloud adoption plan.

Beginning a first adoption process in parallel with developing the plan provides some benefits. It:

- Establishes a growth mindset to encourage learning and exploration.
- Provides an opportunity for the team to develop necessary skills.
- Creates situations that encourage new approaches to collaboration.
- Identifies skill gaps and potential partnership needs.
- Provides tangible inputs to the plan.

## First-project criteria

Your first adoption project should align with your motivations and any defined adoption horizons. Whenever possible, your first project should also demonstrate progress toward a defined business outcome.

## First-project expectations

Your team's first adoption project likely will result in a production deployment of some kind, but it isn't always the case. Establish proper expectations early. Here are a few wise expectations to set for the first project:

- The project is a source of learning.
- The project might result in production deployments, but it probably will  require additional effort first.
- The output of the project is a set of clear requirements to provide a longer-term production solution.

## First-project examples

To support the preceding criteria, this list provides an example of a first project for each motivation category:

- **Critical business events**: When a critical business event is the primary motivation, implementing a tool like Azure Site Recovery might be a good first project. During migration, you would use a tool like Azure Migrate to quickly migrate a few low-impact datacenter assets. But during the first project, you also might first use Site Recovery as a disaster recovery tool. You would be reducing dependencies on disaster recovery assets within the datacenter before pragmatically planning the migration.

- **Migration motivations**: When migration is the primary motivation, it's wise to start with the migration of a noncritical workload. The next module in this learning path, [Migrate to Azure through repeatable processes and common tools](/learn/modules/cloud-adoption-framework-migrate/), teaches the team how to deliver that type of project.

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

## Record your observations

If you haven't already, download the [Cloud Adoption Framework strategy and plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx?azure-portal=true). Under **First adoption project**, use the technical considerations discussed in this unit to define a first project for the team to use to evaluate technical considerations.