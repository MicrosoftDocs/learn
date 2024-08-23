To onboard your Linux server:

1.  Select **Linux servers**.
    
    :::image type="content" source="../media/linux-servers-added-c1e520a2.png" alt-text="Displays a screenshot of the controls for selecting the procedure for Linux servers.":::
    
    
    To add Linux machines, you need the `wget` command from the **Agents management** page.
2.  Copy the `wget` command into Notepad. Save this file to a location that you can access from your Linux computer.
3.  On your Linux computer, open the file that contains the `wget` command. Copy the entire contents and paste them into a terminal console.
4.  When the installation finishes, validate that the **Operations Management Suite Agent** is installed by running the `pgrep` command. The command returns the **omsagent persistent ID**.
    
    You can find the logs for the agent at `/var/opt/microsoft/omsagent/<workspace id>/log/`. The new Linux machine might take up to 30 minutes to appear in Defender for Cloud.
