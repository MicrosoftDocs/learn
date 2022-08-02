So far, when you were executing **Enter-PSSession** or **Invoke-Command**, Windows PowerShell was establishing a connection to a remote computer, running the commands that you specified, returning the results to Windows PowerShell, and then closing the connection. This approach offers no persistence of session data across connections because each connection is starting a separate PowerShell session.

Windows PowerShell can create persistent connections, which are known as *sessions*, or more accurately, *PSSessions*. The PS designation signifies Windows PowerShell and differentiates these sessions from other kinds of sessions that might be present in other technologies, such as a Remote Desktop Services (RDS) session.

After making a PowerShell session to a remote computer, you run the desired commands within the session, but you leave the PowerShell session running. By doing this, you can run more commands in the session.

## Disconnected sessions

In Windows PowerShell 3.0 and newer, you can also manually disconnect from sessions. This allows you to close the session in which a PowerShell session was established, even shut down the local computer, without disrupting commands running in the PowerShell session on the remote computer. This is particularly useful for running commands that take a long time to complete and provides the time and device flexibility that IT professionals need.

## Controlling sessions

Every computer has a drive named **WSMan** that includes many configuration parameters related to the session, such as:

- Maximum session run time
- Maximum idle time
- Maximum number of incoming connections
- Maximum number of sessions per administrator

You can explore these configuration parameters by running **dir WSMan:\localhost\shell**, and change them in that same location. You also can control many of the settings through Group Policy.
