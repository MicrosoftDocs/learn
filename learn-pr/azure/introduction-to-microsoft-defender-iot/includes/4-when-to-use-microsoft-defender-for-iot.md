Here we'll discuss the main Defender for IoT capabilities. After reading this, you’ll be able to determine if Defender for IoT will meet your security and operational goals.

## Discover your network  -  Device inventory  

You cannot protect what you do not know you have. The Defender for IoT Device inventory provides drill down information on IoT/OT devices in your network. View device details such as IPs and vendors, and gain insight into other information such as related protocols, firmware, information on alerts related to the device and more.  

## Support proprietary protocols  - Horizon

Proprietary protocols are created by  OT vendors for the devices or operating system that they develop. Use the Defender for IoT Horizon Open Development Environment (ODE) SDK to create proprietary plugins. Working with plugins helps you secure OT and ICS devices running proprietary protocols and exponentially expands OT visibility and control over vendor specific protocols.

Plugins can be developed without:

- Revealing any proprietary information about how protocols are defined.
- Sharing sensitive PCAPs.
- Violating compliance and privacy regulations.

Customization options enable:

- Text for function codes.
- Full localization text for alerts, events, and protocol parameters. 


## View device connections and Purdue levels - Asset map  

If you’re implementing a Zero Trust policy, you need to know how devices are connected so you can segment them onto their own network and manage granular access to them.  The Defender for IoT Device map lets you visualize OT device connection paths,  IoT/OT network topologies and Purdue levels mapping. 

## Manage network risks and vulnerabilities - Risk Assessment Reports

Microsoft Defender for IoT helps you identify vulnerabilities such as unauthorized devices, unpatched systems, unauthorized internet connections, and devices with unused open ports—so you can take a prioritized approach to mitigating IoT/OT risk for your crown jewel assets. These are the critical devices whose compromise would have a major impact on your organization, such as a safety incident, loss of revenue, or theft of sensitive IP. 

## Continuously monitor and respond to threats – Security Alerting

Threat intelligence is curated by IoT/OT security experts. Developed and curated by Microsoft’s Section 52, the security research group for Azure Defender for IoT, Defender for IoT, Threat Intelligence (TI)  update packages include the latest:

- IOCs such as malware signatures, malicious DNS queries, and malicious IPs
- CVEs to update our IoT/OT vulnerability management reporting
- Asset profiles to enhance our IoT/OT asset discovery capabilities

Section 52 is comprised of IoT/OT-focused security researchers and data scientists with deep domain expertise in threat hunting, malware reverse engineering, incident response, and data analysis devices.

## Ensure operational efficiency  -Operational Alerting

When you have malfunctioning or misconfigured equipment, you need to quickly figure out what went wrong. By providing deep visibility into what’s going on in the network—such as a misconfigured engineering workstation that’s constantly scanning the network—you can help your IoT/OT engineers quickly identify and address the root cause of those issues. 

## Achieve Unified IT/OT security monitoring and governance  

Microsoft Defender for IoT is deeply integrated with Microsoft Sentinel and also supports third-party tools such as Splunk, IBM QRadar, and ServiceNow. This helps break down silos that slow communication between IT and OT teams and creates a common language between them to quickly resolve issues. It also enables you to quickly address attacks that cross IT/OT boundaries (like TRITON), as well as leverage the workflows and training you spent years building in your security operations center (SOC)—so you can apply them to IoT and OT security as well.

## Integrate with Microsoft Sentinel 

By bringing rich telemetry into Microsoft Sentinel from Microsoft Defender for IoT, SOC teams can bridge the gap between IT and OT security sectors. This allows SOC teams to detect and respond faster during the entire attack timeline—enhancing communication, processes, and response time for both security analysts and OT personnel. 

## Leverage Sentinel to take action 
 
Microsoft Sentinel workbooks, analytics rules, and SOAR playbooks help you monitor and respond to OT threats detected in Defender for IoT. 

### Workbooks 
 
To visualize and monitor your Defender for IoT data, use the workbooks deployed to your Microsoft Sentinel workspace as part of the IoT OT Threat Monitoring with Defender for IoT solution.  Defenders for IoT workbooks provide guided investigations for OT entities based on open incidents, alert notifications, and activities for OT assets. They also provide a hunting experience across the MITRE ATT&CK® framework for ICS, and are designed to enable analysts, security engineers, and MSSPs to gain situational awareness of OT security posture. 

### Analytics rules 
 
Create Microsoft Sentinel incidents for relevant alerts generated by Defender for IoT, either by using out-of-the-box analytics rules provided in the IoT OT Threat Monitoring with Defender for IoT solution, configuring analytics rules manually, or by configuring your data connector to automatically create incidents for all alerts generated by Defender for IoT. The rules are deployed to your Microsoft Sentinel workspace as part of the IoT OT Threat Monitoring with Defender for IoT solution. 

### SOAR playbooks 
 
Playbooks are collections of automated remediation actions that can be run from Microsoft Sentinel as a routine. A playbook can help automate and orchestrate your threat response. It can be run manually or set to run automatically in response to specific alerts or incidents, when triggered by an analytics rule or an automation rule, respectively.

Use SOAR playbooks, for example to:

- Open an asset ticket in ServiceNow when a new asset is detected, such as a new engineering workstation. This can either be an unauthorized device that can be used by adversaries to reprogram PLCs.

- Send an email to relevant stakeholders when suspicious activity is detected, for example unplanned PLC reprogramming. The mail may be sent to OT personnel, such as a control engineer responsible on the related production line.

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