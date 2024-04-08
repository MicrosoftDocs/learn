There are three basic types of background jobs:

- *Local jobs* run their commands on the local computer and typically access only local resources. However, you can create local jobs that target a remote computer. For example, you could create a local job that includes the following command, where the *–ComputerName* parameter makes it connect to a remote computer:

  ```powershell
  Get-Service –Name * -ComputerName LON-DC1
  ```

- *Remote jobs* use Windows PowerShell remote to transmit commands to one or more remote computers. The commands run on those remote computers and the results are returned to the local computer and stored in memory. Windows PowerShell Help files refer to this kind of job as a remote job.
- *CIM* and *WMI jobs* use the Common Information Model (CIM) and Windows Management Instrumentation (WMI) repository of management information. The commands run on your computer but can connect to one or more remote computers' repositories. Local jobs that use CIM commands use the **Start-Job** command, whereas WMI and other commands use the *-AsJob* parameter within a WMI command.

Each job type has specific characteristics. For example, local and Windows PowerShell remote jobs run in a background Windows PowerShell run space. Think of them as running in a hidden instance of Windows PowerShell. Other types of jobs might have different characteristics. Also, add-in modules add more job types to Windows PowerShell, and those job types have their own characteristics. Remote jobs are useful for managing multiple remote computers simultaneously. Remote computers run Windows PowerShell remote commands by using their own local resources. Therefore, you can include any command in the job.

Remember that these job types aren't the only ones that Windows PowerShell supports. Use modules and other add-ins to create other job types. Workflow jobs help you automate long-running tasks, or *workflows*, by simultaneously targeting multiple managed computers or devices. Windows PowerShell workflows offer extra resiliency benefits. When you restart target devices, unfinished workflow automatically restarts on the target device or devices and continues with the job's workflow commands.

It's important to note that interactive Windows PowerShell console workflow jobs aren't available in a noninteractive Windows PowerShell console. Scheduling a task to run at machine startup won't find suspended jobs from a noninteractive console. Scheduled tasks can't find workflow jobs to resume unless you're signed in to an interactive session.

