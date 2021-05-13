<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'evaluate' learning objective.

    Pattern:
        One paragraph of 2 sentences:
            Sentence 1: State that this unit addresses ("when to use it").
            Sentence 2: State that this unit targets this learning objective: "Evaluate whether <product> is appropriate to <general product use case>."
        Decision criteria as a bulleted list.

    Heading: none

    Example: "Here, we'll discuss how you can decide whether Logic Apps is the right choice for a workflow. We'll list some criteria that indicate whether Logic Apps will meet your performance and functional goals.
        * Integration
        * Performance
        * Conditionals
        * Connectors"
-->
Now we'll discuss some scenarios that illustrate when it's appropriate to migrate an on-premises file-based workload to run in the cloud using Azure NetApp Files as shared file storage. Using the energy company as an example, we'll investigate the possible migration of three workloads: your web content, your Microsoft Virtual Desktop deployment, and the HPC applications of your research and development team. Here are the criteria we'll use to help you decide whether Azure NetApp Files is a suitable storage choice for running your organization's file-based workloads in the cloud:

- Ease of migration
- Flexibility
- Workload scale
- Storage technology

<!-- 2. Decision criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the criteria discussion.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: describing the negative ("when not to use") at a high level.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Decision criteria"

    Example:
        "Decision criteria"
         "Logic Apps helps you coordinate the flow of data through disparate systems. The cases where Logic Apps might not be the best option typically involve real-time requirements, complex business rules, or use of non-standard services. Here's some discussion of each of these factors."
-->

## Decision criteria

Azure NetApp Files can handle enterprise-scale, file-based workloads that need little or no reconfiguration and require some deployment flexibility. The use cases where Azure API Management might not be the right choice typically involve small, static, workloads that require block- or object-based storage. Let's take a closer look at these decision criteria.

<!-- 3a. Decision criteria (for simple criteria) ----------------------------------------------------

    Note:
        Choose either 3a or 3b for your content; do not do both.
        This pattern is for simple criteria where the analysis is brief and does not require a visual element.

    Goal: Describe in detail each criterion that helps the "when to use it" decision.

    Heading: none, this content will be the 'body' for the "Decision criteria" heading above.

    Pattern:
        No heading.
        Place both the criteria and analysis into a table.

    Example:
        | | |
        | --- | --- |
        | **Criteria** | **Analysis**|
        | **Integration** | The key question to ask when you're considering Logic Apps is "do I need to integrate services?".... |
        | **Performance** | The next consideration is performance. The Logic Apps execution engine scales your apps automatically.... |
        | **Conditionals** | Logic Apps provides control constructs like Boolean expressions, switch statements, and loops.... |
        | **Connectors** | The last consideration is whether there are pre-built connectors for all the services you need to access. |
        |   |   |
-->

| | |
| --- | --- |
| **Criteria** | **Analysis**|
| **Ease of migration** | Do you need to "lift and shift" your workload? That is, is it a requirement that you transition your workload into the Azure cloud without having to change the components, configuration, or code of your application? A lift-and-shift migration minimizes the risk that your workload will have problems once it starts running in the cloud and it minimizes the costs, effort, and time required to perform the migration. |
| **Workload scale** | What is the overall scale of the workload? Azure NetApp Files works best with enterprise-scale workloads that require the highest performance and availability. Examples include massive database deployments, large-scale virtual desktop infrastructure, and high-performance computing applications. Although Azure NetApp Files can easily support relatively small-scale and low-performance workloads, using an enterprise-level virtual NAS such as Azure NetApp Files in these cases is almost always an economically non-viable solution. |
| **Flexibility** | Does your workload need some flexibility in terms of service level, capacity, and other types of scalability? Azure NetApp Files enables you to change a volume's service level—Standard, Premium, and Ultra—on-the-fly with no service disruption by moving the volume to a capacity pool with the level you want. You can also increase or decrease the size of a capacity pool or volume at any time to match current demand. If you have a manual QoS capacity pool, Azure NetApp Files also enables you to change a volume's throughput as needed by your workload. If your workload consists mostly of static content with relatively constant demand, then the flexibility of Azure NetApp Files is not a consideration. |
| **Storage technology** | Do you require object- or block-based storage? Azure NetApp Files can support any POSIX-compliant workload that requires shared file storage. However, some workloads have a strict dependency or requirement for storage that is both block-based and direct-attached. Since Azure NetApp Files provides a virtual NAS, it isn't suitable for that workload type. However, while historically many workloads have used direct-attached, block-based storage, it's usually not a strict dependency or requirement. In such cases, Azure NetApp Files might provide better performance and scalability because the service is less rate-limited than block-based infrastructure.  |
|   |   |

> [!IMPORTANT]
> Before performing any migration to Azure, you should consider setting up a proof-of-concept application that enables you to assess the Azure NetApp Files performance levels. This test app should be configured with a realistic workload so that you can determine whether Azure NetApp Files provides the IOPS, throughput, and latency levels required by the workload you want to migrate.

<!-- 3b. Decision criteria (for complex criteria) ----------------------------------------------------------

    Note:
        Choose either 3a or 3b for your content; do not do both.
        This pattern is for complex criteria where the analysis of each criterion needs both and a visual element.

    Goal: Describe in detail each criterion that helps the "when to use it" decision.

    Pattern:
        For each criterion, repeat this pattern:
            1. H3 of the criterion.
            2. 1-3 paragraphs of discussion/analysis.
            3. Visual like an image, table, list, code sample, or blockquote.
            
    Example:
        H3: "Integration"
        Prose: The key question to ask when you're considering Logic Apps is _"do I need to integrate services?"_ Logic Apps work well when you need to get multiple applications and systems to work together. That's what they were designed to do. If you're building an app with no external connections, Logic Apps is probably not the best option."
        Visual: <image preferred>
-->

<!-- 4. Apply-the-criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the example applications of the criteria.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: Acknowledge that there are cases for which <product> won't work and/or there are edge cases that are difficult to decide.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Apply the criteria"

    Example:
        "Apply the criteria"
         "Logic Apps works best when you're integrating multiple services with some added control logic. The decision is often a judgment call though. Let's think about how to apply these criteria to our example processes."
-->

## Apply the criteria

Azure NetApp Files is the right choice for shared network storage when file-based, enterprise-scale, elastic workloads need to be "lifted-and-shifted" into Azure. However, these criteria don't apply equally to all uses. Let's examine how these criteria apply to our scenario's use cases.

<!-- 5. Apply the criteria examples -----------------------------------------------------------------------------

    Goal: Apply the criteria to the 2-3 customer tasks in the scenario described in your introduction unit.

    Pattern:
        For each customer task, repeat this pattern:
            1. "### Should <scenario subtask> use <product>?".
            2. 1-3 paragraphs of discussion/analysis (first sentence should answer yes/no about whether the product is suitable).
            3. Visual like an image, table, list, code sample, or blockquote.

    Example:
        H3: "Should the video-archive utility use Logic Apps?"
        Prose: "The video archive task is a good fit for Logic Apps even though it doesn't integrate multiple systems. Logic Apps has a built-in timer trigger and an Azure blob connector that are perfect to implement this process...."
        Visual: <image preferred>
-->

### Should the web team use Azure NetApp Files?

A web content deployment is often a good candidate for migration to the cloud because the on-premises deployment likely runs in a Linux environment with POSIX-compliant permissions. As such, the deployment can be lifted-and-shifted into Azure with the web content and code stored in an Azure NetApp Files volume. The website of our energy company consists of a large number of pages that describe the company's technologies, products, research, papers, and customer stories. The static nature of the content and the relatively constant level of demand are arguments against using Azure NetApp Files. However, the massive scale of the company's web content is sufficient to justify an Azure NetApp Files instance. In this case, the company should probably go with a capacity pool that uses the Standard tier, which provides more than enough throughput and IOPS for their web presence.

The following image depicts a typical setup for running a web server in an Azure virtual network with Azure NetApp Files as the shared storage.

:::image type="content" source="../media/4-when-to-use-azure-netapp-files-web.png" alt-text="Network diagram depicting a typical setup for running a web server in an Azure virtual network with Azure NetApp Files as the shared storage for the server.":::

### Should the Windows Virtual Desktop team use Azure NetApp Files?

Azure NetApp Files can provide up to 450,000 IOPS and sub-millisecond latency, which means it can provide storage for large-scale Windows Virtual Desktop (WVD) deployments. By taking advantage of the Azure NetApp Files features that enable you to change the throughput and choose a different service tier for your volumes on demand without service disruptions, you can quickly and easily optimize the scale of your WVD deployment to control costs. And by creating frequent manual or automatic volume snapshots, you can roll back individual FSLogix user profile containers when needed and you can even revert entire volumes.

Our energy company has several thousand employees within its WVD deployment, with each user given a virtual personal desktop. This large-scale deployment can be lifted-and-shifted into Azure and optimized for throughput as needed. For optimum performance, the company should probably go with a capacity pool that uses the Premium tier, which provides 64 MiB/s throughput and 450,000 IOPS.

The image below depicts one possible architecture the company could use for a personal desktop-based WVD deployment. Users are mapped to specific desktop pods, where a *pod* is a spoke virtual network with a pool of virtual machines and an Azure NetApp File designated subnet that uses a volume from the overall Azure NetApp Files capacity pool. Each pool has just under 1,000 virtual machines—one for each user. Azure NetApp Files can easily handle that many personal desktops per single-session host pool VNet. If more personal desktops are needed, it's easy to add more pods.

:::image type="content" source="../media/4-when-to-use-azure-netapp-files-wvd.png" alt-text="Network diagram depicting a typical setup for running several pools of Windows Virtual Desktops in an Azure virtual network with Azure NetApp Files providing shared storage for each virtual desktop pool.":::

### Should the research and development team use Azure NetApp Files?

Our energy company's research and development (R&D) team is responsible for a variety of innovative work, including the following tasks:

- Inventing new wind- and solar-powered products.
- Optimizing the company's existing renewable energy products.
- Creating renewable energy technologies that can be licensed to other companies.
- Advancing the science behind the company's renewable energy products.
- Investigating other possible sources of renewable energy.

Most of these tasks require compute- and data-intensive operations such as computer aided design, 3D modeling, and detailed simulations. As such, they require very high IOPS, low latency, and high availability. These tasks often create extreme usage swings, where usage is very high during, say, a complex simulation, then down to almost nothing when the simulation ends. R&D team members require mixed SMB/NFS protocol access with POSIX compliance. All of these considerations work in favor of migrating the R&D team's applications to Azure and using Azure NetApp Files as the shared storage service. In this case, the company would require a capacity pool that uses the Ultra tier with its 128 Mib/s throughout and 450,000 IOPS.

The image below depicts a possible setup for running a high-performance computing application in an Azure virtual network with Azure NetApp Files as the shared storage for the application. An R&D team member accesses the front end through a Windows or Linux virtual machine. The HPC application runs in the Compute subnet, which consists of a scale set of Linux virtual machines. The shared storage for the scale set comes from a designated subnet containing an Azure NetApp Files instance.

:::image type="content" source="../media/4-when-to-use-azure-netapp-files-hpc.png" alt-text="Network diagram depicting a typical setup for running a high-performance computing application in an Azure virtual network with Azure NetApp Files as the shared storage for the application.":::

<!-- 6. Guidance summary (optional) ------------------------------------------------

    Goal: Job-aid for future use to help customers evaluate their own tasks against the criteria.

    Pattern:
        1. Heading "## Guidance summary"
        2. Lead-in sentence acknowledging that this is a summary/repeat of previous material.
        3. Visual like a flowchart (as an image) or rubric (as a table).

    Example:
        "The following flowchart summarizes the key questions to ask when you're considering using Logic Apps."
        <flowchart image>
-->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->