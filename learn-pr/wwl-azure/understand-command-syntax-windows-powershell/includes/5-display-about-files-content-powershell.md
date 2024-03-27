Although much of the help content in Windows PowerShell relates to commands, there are also many help files that describe PowerShell concepts. These files include information about the PowerShell scripting language, operators, and other details. This information doesn't specifically relate to a single command, but to global shell techniques and features.

You can review a complete list of these topics by running **Get-Help about\***, and then reviewing a single topic by running **Get-Help about\_topicname**. An example is **Get-Help about\_common\_parameters**. These commands don't use the *–Example* or *–Full* parameters of the **Help** command. However, they're compatible with the *–ShowWindow* and *–Online* parameters.

When you use wildcard characters with the **Get-Help** command, **About** help files will appear in a list when their titles contain a match for your wildcard pattern. Typically, **About** help files will appear last, after any commands whose names also matched your wildcard pattern. You can also use the *‑Category* parameter to specify a search for **About** files.

> [!NOTE] 
> For much of this course, you'll need to refer to **About** files for additional documentation. You must review these files frequently to discover the steps and techniques you need to complete lab exercises.

