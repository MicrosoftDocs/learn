To prepare for execution of the strategy, it is important to understand the technical considerations that will drive the implementation of your digital transformation strategy. This unit will help evaluate those technical considerations through the selection and completion of your first technical project.

## Hands-on evaluation of technical considerations during your first project

There's a learning curve and a time commitment associated with cloud adoption planning. Even for experienced teams, proper planning takes time: time to align stakeholders, time to collect and analyze data, time to validate long-term decisions, and time to align people, processes, and technology. In the most productive adoption efforts, planning grows in parallel with adoption, improving with each release and with each workload migration to the cloud. It's important to understand the difference between a cloud adoption plan and a cloud adoption strategy. You need a well-defined strategy to facilitate and guide the implementation of a cloud adoption plan.

Starting a first adoption process in parallel with the development of the plan provides some benefits:

- Establish a growth mindset to encourage learning and exploration.
- Provide an opportunity for the team to develop necessary skills.
- Create situations that encourage new approaches to collaboration.
- Identify skill gaps and potential partnership needs.
- Provide tangible inputs to the plan.

## First project criteria

Your first adoption project should align with your motivations and any defined adoption horizons. Whenever possible, your first project should also demonstrate progress toward a defined business outcome.

## First project expectations

Your team's first adoption project is likely to result in a production deployment of some kind. But this isn't always the case. Establish proper expectations early. Here are a few wise expectations to set:

- This project is a source of learning.
- This project might result in production deployments, but it will probably require additional effort first.
- The output of this project is a set of clear requirements to provide a longer-term production solution.

## First project examples

To support the preceding criteria, this list provides an example of a first project for each motivation category:

- **Critical business events:** When a critical business event is the primary motivation, implementation of a tool, like Azure Site Recovery, might be a good first project. During migration, you would use a tool like Azure Migrate to quickly migrate a few low-impact datacenter assets. But during the first project, you could first use Azure Site Recovery as a disaster recovery tool. Reducing dependencies on disaster recovery assets within the datacenter before pragmatically planning the migration.

- **Migration motivations:** When migration is the primary motivation, it's wise to start with the migration of a noncritical workload. The next module in this learning path, Cloud Migration with the Cloud Adoption Framework, will teach the team how to deliver that type of project.

- **Innovation motivations:** When innovation is the primary motivation, creation of a targeted dev/test environment can be a great first project.

<!-- docutune:ignore "data migration services" -->

Additional examples of first adoption projects include:

- **Business continuity and disaster recovery (BCDR):** Beyond Azure Site Recovery, you can implement multiple BCDR strategies as a first project.
- **Nonproduction:** Deploy a nonproduction instance of a workload.
- **Archive:** Cold storage can place a strain on datacenter resources. Moving that data to the cloud is a solid quick win.
- **End of support (EOS):** Migrating assets that have reached the end of support is another quick win that builds technical skills. It could also provide some cost avoidance from expensive support contracts or licensing costs.
- **Virtual desktop interface (VDI):** Creating virtual desktops for remote employees can provide a quick win. In some cases, this first adoption project could also reduce dependence on expensive private networks in favor of commodity public internet connectivity.
- **Dev/test:** Remove dev/test from on-premises environments to give developers control, agility, and self-service capacity.
- **Simple applications (less than five):** Modernize and migrate a simple application to quickly gain developer and operations experience.
- **Performance labs:** When you need high-scale performance in a lab setting, use the cloud to quickly and cost-effectively provision those labs for a short time.
- **Data platform:** Creating a data lake with scalable compute for analytics, reporting, or machine learning workloads, and migrating to managed databases using dump/restore methods or data migration services.

## Record your observations

If you haven't already, download the [Cloud Adoption Framework Strategy and Plan template](https://raw.githubusercontent.com/microsoft/CloudAdoptionFramework/master/plan/cloud-adoption-framework-strategy-and-plan-template.docx?azure-portal=true). Fill in the section under the "First Adoption Project" header. Use the technical considerations discussed in this unit to define a first project for the team to use to evaluate technical considerations.