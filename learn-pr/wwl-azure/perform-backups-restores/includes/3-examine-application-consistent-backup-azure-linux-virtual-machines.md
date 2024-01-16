When performing backup snapshots of your VMs, application consistency means your applications should be able to start when the VMs boot after being restored. In Windows VMs, snapshots rely on VSS to facilitate application consistency. For Linux VMs, you can use the Linux pre-script and post-script framework to perform application-consistent backups.

The framework provides an option to run custom pre-scripts and post-scripts while you're taking VM snapshots. Pre-scripts run just before you take the VM snapshot, and post-scripts run immediately after you take the VM snapshot.

Pre-scripts invoke native application APIs, which quiesce the IOs, and flush in-memory content to the disk. These actions ensure the snapshot is application-consistent. Post-scripts use native application APIs to thaw the IOs, which enable the application to resume normal operations after the VM snapshot.

## Configure pre-script and post-script

1. Sign in as the root user to the Linux VM that you want to back up.
2. Download [VMSnapshotScriptPluginConfig.json](https://github.com/MicrosoftAzureBackup/VMSnapshotPluginConfig) from GitHub, and copy it to the **/etc/azure** directory of all VMs you want to back up. If the /etc/azure directory doesn't exist, create it.
3. Copy the pre-script and post-script for your application to all VMs you plan to back up. You can copy the scripts to any location on the VM. Be sure to update the full path of the script files in the VMSnapshotScriptPluginConfig.json file.
4. Ensure the following permissions for these files:

     - **VMSnapshotScriptPluginConfig.json: Permission “600.”** Only “root” user should have “read” and “write” permissions to this file, and no user should have “execute” permissions.
     - **Pre-script file: Permission “700.”** Only “root” user should have “read”, “write”, and “execute” permissions to this file.
     - **Post-script Permission “700.”** Only “root” user should have “read”, “write”, and “execute” permissions to this file.
5. Configure VMSnapshotScriptPluginConfig.json as described here:

     - **pluginName**: Leave this entry as is, or your scripts might not work as expected.
     - **preScriptLocation**: Provide the full path of the pre-script on the VM that's going to be backed up.
     - **postScriptLocation**: Provide the full path of the post-script on the VM that's going to be backed up.
     - **preScriptParams**: Provide the optional parameters that need to be passed to the pre-script.
     - **postScriptParams**: Provide the optional parameters that need to be passed to the post-script.
     - **preScriptNoOfRetries**: Set the number of times the pre-script should be retried if there's any error before terminating. Zero means only one try and no retry if there's a failure.
     - **postScriptNoOfRetries**: Set the number of times the post-script should be retried if there's any error before terminating. Zero means only one try and no retry if there's a failure.
     - **timeoutInSeconds**: Specify individual timeouts for the pre-script and the post-script (maximum value can be 1800).
     - **continueBackupOnFailure**: Set this value to true if you want Azure Backup to fall back to a file system consistent/crash consistent backup if pre-script or post-script fails. Setting this to false fails the backup the script fails (except when you have single-disk VM, in which case, script failure results always in crash-consistent backup).
     - **fsFreezeEnabled**: Specify whether Linux fsfreeze should be called while you're taking the VM snapshot to ensure file system consistency. We recommend keeping this setting set to true unless your application has a dependency on disabling fsfreeze.
6. The script framework is now configured. If the VM backup is already configured, the next backup invokes the scripts and triggers application-consistent backup.

> [!IMPORTANT]
> This framework gives users a lot of power. Secure the framework, and ensure only “root” user has access to critical JSON and script files. If the requirements aren't met, the script won't run, which results in a file system crash and inconsistent backup.
