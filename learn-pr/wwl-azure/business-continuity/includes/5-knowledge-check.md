
Choose the best response for each of the questions below. Then select **Check your answers**.
## Check your knowledge

## Multiple Choice
You have scheduled a backup and want to know whether it has completed successfully. Where should you look?
()Azure Backup Center vault status{{That's incorrect. The Azure Backup Center vault status will not display the status for a scheduled backup.}}
(x)Azure Backup Center job status{{That's correct. The Azure Backup Center displays the number of scheduled backups, on-demand backups, and restores have completed successfully, are in progress, or failed. Select View All to see details for individual jobs.}}
()Azure Backup Center backup policies{{That's incorrect. The Azure Backup Center backup policies will not display the status of a scheduled backup.}}

## Multiple Choice
You want to configure email notification when a backup alert is triggered. What do you need to do?
()Nothing  email alerts are automatically sent to the administrators email address.{{That's incorrect. Email alerts are not automatically sent to the administrators email address.}}
(x)Create an alert processing rule.{{That's correct. To receive email notifications when a backup alert is triggered, you must create an alert processing rule}}
()Select the email alert check box when creating the backup job.{{That's incorrect. When you create a backup job there is not an option to provide email alerts in case of problems.}}

## Multiple Choice
You are attempting to replicate an Azure VM from one region to another. Which scenarios could prevent the Azure VM from being backed up?
()High data change rate on the Azure VM being replicated.{{That's incorrect. A high data change rate may affect the Azure VM being replicated, but only if the data change rate goes beyond a certain limit.}}
(x)Azure VM is in a Stopped state.{{That's correct. The Azure VM cannot be in a Stopped state if you want to replicate it.}}
()Crash-consistent recovery points could not be created every five minutes.{{That's incorrect. This will not necessarily stop the VM from being replicated.}}
