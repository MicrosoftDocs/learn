<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.

    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how (features) of (product) work to (solve problem)."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).

    Heading: none

    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"
-->
Here is where we will take a look at how Azure Purview works, behind the scenes. You'll learn the core operational theory behind the functioning of Azure Purview for mapping and scanning your data sources. The key areas we will focus on include:

* Sourcing data
* Mapping data
* Scanning data
* Look at metadata

<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of (product) and how they work.
        Repeat this pattern multiple times as needed.

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->
## Sourcing data
Sourcing your data starts with a process where you register data sources. Azure Purview supports an array of data sources that span on-premises, multi-cloud, and software-as-a-service (SaaS) options. You register the various data sources so Azure Purview is aware of them. The data remains in its location and is not migrated to any other platform.

Registering a data source is done from within the Azure portal. Once you have an Azure Purview service configured in Azure, you use Purview Studio to register your data sources.

:::image type="content" source="../media/purview-studio.png" alt-text="Screenshot depicting the basic Purview Studio screen. We see the name of the Purview account along with options to select which include Knowledge center, Register sources, Browse assets, and Manage glossary.":::

Each type of data source you choose, will require specific information to complete the registration. For example, if your data sources reside in your Azure subscription, you will choose the necessary subscription and storage account name.  The following image is an example of choosing an Azure Blob Storage source.

:::image type="content" source="../media/register-sources-form.png" alt-text="Screenshot depicting the dialog to register an Azure Blob Storage source for Azure Purview. The dialog has entries for a name, Azure subscription name and storage account name, an endpoint, and a collection to add the source to.":::

Each data source will have specific requirements for authenticating and configuration, to permit scanning of the assets in that data source. If you have data stored in an Amazon S3 standard bucket, you will need to provide configuration for the connection. For this service, use Purview to provide a Microsoft account with secure access to AWS, where the Purview scanner will run. The Purview scanner uses this access to your Amazon S3 buckets to read your data, and then reports the scanning results, including only the metadata and classification, back to Azure. Use the Purview classification and labeling reports to analyze and review your data scan results.

In Azure Purview, there are a few options to use for authentication when the service needs to scan data sources. Some of these options are:

* Azure Purview Managed Identity
* Account Key (using Key Vault)
* SQL Authentication (using Key Vault)
* Service Principal (using Key Vault)

## Mapping data
A data map is the foundational platform for Azure Purview. Data Map = Data assets + Lineage + Classifications + Business Context. Customers create a knowledge graph of data coming in from a range of sources. Purview makes it easy to register, and automatically scan and classify data at scale. Within the data map, you can identify the type of data source along with other details around security, scanning, etc. The data map allows you to use collections as well.

Collections are a way of grouping data assets into logical collections, (Categories), to simplify management and discovery of assets within the catalog.

Selecting the Map view displays the data sources in a graphical view, along with the collections you have created for them.

:::image type="content" source="../media/data-map-collections.png" alt-text="Screenshot depicting map view of the sources window in Purview Studio. There are three collections listed, each with a single data source, and two other data sources that are not assigned to a collection.":::

## Scanning data
Once you have your data sources registered, you will need to run a scan to be able to access the metadata and browse the asset information. You configure scan rules for the data you want to scan. In an Azure Purview catalog, you can create scan rule sets to enable you to quickly scan data sources in your organization.

A scan rule set is a container for grouping a set of scan rules together so that you can easily associate them with a scan. For example, you might create a default scan rule set for each of your data source types, and then use these scan rule sets by default for all scans within your company. You might also want users with the right permissions to create other scan rule sets with different configurations based on business need.

Scanning the data sources will require the entry of credentials for these sources. You can store the credentials in an Azure Key Vault for security and ease of access by your scan rules. Purview Studio comes with existing system scan rule sets that you can select when creating a new scan rule, or you can specify a custom scan rule set.

:::image type="content" source="../media/scan-rule-sets.png" alt-text="Screenshot depicting the Management panel selected in Purview Studio and the Scan rule sets option also selected.  Displayed is a list of System provided scan rule sets that pre-configured for the various data sources such as Azure File Service, SQL Server, etc.":::

Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

## Metadata
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)
