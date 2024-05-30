When you perform backup snapshots of your VMs, application consistency means your applications should be able to start when the VMs boot after being restored. In Windows VMs, snapshots rely on VSS to facilitate application consistency. For Linux VMs, you can use the Linux pre-script and post-script framework to perform application-consistent backups.

The framework provides an option to run custom pre-scripts and post-scripts while you're taking VM snapshots. Pre-scripts run just before you take the VM snapshot, and post-scripts run immediately after you take the VM snapshot.

Pre-scripts invoke native application APIs, which quiesce the IOs, and flush in-memory content to the disk. These actions ensure the snapshot is application-consistent. Post-scripts use native application APIs to thaw the IOs, which enable the application to resume normal operations after the VM snapshot.

## Configure pre-script and post-script

1. Sign in as the root user to the Linux VM that you want to back up.
2. Download [VMSnapshotScriptPluginConfig.json](https://github.com/MicrosoftAzureBackup/VMSnapshotPluginConfig) from GitHub, and copy it to the **/etc/azure** directory of all VMs you want to back up. If the /etc/azure directory doesn't exist, create it.
3. Copy the pre-script and post-script for your application to all VMs you plan to back up. You can copy the scripts to any location on the VM. Be sure to update the full path of the script files in the VMSnapshotScriptPluginConfig.json file.
4. Ensure the following permissions for these files:

   - **VMSnapshotScriptPluginConfig.json**: Permission “600.” For example, only “root” user should have “read” and “write” permissions to this file, and no user should have “execute” permissions.

   - **Pre-script file**: Permission “700.”  For example, only “root” user should have “read”, “write”, and “execute” permissions to this file. The file is expected to be a shell script but theoretically this script can internally spawn or refer to other scripts like a Python script.

   - **Post-script**: Permission “700.” For example, only “root” user should have “read”, “write”, and “execute” permissions to this file. The file is expected to be a shell script but theoretically this script can internally spawn or refer to other scripts like a Python script.

   > [!IMPORTANT]
   > The framework gives users a lot of power. Secure the framework, and ensure only “root” user has access to critical JSON and script files.
   > If the requirements aren't met, the script won't run, which results in a file system crash and inconsistent backup.

5. Configure **VMSnapshotScriptPluginConfig.json** as described here:
    - **pluginName**: Leave this field as is, or your scripts might not work as expected.

    - **preScriptLocation**: Provide the full path of the pre-script on the VM that's going to be backed up.

    - **postScriptLocation**: Provide the full path of the post-script on the VM that's going to be backed up.

    - **preScriptParams**: Provide the optional parameters that need to be passed to the pre-script. All parameters should be in quotes. If you use multiple parameters, separate the parameters with a comma.

    - **postScriptParams**: Provide the optional parameters that need to be passed to the post-script. All parameters should be in quotes. If you use multiple parameters, separate the parameters with a comma.

    - **preScriptNoOfRetries**: Set the number of times the pre-script should be retried if there's any error before terminating. Zero means only one try and no retry if there's a failure.

    - **postScriptNoOfRetries**:  Set the number of times the post-script should be retried if there's any error before terminating. Zero means only one try and no retry if there's a failure.

    - **timeoutInSeconds**: Specify individual timeouts for the pre-script and the post-script (maximum value can be 1800).

    - **continueBackupOnFailure**: Set this value to **true** if you want Azure Backup to fall back to a file system consistent/crash consistent backup if pre-script or post-script fails. Setting this to **false** fails the backup if there's a script failure (except when you have a single-disk VM that falls back to crash-consistent backup regardless of this setting). When the **continueBackupOnFailure** value is set to false, if the backup fails the backup operation will be attempted again based on a retry logic in service (for the stipulated number of attempts).

    - **fsFreezeEnabled**: Specify whether Linux fsfreeze should be called while you're taking the VM snapshot to ensure file system consistency. We recommend keeping this setting set to **true** unless your application has a dependency on disabling fsfreeze.

    - **ScriptsExecutionPollTimeSeconds**: Set the time the extension has to sleep between each poll to the script execution. For example, if the value is 2, the extension checks whether the pre/post script execution completed every 2 seconds. The minimum and maximum value it can take is 1 and 5 respectively. The value should be strictly an integer.

6. The script framework is now configured. If the VM backup is already configured, the next backup invokes the scripts and triggers application-consistent backup. If the VM backup isn't configured, configure it by using [Back up Azure virtual machines to Recovery Services vaults.](/azure/backup/backup-azure-arm-vms-prepare)
