PowerShell can run commands in a *pipeline*, which is a chain of one or more commands in which the output from one command can pass as input to the next command. In Windows PowerShell, each command in the pipeline runs in sequence from left to right. For multiple commands, each command and its parameters are separated from the next command by a character known as a *pipe* (**|**). Specific rules dictate how output passes from one command to the next. You'll learn about those rules throughout this module.

As you interact with Windows PowerShell in the console host application, you should think of each command line as a single pipeline. You enter a command or a series of commands and then press the Enter key to run the pipeline. The output of the last command in the pipeline displays on your screen. Another shell prompt follows that output, and you can enter commands into a new pipeline at that shell prompt.

> [!NOTE]
> You can enter one logical command line over multiple physical lines in the console. For example, enter **Get-Service**, and then press the Enter key. Windows PowerShell enters an extended prompt mode, which is indicated by the presence of two consecutive greater than signs (**>>**). This allows you to complete the command line. Select **Ctrl+C** to exit the command and return to the Windows PowerShell prompt.

Previously, you learned about common actions, or *verbs*, associated with Windows PowerShell commands. When running multiple commands as part of a single pipeline, you most commonly notice the verbs **Get** and **Set** used in combination. You use the output of a **Get-\*** command as the input for a **Set-\*** command. You often use these commands in combination with a filtering command, such as **Where** or **Select**. In that case, the output of **Get-\*** is filtered by the **Where** or **Select** command before being piped to the **Set-\*** command.

> [!NOTE]
> The **Where** command is an alias for **Where-Object**, and the **Select** command is an alias for **Select-Object**. Lesson 3, “Filter objects out of the pipeline” explains filtering in more detail.

It helps to understand the concept of PowerShell objects and pipelines by comparing them to real-world items. For example, if we consider a car as an object, we can describe attributes of the car such as engine, car color, car size, type, make and model. In PowerShell, these would be known as properties. Properties of the object could be, in turn, objects themselves. For instance, the engine property is also an object that has attributes, such as pistons, spark plugs, crankshaft, etc.

Objects have actions, corresponding to such activities as opening or closing doors, changing gears, accelerating, and applying brakes. In PowerShell, these actions are called methods.

Pipelines allow us to take the output produced by one command and pass that object into the input of another command. To make this easier to understand we can liken commands to factories, where each factory receives materials and transforms them into something else.

## Pipeline output

PowerShell commands don't generate text as output. Instead, they generate objects. *Object* is a generic word that describes an in-memory data structure.

You can imagine command output as something that resembles a database table or a spreadsheet. In PowerShell terminology, the table or spreadsheet consists of a collection of objects, or just a *collection* for short. Each row is a single object, and each column is a *property* of that object, that is, information about the object. For example, when you run the **Get-Service** command, it returns a collection of service objects. Each object has properties with names such as **Name**, **DisplayName**, and **Status**.

With its use of objects, PowerShell differs from other command-line shells in which the commands primarily generate text. In a text-based shell, suppose that you want to obtain a list of all the services that have been started. You might run a command to produce a text list of the services, with a different row for each service. Each row might contain the name of a service and some properties of the service, with each property separated by a comma or other character. To retrieve a particular property value, you would need to send that text output to another command that processes the text to pull out the particular value you need. That command would be created to understand the specific text format created by the first command. If the output of the first command ever changes, and the status information moves, you'll have to edit the second command to get the new position information. Text-based shells require significant text parsing skills. This makes scripting languages such as Perl popular, because they offer strong text parsing and text manipulation features.

In PowerShell, you instruct the cmdlet to produce the collection of service objects and to then display only the **Name** property. The structure of the objects in memory enables PowerShell to find the information for you. This way, you don't have to worry about the exact form of the command output.

This functionality makes it possible for the **Get | Set** pattern to work. Because the output of a **Get-\*** command is an object, PowerShell can find the properties needed by a **Set-\*** command for it to work, without you having to specify them explicitly.

