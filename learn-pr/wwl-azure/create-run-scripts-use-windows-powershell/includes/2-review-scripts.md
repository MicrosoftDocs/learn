You start using Windows PowerShell to accomplish tasks that you can't do with graphical tools. For example, when managing Microsoft 365 or Microsoft Exchange Server, there are many settings that you can only configure by using Windows PowerShell cmdlets. As you become more familiar with Windows PowerShell, you'll notice opportunities to simplify management by using scripts instead of running individual commands.

You can use scripts to standardize repetitive tasks. After you test a script, you can run it multiple times with consistent, error-free results. However, when you manually enter a command multiple times, there's a risk of error each time. If the task runs on a schedule, you can automate the script to run as needed.

> [!NOTE] 
> Module 11, “Using background jobs and scheduled jobs” covers the configuration of Windows PowerShell scripts to make them run as scheduled tasks or scheduled jobs.

You can also use scripts to accomplish more complex tasks than are practical by using a single command. Although it's technically possible to make a single Windows PowerShell command that's long and complex, it's impractical to manage. Placing complex tasks in a script makes editing simpler and easier to understand.

Reporting is a complex, repetitive task that Windows PowerShell handles well. You can use Windows PowerShell to create text or HTML-based reports. For example, you can create a script that reports available disk space on your servers, or you can create a script for Exchange that scans the message tracking logs to report on mail flow statistics.

Scripts can also use constructs such as **ForEach**, **If**, and **Switch**, which are seldom used in a single command. You can use these constructs to process objects and make decisions in your scripts.

Windows PowerShell scripts have a .ps1 file extension. The most basic scripts are Windows PowerShell commands saved in a text file with the .ps1 file extension. Although you can edit scripts by using a simple text editor such as Notepad, **Visual Studio Code with the PowerShell extension** is the recommended editor — it offers syntax highlighting, debugging, and IntelliSense. The Windows PowerShell Integrated Scripting Environment (ISE) also provides a richer editing experience, but is no longer in active feature development and only supports Windows PowerShell 5.1.

