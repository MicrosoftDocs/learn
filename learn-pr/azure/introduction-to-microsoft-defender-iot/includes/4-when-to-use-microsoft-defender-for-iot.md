Now that you know what Defender for IoT is, let's discuss the scenarios best suited for this service.

## When to choose Defender for IoT

The following table describes business needs and applicable scenarios where Defender for IoT may be a good choice for an organization.

|Business need  |Description  |
|---------|---------|
|**Device discovery**     | Defender for IoT's sensor console provides both a **Device inventory** page and a **Device map** page, which provide drill-down data on each of the OT/IoT devices in your network and the connections between them.      |
|**Manage network risks and vulnerabilities**     |  Defender for IoT's **risk assessment reports**, available from each sensor console, help you identify vulnerabilities in your network. <br><br>For example, reports can include unauthorized devices, unpatched systems, unauthorized internet connections, and devices with unused open ports.       |
|**Keep up to date with recent threat intelligence**     |  Make sure that sensors in your network have the most recent **threat intelligence (TI) packages** installed. <br><br>TI packages are provided by Defender for IoT's research team and include recent incidents of concern, common vulnerabilities and exposures (CVEs), and new asset profiles.|
|**Manage sites and sensors**     | In fully on-premises environments, manage OT sensors in bulk using an on-premises management console. <br><br>However, you can also onboard OT sensors to the cloud and manage them from the Azure portal, on the **Sites and sensors** page.       |
|**Run guided investigations for OT entities**     |SOC teams can use the Microsoft Sentinel workbooks provided with the **IoT OT Threat Monitoring with Defender for IoT** solution to run investigations based on open incidents, alert notifications, and activities for OT assets. <br><br>The workbooks also provide a hunting experience across the MITRE ATT&CK® framework for ICS, and are designed to enable analysts, security engineers, and MSSPs to gain situational awareness of OT security posture.         |
|**Automate remediation actions**     |    Use the Microsoft Sentinel playbooks provided with the **IoT OT Threat Monitoring with Defender for IoT** solution to run automated remediation actions as a routine.   |

## When not to choose Defender for IoT

Microsoft Defender for IoT isn't suited for devices that aren't connected to a network. Devices need to be connected to a network in order to be discovered by Defender for IoT sensors and have their traffic analyzed for security risks.

## Is Defender for IoT the right choice?

Let's reconsider our smart building management company from the first unit. The key points from that scenario were:

- Users include both security and operations teams, with officers from both teams needing access to security data
- Users must be able to view all equipment running on the network and communication paths between subsystems
- Users must be alerted about unauthorized actions or unplanned activities occurring on the network
- Users need tools to respond to immediate threats and carry out ongoing operational and network security tasks

Defender for IoT can support all these scenarios and would be a good choice for this organization.


<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'evaluate' learning objective.

    Pattern:
        One paragraph of 2 sentences:
            Sentence 1: State that this unit addresses ("when to use it").
            Sentence 2: State that this unit targets this learning objective: "Evaluate whether (product) is appropriate to (general product use case)."
        Decision criteria as a bulleted list.

    Heading: none

    Example: "Here, we'll discuss how you can decide whether Logic Apps is the right choice for a workflow. We'll list some criteria that indicate whether Logic Apps will meet your performance and functional goals.
        * Integration
        * Performance
        * Conditionals
        * Connectors"
-->
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
        Visual: (image preferred)
-->

<!-- 4. Apply-the-criteria introduction --------------------------------------------------------------------------------

    Goal: Lead-in to the example applications of the criteria.

    Pattern:
        1 paragraph consisting of 3 sentences
            Sentence 1: summarizing the criteria from a positive view ("when to use").
            Sentence 2: Acknowledge that there are cases for which (product) won't work and/or there are edge cases that are difficult to decide.
            Sentence 3: transition/lead-in to the detailed discussion.

    Heading: "## Apply the criteria"

    Example:
        "Apply the criteria"
         "Logic Apps works best when you're integrating multiple services with some added control logic. The decision is often a judgment call though. Let's think about how to apply these criteria to our example processes."
-->

<!-- 5. Apply the criteria examples -----------------------------------------------------------------------------

    Goal: Apply the criteria to the 2-3 customer tasks in the scenario described in your introduction unit.

    Pattern:
        For each customer task, repeat this pattern:
            1. "### Should (scenario subtask) use (product)?".
            2. 1-3 paragraphs of discussion/analysis (first sentence should answer yes/no about whether the product is suitable).
            3. Visual like an image, table, list, code sample, or blockquote.

    Example:
        H3: "Should the video-archive utility use Logic Apps?"
        Prose: "The video archive task is a good fit for Logic Apps even though it doesn't integrate multiple systems. Logic Apps has a built-in timer trigger and an Azure blob connector that are perfect to implement this process...."
        Visual: (image preferred)
-->

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