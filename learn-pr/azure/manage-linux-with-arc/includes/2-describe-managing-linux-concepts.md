Azure Arc lets you manage physical and virtual Linux machines hosted outside of Azure, on your corporate network, or other cloud provider. Organizations like Contoso can manage their Linux resources with Azure just as they do their Arc-enabled Windows machines. Linux machines onboarded to Azure Arc enjoy the same capabilties as native Azure machines, including standard Azure constructs such as Asure policy and applying tags.

Once your Linux machines are onboarded to Azure Arc, you can:

- Proactively monitor the OS and workloads running on the machine
- Manage the machines using automation runbooks or solutions like Update Management
- Use other Azure services such as Microsoft Defender for Cloud

## Azure Automation

Linux machines onboarded to Azure Arc can use Azure Automation for frequent, time-consuming tasks.
<!--> using PowerShell and runbooks. You can assess configuration changes for installed software, Microsoft services, and Linux daemons using Change Tracking and Inventory.-->

### Change tracking and inventory

You can track changes in your Azure Arc Linux machines to help you pinpoint operational and environmental issues. Items that are tracked by the Change Tracking and Inventory feature include:

- Linux software (packages)
- Linux files
- Linux daemons

### Update Management

Your onboarded Linux machines can use Update Management to manage operating system updates. You can quickly assess the status of available updates and manage the process of installing required updates for your Linux machines. Update Management integrates with Azure Monitor Logs to store update assessments and update deployment results as log data.

### Automation runbooks




<!--
Contoso is currently using Azure Arc to manage Windows servers in many locations, including multiple clouds. You have been tasked by management to learn about Azure Arc capabilities for managing Linux. You need to understand how to manage small numbers of Linux machines and also determine options for managing large populations of Linux devices. Several Linux systems have been onboarded to your Azure Arc solution and now you need to understand how to manage them.

After completing this unit, you should be able to describe how to manage Linux systems with Azure Arc and the cross-team coordination required to deploy the solution. 
 
Key content per learning objective 
Describe Linux with Azure Arc. 
When to use 
Key components 
Describe how managing Linux with Azure Arc relates to the scenario 
New capabilities gained with Azure Arc that are not otherwise available 


-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
TODO: add your topic sentences(s)

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
TODO: add your scenario sub-task

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
TODO: write your prose table-of-contents

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
TODO: add a visual element

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->