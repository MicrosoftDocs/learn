You can use the [Plan methodology](/azure/cloud-adoption-framework/plan/) to rationalize your digital estate, align your organization, adapt roles and skills, plan for sustainability, and avoid common antipatterns.

A cloud adoption plan is an iterative project plan that helps you transition from traditional IT approaches to modern, agile methodologies. This plan aligns your business objectives with technical efforts to help ensure that you manage and communicate transitions effectively.

## Manage your digital estate

The approach that you choose to manage your digital estate depends on your desired outcomes and the size of your existing estate. 

- The [workload-driven approach](/azure/cloud-adoption-framework/digital-estate/approach#workload-driven-approach) assesses high-level architectural complexity. It evaluates aspects such as authentication, data structure, latency requirements, dependencies, and application life expectancy.

- The [asset-driven approach](/azure/cloud-adoption-framework/digital-estate/approach#asset-driven-approach) focuses on the assets that support an application for migration. It pulls statistical usage data from a configuration management database (CMDB) or other infrastructure assessment tools.
- The [incremental approach](/azure/cloud-adoption-framework/digital-estate/approach#incremental-approach) involves gradually assessing and migrating parts of your digital estate so that you can continuously improve and adapt assets.

After you choose an approach, [take inventory of your digital estate](/azure/cloud-adoption-framework/digital-estate/inventory). For analysis and rationalization, collect a list of IT assets that support specific business functions.

Rationalization is the process of assessing your current IT assets to determine the most effective way to host them in the cloud. This process helps you prioritize workloads for migration and develop a clear roadmap for your cloud journey. Incrementally [rationalize your digital estate](/azure/cloud-adoption-framework/digital-estate/rationalize) to reduce risks and manage transitions more efficiently.

## Align your organization

[Align your organization](/azure/cloud-adoption-framework/plan/initial-org-alignment) to help ensure the success of your cloud adoption plan. You should establish a structure where people are accountable for cloud adoption and governance. Initial organizational alignment ensures that you engage the right stakeholders and create a balance between speed and control during the adoption process. Evolve the way that you structure your organization when functions change and your workload scales.

## Adapt roles, skills, and processes

Cloud adoption requires that you [adapt existing roles, skills, and processes](/azure/cloud-adoption-framework/plan/adapt-roles-skills-processes) to support the new environment. You must identify skill gaps and provide training or acquire new talent to fill these gaps. Ensure that your teams can support the digital transformation and manage the cloud environment effectively.

## Migrate your data warehouse

You must thoroughly research and plan your [data warehouse migration](/azure/cloud-adoption-framework/plan/data-warehouse-migration) to avoid unwelcome surprises and unplanned costs. Data warehouse migration to the cloud involves the following steps:

- **Preparation**
   - Ensure that your team is well-versed in Azure cloud fundamentals.
   - Assess your existing data warehouse to understand the architecture, data stores, schema, business logic, data flows, database management system (DBMS) functionality, warehouse operation, and dependencies.
   - Develop pipelines to import data.

- **Migration strategy and implementation**
   - Define a set of objectives that you can use to measure success.
   - Choose your migration approach based on technical considerations, the state of your existing data warehouse, and your business motivations.
   - Define the scope of your migration, including what to migrate and whether to migrate all at once or incrementally.
- **Tasks after migration**
   - Do testing to ensure the success of your migration. Verify schema, data types, user roles, data access security, data quality, ETL processing, and performance.

## Plan for sustainability

Identify your current emissions, and [plan to reduce your carbon footprint](/azure/cloud-adoption-framework/plan/plan-sustainability). For example, you can optimize resource usage and energy consumption. This practice helps you meet corporate social responsibility goals and improve brand reputation and compliance with industry standards. To give your business a sustainability focal point, consider nominating a person to lead your sustainability efforts and teams. 

## Avoid antipatterns

Common [antipatterns](/azure/cloud-adoption-framework/antipatterns/plan-antipatterns) during the planning phase can hinder your cloud adoption efforts. These antipatterns include:
- Choosing the wrong cloud operating model.
- Misaligned operating models.
- Replacing architecture instead of modernizing it.

Recognize and avoid these antipatterns to ensure a smooth and successful cloud adoption process.
