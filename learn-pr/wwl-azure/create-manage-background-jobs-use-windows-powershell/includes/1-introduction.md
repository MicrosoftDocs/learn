Windows PowerShell supports both foreground tasks that run in the console or integrated scripting environment (ISE), and background tasks that run asynchronously.

> [!NOTE]
> The PowerShell ISE is no longer in active feature development. Visual Studio Code with the PowerShell extension is the recommended modern scripting environment.

When you run a command as a background job, Windows PowerShell performs the task asynchronously in its own thread, separate from the pipeline thread. Even when a job takes a long time to complete, you regain access to the PowerShell prompt immediately and can run other commands while the job runs in the background.

In this module, you'll learn about three types of jobs: local jobs, Windows PowerShell remote jobs, and Common Information Model (CIM)/Windows Management Instrumentation (WMI) jobs. These three job types form the basis of the Windows PowerShell job system.

## Learning objectives

After completing this module, you'll be able to:

- Explain the purpose and functionality of background jobs.
- Start jobs.
- Manage jobs.
- Retrieve job results.

## Prerequisites

Familiarity with:

- Windows networking technologies and implementation
- Windows Server administration, maintenance, and troubleshooting
- Windows PowerShell and its commands to perform specific tasks
- PowerShell cmdlets used for system administration tasks related to Active Directory, network configuration, server administration, and Windows 10 device administration
- Windows PowerShell pipeline, PowerShell providers, and PowerShell drives
- CIM and WMI technologies
- Using variables, arrays, hash tables, and scripting constructs in Windows PowerShell
- Administering remote computers with Windows PowerShell
- Managing Azure resources and Microsoft 365 services with Windows PowerShell
