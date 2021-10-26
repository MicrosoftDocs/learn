Live Response gives security operations teams instantaneous access to a device (also referred to as a machine) using a remote shell connection. Live response gives you the power to do in-depth investigative work and take immediate response actions to contain identified threats in real time.

Live Response is designed to enhance investigations, and enables your security operations team to collect forensic data, run scripts, send suspicious entities for analysis, remediate threats, and proactively hunt for emerging threats.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE4qLUW?rel=0]

With Live Response, analysts can do all of the following tasks:

- Run basic and advanced commands to do investigative work on a device.
- Download files such as malware samples and outcomes of PowerShell scripts.
- Download files in the background (new!).
- Upload a PowerShell script or executable to the library and run it on a device from a tenant level.
- Take or undo remediation actions.

## Prerequisites

Before you can initiate a session on a device, make sure you fulfill the following requirements:

**Verify that you're running a supported version of Windows 10**

Enable Live Response from the Settings page.  You'll need to enable the Live Response capability in the Advanced features settings page.

Only users with **manage security** or **global admin** roles can edit these settings.

**Ensure that the device has an Automation Remediation level assigned to it**

You'll need to enable, at least, the minimum Remediation Level for a given Device Group. Otherwise, you won't be able to establish a Live Response session to a member of that group.

**Enable live response unsigned script execution (optional)**

Signature verification can be disabled in the Advanced features page of Settings. Allowing the use of unsigned scripts may increase your exposure to threats.  Running unsigned scripts is not recommended as it can increase your exposure to threats. However, if you must use them, you'll need to enable the setting in the Advanced features settings page.

**Ensure that you have the appropriate permissions**

Only users who have been provisioned with the appropriate permissions can initiate a session. The option to upload a file to the library is only available to users with the appropriate RBAC permissions. The Upload object is unavailable for users with only delegated permissions. Depending on the role that's been granted to you, you can run basic or advanced Live Response commands. User permissions are controlled by RBAC custom role.

## Live response dashboard overview

When you initiate a Live Response session on a device, a dashboard opens. The dashboard provides information about the session, including:

- Who created the session
- When the session started
- The duration of the session

The dashboard also gives you access to:

- Disconnect session
- Upload files to the library
- Command console
- Command log

## Live response commands

Depending on the role that's been granted to you, you can run basic or advanced live response commands. User permissions are controlled by RBAC custom roles.   Live response is a cloud-based interactive shell; as such, specific command experience may vary in response time depending on network quality and system load between the end user and the target device.

### Basic commands

The following commands are available for user roles that are granted the ability to run basic live response commands.

| Command | Description|
| :--- | :--- |
| `cd` | Changes the current directory. |
| `cls`| Clears the console screen.|
| `connect`| Initiates a Live Response session on the device. |
| `connections` | Shows all the active connections. |
| `dir` | Lists files and subdirectories in a directory. |
| `download <file_path> &` | Downloads a file in the background. |
| `drivers` | Shows all drivers installed on the device.|
| `fg <command ID>` | Returns a file download to the foreground.|
| `fileinfo` | Get information about a file.|
| `findfile` | Locates files by a given name on the device.|
| `help` | Provides help information for live response commands.|
| `persistence` | Shows all known persistence methods on the device.|
| `processes` | Shows all processes running on the device.|
| `registry` | Shows registry values.|
| `scheduledtasks| Shows all scheduled tasks on the device.|
| `services` | Shows all services on the device.|
| `trace` | Sets the terminal's logging mode to debug. |

### Advanced commands

The following commands are available for user roles that are granted the ability to run advanced live response.

| Command| Description|
| :--- | :--- |
| `analyze` | Analyzes the entity with various incrimination engines to reach a verdict.|
| `getfile` | Gets a file from the device.  This command has a prerequisite command. You can use the -auto flag with getfile to automatically run the prerequisite command.|
| `run` | Runs a PowerShell script from the library on the device.|
| `library` | Lists files that were uploaded to the live response library.|
| `putfile` | Puts a file from the library to the device. Files are saved in a working folder and are deleted when the device restarts by default.|
| `remediate` | Remediates an entity on the device. The remediation action varies, depending on the entity type. This command has a prerequisite command. You can use the -auto command to automatically run the prerequisite command.|
| `Undo` | Restores an entity that was remediated.|

## Use Live Response commands

The commands that you can use in the console are similar to Windows Commands.  The advanced commands offer a more robust set of actions that enable you to take more powerful actions, such as download and upload a file, run scripts on the device, and take remediation actions on an entity.

### Get a file from the device

For scenarios in which you'd like to get a file from a device, you can use the [getfile] command, which allows you to save a file from the device for further investigation.

The following file size limits apply:

- `getfile` limit: 3 GB
- `fileinfo` limit: 10 GB
- `library` limit: 250 MB

### Download a file in the background

To enable your security operations team to continue investigating an impacted device, files can now be downloaded in the background.

- To download a file in the background, in the Live Response command console, enter `download <file_path> &`.
- If you are waiting for a file to download, you can move the operation to the background by entering <kbd>Ctrl</kbd> + <kbd>Z</kbd>.
- To bring a file download to the foreground, in the Live Response command console, enter `fg <command_id>`.

Here are some examples:

| Command| What it does|
| :--- | :--- |
| `download "C:\windows\some_file.exe" &` | Starts downloading a file named *some_file.exe* in the background.|
| `fg 1234` | Returns the download with command ID 1234 to the foreground.|

### Put a file in the library

Live response has a library where you can store files, such as scripts, that can be run in a Live Response session at the tenant level.  Live Response allows PowerShell scripts to run. However, files must be stored the library before you can run them.  You can have a collection of PowerShell scripts that run on devices to initiate Live Response sessions.

To upload a file to the library:

1. Select **Upload file to library**.

1. Select **Browse** and select the file.

1. Provide a brief description.

1. Specify whether you'd like to overwrite a file if it has the same name.

1. If you'd like to know what parameters are needed for the script, select the script parameters check box. In the text field, enter an example and a description.

1. Select **Confirm**.

1. (Optional) To verify that the file was uploaded to the library, run the `library` command.

### Cancel a command

Any time during a session, you can cancel a command by pressing <kbd>CTRL</kbd> + <kbd>C</kbd>.

### Automatically run prerequisite commands

Some commands have prerequisite commands that must be run. If you don't run the prerequisite command, you'll get an error. For example, running the `download` command without *fileinfo* will return an error. You can use the `-auto` flag to automatically run prerequisite commands, for example:

```console
getfile c:\Users\user\Desktop\work.txt -auto
```

### Run a PowerShell script

Before you can run a PowerShell script, you must first upload it to the library. After uploading a script to the library, use the **run** command to run the script.  If you plan to use an unsigned script in the session, you'll need to toggle that setting from **Settings > Endpoints > Advanced features** page.

### Apply command parameters

View the console `help` to learn about command parameters. To learn about an individual command, run:

```PowerShell
help <command name>
```

When adding parameters to commands, parameters are handled in a fixed order:

```PowerShell
<command name> param1 param2
```

When specifying parameters outside of the fixed order, specify the parameter name preceded by a hyphen, followed by the parameter value:

```PowerShell
<command name> -param2_name param2_val
```

When using commands that have prerequisite commands, you can use a flag to automatically call the prerequisite command first:

```PowerShell
<command name> -type file -id <file path> -auto 
remediate file <file path> -auto.
```

### Supported output types

Live Response supports `table` and `JSON` format output types. For each command, there's a default output behavior. You can specify your preferred output format using the following output flags:

- `-output table`
- `-output json`


### Supported output pipes

Live Response supports output piping to CLI and file. CLI is the default output. You can pipe output to a specified file using the following command: 

```PowerShell
[command] > [filename].txt.
```

### View the command log

Select the Command log tab to view the commands used during a Live Response session. Each command is tracked with full details, including:

- ID
- Command line
- Duration
- Status and input or output side bar

## Command examples

The following examples demonstrate the use of Live Response commands.

### analyze

```console
# Analyze the file malware.txt
analyze file c:\Users\user\Desktop\malware.txt
```

```console
# Analyze the process by PID
analyze process 1234
```

## Limitations

Live Response has the following limitations:

- Live Response sessions are limited to 25 concurrently running Live Response sessions.
- Large-scale command execution is not supported.
- Live Response session inactive timeout value is 30 minutes.
- A user can initiate up to 10 concurrent sessions.
- A device can only be in one session at a time.
- The following file size limits apply:
  - `getfile` limit: 3 GB
  - `fileinfo` limit: 10 GB
  - `library` limit: 250 MB

