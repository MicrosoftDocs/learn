
Digital forensics is a science that addresses the recovery and investigation of digital data to support criminal investigations or civil proceedings. Computer forensics is a branch of digital forensics that captures and analyzes data from computers, virtual machines (VMs), and digital storage media.

Companies must guarantee that digital evidence they provide in response to legal requests demonstrates a valid Chain of Custody (CoC) throughout the evidence acquisition, preservation, and access process. To ensure a valid CoC, digital evidence storage must demonstrate adequate access control, data protection and integrity, monitoring and alerting, and logging and auditing. The main use cases are:

-   A company's Security Operation Center (SOC) team can implement this technical solution to support a valid CoC for digital evidence
-   Investigators can attach disk copies obtained with this technique on a computer dedicated to forensic analysis, without re-creating, powering on, or accessing the original source VM

Only two individuals within the SOC team should have rights to modify the controls governing access to the subscription and its data. Grant other individuals only bare minimum access to data subsets they need to perform their work. Configure and enforce access through Azure role-based access control (Azure RBAC). Only the virtual network in the SOC subscription has access to the Storage account. Azure Audit Logs can show evidence acquisition by recording the action of taking a VM disk snapshot, with elements like who took the snapshot, how, and where.

### Endpoint forensics

Microsoft Defender for Endpoint provides detailed device information, including forensics information. You are a Security Operations Analyst working at a company that has implemented Microsoft Defender for Endpoint, and your primary job is to remediate incidents.

Live response gives security operations teams instantaneous access to a device (also referred to as a machine) using a remote shell connection. This forensics information gives you the power to do in-depth investigative work and take immediate response actions to promptly contain identified threats in real time. Live response is designed to enhance investigations by enabling your security operations team to collect forensic data, run scripts, send suspicious entities for analysis, remediate threats, and proactively hunt for emerging threats. 

Watch the video below for a demonstration on live response feature.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4qLUW] 

With live response, analysts can do all of the following tasks:

-   Run basic and advanced commands to do investigative work on a device.
-   Download files such as malware samples and outcomes of PowerShell scripts.
-   Download files in the background (new!).
-   Upload a PowerShell script or executable to the library and run it on a device from a tenant level.
-   Take or undo remediation actions.

Depending on the role that's been granted to you, you can run basic or advanced live response commands. User permissions are controlled by RBAC custom roles. Live response is a cloud-based interactive shell. Specific command experience may vary in response time depending on network quality and system load between the end user and the target device.

As part of the investigation or response process, you can collect an investigation package from a device. By collecting the investigation package, you can identify the current state of the device and further understand the tools and techniques used by the attacker. This data collection includes the following artifacts:

-   Autoruns
-   Installed programs
-   Network connections
-   Windows Prefetch files
-   Processes
-   Scheduled tasks
-   Security event log
-   List of services
-   Windows Server Message Block (SMB) sessions
-   System information
-   Temp directories
-   User and groups
