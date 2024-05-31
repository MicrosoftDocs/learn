In addition to the traditional tasks that run in the foreground within the Windows PowerShell console or ISE, you also can run background tasks. When you run a command as a background job, Windows PowerShell performs the task asynchronously in its own thread. This thread is separate from the pipeline thread that the command uses. When a command runs as a background job, even if it takes a long time to complete, you regain access to the PowerShell prompt immediately. This allows you to run other commands while the job runs in the background.

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
