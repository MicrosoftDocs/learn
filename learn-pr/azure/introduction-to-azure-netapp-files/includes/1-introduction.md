<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly orient the learner to the product; what category of problem does it solve?

    Heading: none

    Example: "Implementing a business process can be challenging because you typically need to make diverse services work together. Think about everything your company uses to store and process data: Salesforce, Microsoft 365, Oracle, Twitter, YouTube, Dropbox, Google services, Azure Cognitive Services, and so on. How do you integrate all these products? Azure Logic Apps gives you pre-built components to connect to hundreds of services. You use a graphical design tool to put the pieces together in any combination you need and Logic Apps will run your process automatically in the cloud."

    Recommended: visual like an image (preferred), table, list, etc.

    [Introduction unit guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-module-introduction-format)
-->
Implementing enterprise-scale workloads and applications requires enterprise-grade storage performance and high availability. Historically, for most organizations, this type of performance could only be achieved using a highly tuned configuration in an on-premises data center. However, such configurations tend to be inflexible, complex, and expensive. A cloud service such as Azure offers flexibility, simplicity, and cost savings for regular workloads.

:::image type="content" source="../media/1-introduction-anf-before.png" alt-text="Diagram depicting a web server cluster running in an on-premises data center and accessing a network access storage device that uses the NFS protocol.":::

How do you migrate mission-critical enterprise workloads to the cloud without sacrificing performance, security, or availability? Azure NetApp Files provides data center-quality performance, robust security, and high availability with all the advantages of the cloud.

:::image type="content" source="../media/1-introduction-anf-after.png" alt-text="Diagram depicting a virtual web server cluster running in an Azure virtual network and accessing NFS file storage using Azure NetApp Files.":::

<!-- 2. Scenario -----------------------------------------------------------------------------------------

    Goal: Describe the real-world scenario you'll use to illustrate the product. Include 2-3 customer tasks that represent the most-common use cases for the product.

    Heading: "## Example scenario"

    Example: "Suppose you work at an athletic shoe company that is launching a new product. You sell the shoes on your website, manage your cloud-hosted advertising videos, and monitor social media to gauge reactions to the launch. The following illustration shows these processes. Notice how the tasks include both customer-facing processes like direct sales and administrative tasks like auto-archiving old videos. Here, you'll see how Logic Apps automates these types of business processes."

    Recommended: an image that visualizes the scenario

    [Scenario guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-scenarios)
 -->

## Example scenario

Suppose you work for a large pharmaceutical enterprise. Your IT department runs a data center with infrastructure to run the company's website, SAP enterprise resource planning (ERP) software, and the high-performance computing (HPC) applications of the research and development department. The website, ERP package, and HPC apps are all crucial to the company's bottom line and its future growth. The massive storage and throughput used by these resources requires a finely tuned data center configuration. However, the downsides of that configuration are high costs, increasing complexity, and a lack of agility. You've been tasked to see if any or all of these enterprise workloads can be migrated to Azure without modification or new code. Here, you'll learn that Azure NetApp Files' low latency and high throughput enable you to match your data center performance, and its built-in data management features provide resilient and elastic cloud workloads.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------------

    Goal: List the activities the learner will do. This differs from the learning objectives. The learning objectives are "outcome focused"; that is, they describe the skills the learner will acquire as a result of consuming this content. By contrast, here you should be specific about what the learning will **do** in order to acquire those skills. The format can be either prose or bulleted-list; however, a list will yield better results when transformed into other output types such as PowerPoint.

    Heading: "## What will we be doing?"

    Example: "We’ll analyze the capabilities of Logic Apps to help you decide when to use them:
                * **Launch**: what conditions can you set to launch your app?
                * **Connect**: which services can you connect to?
                * **Branch**: what types of business logic can you add to your app?"

 -->

## What will we be doing?

We'll examine Azure NetApp Files from several angles to help you decide if you can migrate your enterprise workloads to the cloud:

- **Performance**: What latencies, throughput, and NAS protocols are supported by Azure NetApp Files?
- **Resiliency**: How available are your workloads in Azure NetApp Files?
- **Data management**: What tools does Azure NetApp Files offer to manage and protect your data?

<!-- 4. Terminal learning objective ----------------------------------------------------------------------

    Goal: The title of an "Introduction to <product>" module tells our customers that this is a good place to start their learning. This helps our customers find the right content quickly. The trade-off is that the title does not reflect the terminal learning objective of the module. Here, you explain that this module teaches the 'evaluate' task. To do this, you:
        - Start with your 'evaluate' learning objective
        - Make it a complete sentence if it's not already
        - Use plain language so it sounds conversational
        - Include the lead-in shown below ("By the end...")

    Heading: "## What is the main goal?"

    Example: "By the end of this session, you'll be able to decide whether Logic Apps is a good choice to automate your business processes."

 -->

## What is the main goal?

By the end of this session, you'll be able to evaluate whether Azure NetApp Files is a viable choice for migrating and running your organization's file-based workloads.

<!-- Do **not** include any other content like learning objectives, prerequisites, unit summary, "next unit" lead-in, or references. -->