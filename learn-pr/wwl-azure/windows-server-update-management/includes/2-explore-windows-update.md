Windows Update is a Microsoft service that provides updates to Microsoft software. This includes service packs, security patches, drive updates, and even firmware updates.

Orchestrator software on a Windows device scans for and downloads updates. You can configure the orchestrator to get updates from a Windows Server Update Services (WSUS) by using Group Policy.

## What is WSUS?

WSUS (Windows Server Update Services) is a server role that helps you download and distribute updates to Windows clients and servers. WSUS can obtain updates that are applicable to the operating system, and to common Microsoft products such as Microsoft Office and Microsoft SQL Server.

## What does WSUS provide?

WSUS provides a central management point for updates to your computers running Windows operating systems. By using WSUS, you can create a more efficient update environment in your organization and stay better informed about the overall update status of your network's computers.

In the simplest configuration, a small organization can have a single WSUS server that downloads updates from Microsoft Update. The WSUS server then distributes the updates to computers that are configured to obtain automatic updates from the WSUS server. You can choose whether updates need approval before clients can download them.

Larger organizations might want to create a hierarchy of WSUS servers. In this scenario, a single, centralized WSUS server obtains updates from Microsoft Update, and other WSUS servers obtain updates from the centralized WSUS server.

You can organize computers into groups, or deployment rings, to manage the process of deploying and approving updates. For example, you can configure a pilot group to be the first set of computers used for testing updates.

WSUS can generate reports to help monitor update installations. These reports can identify which computers have not yet applied recently approved updates. Based on these reports, you can investigate why updates are not being applied.

## Prerequisites

To install the WSUS server role on a server, in addition to the requirements of the Windows Server operating system, it must meet the following requirements:

- Memory. An additional 2 gigabytes (GB) of random access memory (RAM) beyond that required for the server and all other services.

- Available disk space. 40 GB or greater available disk space.

- Reporting. Installation of the Microsoft Report Viewer 2012 Runtime.

The WSUS database requires either a Windows Internal Database (WID) or a SQL Server database. When using a SQL Server database, the database can be hosted on another computer.

