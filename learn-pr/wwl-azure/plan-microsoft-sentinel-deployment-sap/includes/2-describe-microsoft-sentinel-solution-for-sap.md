

Because Contoso uses Microsoft Sentinel, you already understand many of its capabilities. However, the Microsoft Sentinel solution isn’t integrated with your SAP system. You need to understand the components of the Microsoft Sentinel solution for SAP. You also need to understand which cross-functional team members to involve in the planning process.

With the Microsoft Sentinel solution for SAP, you can monitor, detect, and respond to suspicious activities and guard your SAP environment. You can protect business-critical data and systems against sophisticated cyberattacks.
Microsoft designed the solution specifically for SAP systems. The solution connects to SAP and brings operational data into Microsoft Sentinel. The solution helps you:

- Gain visibility across SAP business logic, application, database, and operating system layers by using built-in investigation and threat-detection tools.
- Discover suspicious activity including privilege escalation, unauthorized changes, sensitive transactions, and suspicious data downloads by using out-of-the-box detection capabilities.
- Accurately detect SAP threats by using data correlation from all sources and SAP infrastructure.

In addition, you can extend built-in security content by building your own threat-detection solutions to monitor, analyze, and display data related to specific business risks. You can:

- Customize playbooks by using automation rules, so you can automatically take action from an alert or incident.
- Use the built-in Microsoft Sentinel watchlists or create your own to detect specific types of activities in your SAP systems.
- Conduct ad-hoc threat hunting with custom queries across all your SAP signals.
- Create Microsoft Sentinel workbooks for interactive data visualization.

The solution includes a data connector to bring data from your SAP systems into Microsoft Sentinel. The data connector is an application that Microsoft refers to as an agent. This agent isolates your SAP system based on a single secure interface into your SAP systems.  The agent is run as a Docker container that can be installed on a virtual machine, Kubernetes or Azure Kubernetes Service (AKS) cluster, or a physical server. It collects application logs from one or more SAP systems over SAP application interfaces, NetWeaver RFC, and `SAPControl`. The SAP data connector sends log data to Microsoft Sentinel, enabling continuous threat monitoring.

After you connect your agent to SAP and Microsoft Sentinel, it will ingest the threat monitoring data to send to Microsoft Sentinel. You’ll be able to use the other components of the solution to gain insights into your SAP environment and address security threats. These components include analytics rules for threat detection, workbooks for interactive data visualization, and watchlists to configure and fine-tune the solution.

Because an SAP ecosystem is complex, it’s difficult for security operations (SecOps) teams to effectively monitor and protect against the expanding threat landscape. The Microsoft Sentinel solution for SAP fills an industry gap that will enable Contoso to confidently monitor and analyze SAP log data to find suspicious activity in user behavior.

The next unit helps you understand the planning process for deploying the solution.
