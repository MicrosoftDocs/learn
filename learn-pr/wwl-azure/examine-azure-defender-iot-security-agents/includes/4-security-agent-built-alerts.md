Azure Defender for IoT continuously analyzes your IoT solution using advanced analytics and threat intelligence to alert you to malicious activity. In addition, you can create custom alerts based on your knowledge of expected device behavior. An alert acts as an indicator of potential compromise, and should be investigated and remediated.

Installing and configuring a Security Agent onto your IoT devices adds a large number of alerts to your security solution.

:::row:::
  :::column:::
    **Name**
  :::column-end:::
  :::column:::
    **Severity**
  :::column-end:::
  :::column:::
    **Data Source**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **Suggested remediation steps**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    High severity
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Binary Command Line
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    LA Linux binary being called/executed from the command line was detected. This process may be legitimate activity, or an indication that your device is compromised.
  :::column-end:::
  :::column:::
    Review the command with the user that ran it and check if this command is something legitimately expected to run on the device. If not, escalate the alert to your information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Disable firewall
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Possible manipulation of on-host firewall detected. Malicious actors often disable the on-host firewall in an attempt to exfiltrate data.
  :::column-end:::
  :::column:::
    Review with the user that ran the command to confirm if this was legitimate expected activity on the device. If not, escalate the alert to your information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Port forwarding detection
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Initiation of port forwarding to an external IP address detected.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Possible attempt to disable Audited logging detected
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Linux Audited system provides a way to track security-relevant information on the system. The system records as much information about the events that are happening on your system as possible. This information is crucial for mission-critical environments to determine who violated the security policy and the actions they performed. Disabling Audited logging may prevent your ability to discover violations of security policies used on the system.
  :::column-end:::
  :::column:::
    Check with the device owner if this was legitimate activity with business reasons. If not, this event may be hiding activity by malicious actors. Immediately escalated the incident to your information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Reverse shells
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Analysis of host data on a device detected a potential reverse shell. Reverse shells are often used to get a compromised machine to call back into a machine controlled by a malicious actor.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Successful Brute force attempt
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Multiple unsuccessful login attempts were identified, followed by a successful login. Attempted Brute force attack may have succeeded on the device.
  :::column-end:::
  :::column:::
    Review SSH Brute force alert and the activity on the devices. If the activity was malicious: Roll out password reset for compromised accounts. Investigate and remediate (if found) devices for malware.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Successful local login
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Successful local sign-in to the device detected.
  :::column-end:::
  :::column:::
    Make sure the signed in user is an authorized party.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Web shell
  :::column-end:::
  :::column:::
    High
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Possible web shell detected. Malicious actors commonly upload a web shell to a compromised machine to gain persistence or for further exploitation.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Medium severity
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Behavior similar to common Linux bots detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Execution of a process normally associated with common Linux botnets detected.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Behavior similar to Fairware ransomware detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Execution of rm -rf commands applied to suspicious locations detected using analysis of host data. Because rm -rf recursively deletes files, it is normally only used on discrete folders. In this case, it is being used in a location that could remove a large amount of data. Fairware ransomware is known to execute rm -rf commands in this folder.
  :::column-end:::
  :::column:::
    Review with the user that ran the command this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Behavior similar to ransomware detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Execution of files similar to known ransomware that may prevent users from accessing their system, or personal files, and may demand ransom payment to regain access.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Crypto coin miner container image detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Container detecting running known digital currency mining images.
  :::column-end:::
  :::column:::
    1. If this behavior is not intended, delete the relevant container image. 2. Make sure that the Docker daemon is not accessible via an unsafe TCP socket. 3. Escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Crypto coin miner image
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Execution of a process normally associated with digital currency mining detected.
  :::column-end:::
  :::column:::
    Verify with the user that ran the command if this was legitimate activity on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Detected suspicious use of the nohup command
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Suspicious use of the nohup command on host detected. Malicious actors commonly run the nohup command from a temporary directory, effectively allowing their executables to run in the background. Seeing this command run on files located in a temporary directory is not expected or usual behavior.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Detected suspicious use of the useradd command
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Suspicious use of the useradd command detected on the device.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Exposed Docker daemon by TCP socket
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Machine logs indicate that your Docker daemon (dockerd) exposes a TCP socket. By default, Docker configuration, does not use encryption or authentication when a TCP socket is enabled. Default Docker configuration enables full access to the Docker daemon, by anyone with access to the relevant port.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Failed local login
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    A failed local login attempt to the device was detected.
  :::column-end:::
  :::column:::
    Make sure no unauthorized party has physical access to the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    File downloads from a known malicious source detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Download of a file from a known malware source detected.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    htaccess file access detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Analysis of host data detected possible manipulation of an htaccess file. Htaccess is a powerful configuration file that allows you to make multiple changes to a web server running Apache Web software, including basic redirect functionality, and more advanced functions, such as basic password protection. Malicious actors often modify htaccess files on compromised machines to gain persistence.
  :::column-end:::
  :::column:::
    Confirm this is legitimate expected activity on the host. If not, escalate the alert to your information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Known attack tool
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    A tool often associated with malicious users attacking other machines in some way was detected.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT agent attempted and failed to parse the module twin configuration
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    The Azure Defender for IoT security agent failed to parse the module twin configuration due to type mismatches in the configuration object.
  :::column-end:::
  :::column:::
    Validate your module twin configuration against the IoT agent configuration schema, fix all mismatches.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Local host reconnaissance detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Execution of a command normally associated with common Linux bot reconnaissance detected.
  :::column-end:::
  :::column:::
    Review the suspicious command line to confirm that it was executed by a legitimate user. If not, escalate the alert to your information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mismatch between script interpreter and file extension
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Mismatch between the script interpreter and the extension of the script file provided as input detected. This type of mismatch is commonly associated with attacker script executions.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Possible backdoor detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    A suspicious file was downloaded and then run on a host in your subscription. This type of activity is commonly associated with the installation of a backdoor.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Potential loss of data detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Possible data egress condition detected using analysis of host data. Malicious actors often egress data from compromised machines.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Potential overriding of common files
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Common executable overwritten on the device. Malicious actors are known to overwrite common files as a way to hide their actions or as a way to gain persistence.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Privileged container detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Machine logs indicate that a privileged Docker container is running. A privileged container has full access to host resources. If compromised, a malicious actor can use the privileged container to gain access to the host machine.
  :::column-end:::
  :::column:::
    If the container doesn't need to run in privileged mode, remove the privileges from the container.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Removal of system logs files detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Suspicious removal of log files on the host detected.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Space after filename
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Execution of a process with a suspicious extension detected using analysis of host data. Suspicious extensions may trick users into thinking files are safe to be opened and can indicate the presence of malware on the system.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Suspected malicious credentials access tools detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Detection usage of a tool commonly associated with malicious attempts to access credentials.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Suspicious compilation detected
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Suspicious compilation detected. Malicious actors often compile exploits on a compromised machine to escalate privileges.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Suspicious file download followed by file run activity
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Analysis of host data detected a file that was downloaded and run in the same command. This technique is commonly used by malicious actors to get infected files onto victim machines.
  :::column-end:::
  :::column:::
    Review with the user that ran the command if this was legitimate activity that you expect to see on the device. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Suspicious IP address communication
  :::column-end:::
  :::column:::
    Medium
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Communication with a suspicious IP address detected.
  :::column-end:::
  :::column:::
    Verify if the connection is legitimate. Consider blocking communication with the suspicious IP.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    LOW severity
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Bash history cleared
  :::column-end:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Bash history log cleared. Malicious actors commonly erase bash history to hide their own commands from appearing in the logs.
  :::column-end:::
  :::column:::
    Review with the user that ran the command that the activity in this alert to see if you recognize this as legitimate administrative activity. If not, escalate the alert to the information security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device silent
  :::column-end:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Device has not sent any telemetry data in the last 72 hours.
  :::column-end:::
  :::column:::
    Make sure device is online and sending data. Check that the Azure Security Agent is running on the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Failed Brute force attempt
  :::column-end:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Multiple unsuccessful login attempts identified. Potential Brute force attack attempt failed on the device.
  :::column-end:::
  :::column:::
    Review SSH Brute force alerts and the activity on the device. No further action required.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Local user added to one or more groups
  :::column-end:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    New local user added to a group on this device. Changes to user groups are uncommon, and can indicate a malicious actor may be collecting access permissions.
  :::column-end:::
  :::column:::
    Verify if the change is consistent with the permissions required by the affected user. If the change is inconsistent, escalate to your Information Security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Local user deleted from one or more groups
  :::column-end:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    A local user was deleted from one or more groups. Malicious actors are known to use this method in an attempt to deny access to legitimate users or to delete the history of their actions.
  :::column-end:::
  :::column:::
    Verify if the change is consistent with the permissions required by the affected user. If the change is inconsistent, escalate to your Information Security team.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Local user deletion detected
  :::column-end:::
  :::column:::
    Low
  :::column-end:::
  :::column:::
    Agent
  :::column-end:::
  :::column:::
    Deletion of a local user detected. Local user deletion is uncommon, a malicious actor may be trying to deny access to legitimate users or to delete the history of their actions.
  :::column-end:::
  :::column:::
    Verify if the change is consistent with the permissions required by the affected user. If the change is inconsistent, escalate to your Information Security team.
  :::column-end:::
:::row-end:::
