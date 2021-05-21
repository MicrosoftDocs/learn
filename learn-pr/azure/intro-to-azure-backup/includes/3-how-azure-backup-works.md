<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.

    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how <features> of <product> work to <solve problem>."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).

    Heading: none

    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"
-->
Let's take a look at how Azure Backup works to provide the data protection you need. You'll learn how the different aspects of the backup service make it easy to backup various types of data and how it offers security for your backups as well. We'll discover these aspects of the Azure Backup Service:

* Workload integration layer - Backup Extension. Integration with the actual workload (such as Azure VM or Azure Blobs) happen at this layer.
* Data Plane- Access Tiers. Three access tiers where the backups could be stored:
    * Snapshot tier: in customer’s subscription
    * Standard tier
    * Archive tier
* Data Plane- Availability and Security. The backup data is replicated across zones or regions (based on the redundancy specified by the user).
* Management Plane – Recovery Services vault/ Backup Vault and Backup Center. Vault provides an interface for the user to interact with the backup service.

<!-- 2. Chunked content-------------------------------------------------------------------------------------

    Goal:
        Cover the components of <product> and how they work.
        Repeat this pattern multiple times as needed.

    Pattern:
        Break the content into 'chunks' where each chunk has three things:
            1. An H2 or H3 heading describing the goal of the chunk.
            2. 1-3 paragraphs of text, with a strong lead sentence in the first paragraph.
            3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

<!-- Pattern for simple topic -->
## Workload integration layer - Backup Extension
A backup extension specific to each workload is installed on the source VM or a worker VM. At the time of backup (as defined by the user in the Backup Policy), the backup extension generates the backup which could be:

* storage - snapshots in case of Azure VM or Azure Files.

* stream backup in case of databases like SQL or HANA running in VMs.

The backup data is eventually transferred to data plane (Azure Backup managed storage) via secure Azure networks (NSG, Firewalls or more sophisticated Pvt end points).

Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

## Data Plane- Access Tiers
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

## Data Plane- Availability and Security
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

## Management Plane – Recovery Services vault/ Backup Vault and Backup Center
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex topic -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list, code sample, blockquote)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->