<!-- 1. Topic sentence(s) ---------------------------------------------------------------

    Goal: briefly state that this unit will define the product.

    Heading: none

    Example: "Let's start with a few definitions and a quick tour of the core features of Logic Apps. This overview should help you see whether Logic Apps might be a good fit for your work."
-->
Let's start with a few definitions and a quick tour of the core features of Azure Purview. We won't list every possible feature of the service here but we will introduce you to the key features.

<!-- 2. Background-concept definitions (optional) ----------------------------------------

    Goal:
        Define any needed underlying concepts or terms the learner must know to understand the product.
        Repeat this pattern multiple times if multiple concepts are needed.

    Heading:
        "## What is (concept)?"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "(concept) is..." (ensure this is a definition, do not give use cases like "(concept) lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        (Note: the product "Logic Apps" implements business processes in the cloud; therefore, "business process" is a background concept.)
        Heading: "What is a business process?
        Lead sentence: "A business process or _workflow_ is a sequence of tasks that produce a specific outcome. The result might be a decision, some data, or a notification...."
-->
## What is Azure Purview?
Azure Purview is a unified data governance service that helps you manage and govern your on-premises, multi-cloud, and software-as-a-service (SaaS) data. Easily create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. Empower data consumers to find valuable, trustworthy data.

The main elements are the Azure Purview Data Map, Purview Data Catalog, and Purview data insights. Azure Purview Data Map powers the Purview Data Catalog and Purview data insights as unified experiences within the Purview Studio.

:::image type="content" source="../media/data-map-sources.png" alt-text="Screenshot depicting the data map view in Azure Purview with data sources from Azure Data Lake Storage, Azure Files, CosmosDB, Azure Blob storage, and Azure SQL Database on the map.":::

<!-- 3. Define the product -------------------------------------------------------------

    Goal:
        Give a formal and precise definition of the product.

    Heading:
        "## (product) definition"

    Pattern:
        1. H2 heading.
        2. Lead sentence that gives a definition "(product) is..." (ensure this is a definition, do not give use cases like "(product) lets you...").
        3. Additional text as needed (typically 1-3 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "Azure Logic Apps definition"
        Lead sentence: "Azure Logic Apps is a cloud service that automates the execution of your business processes."
-->
## Azure Purview definition
Azure Purview is a data governance solution. It helps customers gain deep knowledge of all their data while maintaining control over its use. With Azure Purview, organizations discover and curate data. They gain insights into their data estate, and centrally govern access to data.

Azure Purview is designed to help enterprises get the most value from their existing information assets. It is a cloud-based service where you can register your various data sources with Azure Purview. Registering your data in Azure Purview helps in the discovery and understanding of data sources. Your data sources remain in place but a copy of the metadata for the source, is added to Azure Purview.

:::image type="content" source="../media/register-sources.png" alt-text="Screenshot depicting the register sources dialog for Azure Purview data map. It displays some of the supported data sources such as Azure Blob Storage, Cosmos DB, Amazon S3, and Azure SQL Database, among others. The displayed list is also not comprehensive.":::

<!-- 4. Solve the scenario -------------------------------------------------------------

    Goal:
        At a high level, describe how the (product) solves one of the customer tasks in your (scenario).
        Avoid teaching how to actually do the work (you're not teaching how-to-use in this module).

    Heading:
        "## How to (solve scenario)"

    Pattern:
        1. H2 heading.
        2. Lead sentence that summarizes how the (product) solved the (scenario).
        3. Additional text as needed (typically 1-2 paragraphs total, integrate the lead sentence into the first paragraph).
        4. Visual like an image, table, list, code sample, or blockquote (image preferred).

    Example:
        Heading: "How to implement a Twitter monitor"
        Lead sentence: "To implement a Twitter monitor, you map each task to a Logic Apps component and connect them with conditional logic."
-->
## How to track you data sources
Tracking your data sources starts with registering the sources with Azure Purview. Once you have the data sources registered, Azure Purview can scan generate a map view in Azure Purview Studio.

:::image type="content" source="../media/register-sources-form.png" alt-text="Screenshot depicting the dialog to register an Azure Blob Storage source for Azure Purview. The dialog has entries for a name, Azure subscription name and storage account name, an endpoint, and a collection to add the source to.":::

Once you have your sources registered, you can view the map or a table view listing each registered data source. To better align your views with a grouping strategy, you can also create collections to contain related data sources.

:::image type="content" source="../media/collections.png" alt-text="Screenshot depicting a configured set of collections in a hierarchy with Fabrikam listed as the parent collection to Finance, and an Azure Blob storage data source in the Finance collection.":::
