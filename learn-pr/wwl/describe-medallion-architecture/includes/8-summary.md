The **medallion architecture** organizes a Fabric lakehouse into three progressive layers. The **bronze layer** preserves raw data exactly as it arrives — a permanent source of truth you can always reprocess from. The **silver layer** cleans and integrates that data: standardizing formats, removing nulls, deduplicating, and joining sources into a reliable dataset. The **gold layer** models data for consumption — shaped for the specific audience, whether that's a star schema for reporting, a flat table for data science, or pre-aggregated summaries for a business team.

When planning the implementation in Fabric, you structure your lakehouse using schemas — `bronze`, `silver`, and `gold` — which keep tables organized and let you set different access permissions per layer. For ingestion into bronze, OneLake shortcuts let you reference cloud storage data in place without copying; pipelines, dataflows, and notebooks handle other sources. For silver and gold transformations, you choose based on complexity: dataflows for simple low-code work, notebooks for custom logic, and materialized lake views when your transformation can be expressed as SQL and you want Fabric to manage incremental refresh automatically.

Gold layer data is served two ways: through the SQL analytics endpoint for anyone who wants to write T-SQL directly, and through a Power BI semantic model for report builders. Semantic models use Direct Lake mode, which reads directly from Delta files in OneLake so reports stay current without a separate refresh step.

Securing a medallion architecture means matching access boundaries to layer ownership. OneLake data access roles let you scope permissions to specific tables within a shared lakehouse, so gold layer consumers can't see bronze or silver data. For stricter isolation, separate workspaces give each layer its own capacity and role assignments. Git integration keeps your pipeline code, notebooks, and schema definitions versioned together — so a bad deployment is reversible, and changes can be promoted from development to production through deployment pipelines.

Ready to build your own? Start by [creating a Fabric lakehouse](/fabric/onelake/create-lakehouse-onelake?azure-portal=true) and setting up your bronze, silver, and gold schemas.

## Learn more

- [OneLake shortcuts](/fabric/onelake/onelake-shortcuts)
- [Materialized lake views tutorial](/fabric/data-engineering/materialized-lake-views/tutorial)
- [Direct Lake overview](/fabric/fundamentals/direct-lake-overview)
- [Introduction to Git integration in Fabric](/fabric/cicd/git-integration/intro-to-git-integration)