In this unit, you'll learn how to enable the collection of boot diagnostics. As an administrator, with your band on tour next month, you need to monitor virtual machine performance and behavior to ensure a good user experience. If you didn’t enable boot diagnostics when the virtual machine was deployed, you can enable retrospectively using Azure CLI and Azure PowerShell. 

You'll also look at performance counters, event logs,  application logs, event tracing for Windows (ETW) events, and crash dumps. Diagnostic logs, event logs,  application logs, tracing for Windows events, and crash dump are great ways to get detailed information, such as error codes. These codes will help if any application crashes or fails on your web server. For example, the ticket booking application could crash when there's a huge increase in traffic. It's vital that you know a simple way to troubleshoot and resolve any issues.

Diagnostic logs – these activity logs are similar to the event viewer on a Windows computer. Diagnostic logs help you get detailed troubleshooting information about software-related problems. The minutia level detail will help to determine the root cause of the issue and rectify it. You can choose from the following data sources:

   - Performance counters – you can collect data to monitor performance with the basic counters:
      -  CPU
      -  Memory
      -  Disk
      -  Network

   Configure custom counters such as ASP NET, SQL Server, LogicalDisk(_Total)\% Disk Time, LogicalDisk(_Total)\% Disk Read Time and \LogicalDisk(_Total)\% Disk Write Time – these are only a few examples. 

   - Event Logs – in Azure, you collect event logs for:
      - Application
      - Security
      - System

   You can also specify the levels to collect data: Critical, Error, Warning, Information, and Verbose.

   - Application logs – allow you to collect diagnostic traces from web code.

   - Event tracing for Windows (ETW) events – ETW is a kernel-level tracing facility that logs kernel or application-defined events to a log file. ETW can detect these events in real time from log files. Then you can use these events to diagnose performance issues.
  
   - Crash dumps – allow you to view the complete memory dump, including all the physical memory used.
  
   - Boot diagnostics –  allow you to diagnose virtual machine boot issues by capturing the boot output. You need a storage account to store the boot log files. The storage account is automatically created if you enable boot diagnostics in the Azure portal. Boot diagnostics aren't enabled by default.

You've looked at the list of features available in Azure to monitor the health of virtual machines. All features have their purpose, but you might not need to enable all of them. It depends on the services you're running on the virtual machine and how critical those services are. 

Because each feature provides specific information, you choose the ones that meet your needs. When you've collected diagnostic logs for a virtual machine, you'll have a few options available:

   - Keep the logs in a storage account for auditing or manual inspection of application issues.
   - Use third-party services to ingest the logs (Event Hubs, Power BI).
   - Use Azure Monitor to analyze the logs.

   In the next unit, you'll create a virtual machine and enable boot diagnostics and operating system guest diagnostics.

