::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=69367515-9ba8-4284-902d-a324e83fa921]

::: zone-end

::: zone pivot="text"

Before exploring how large-scale analytics solutions are built, let's introduce the two main analytics platforms on Azure you'll encounter throughout this module.

**Microsoft Fabric** is Microsoft's unified software-as-a-service (SaaS) analytics platform. It brings data engineering, data warehousing, real-time analytics, data science, and Power BI together in a single browser-based workspace on top of one shared storage layer called **OneLake**. You don't manage servers or clusters—you create workspaces and items, and Microsoft runs the infrastructure.

**Azure Databricks** is a cloud analytics platform built on Apache Spark. It's optimized for large-scale data engineering, data science, and SQL analytics over open lakehouse formats. It uses **Delta Lake**—an open-source storage format that adds transactions, schema enforcement, and versioning on top of Parquet files—giving you lakehouse-style reliability at scale. Databricks runs as a managed service inside your Azure subscription and is a common choice for teams that need code-first Spark and notebook-based workflows.

## Large-scale analytics

Large-scale data analytics solutions combine conventional data warehousing used to support business intelligence (BI) with techniques used for so-called "big data" analytics. A conventional **data warehousing** solution typically involves copying data from transactional data stores into a relational database with a schema that's **optimized for querying** and building multidimensional models. Big data processing solutions are used with large volumes of data in multiple formats, which is **batch loaded** or captured in **real-time streams** and stored in a **data lake** from which distributed processing engines like **Apache Spark** process it. 

![Diagram explaining large-scale data analytics solutions.](../media/large-scale-analytics.png)

The combination of flexible data lake storage and data warehouse SQL analytics has led to the emergence of a large-scale analytics design often called a **data lakehouse**.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
