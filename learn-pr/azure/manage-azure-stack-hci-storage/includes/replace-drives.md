To complete your proof of concept, you need to document the process for managing drive failures. You’ve discovered that the majority of repair activities are carried out automatically by Health Service. All that's left for you to do is to replace a failed drive. 

As described in the previous unit, a drive failure is detected by the Health Service and addressed automatically through the storage repair process. Your responsibility is to replace the failed drive.

You can identify the failed drive by reviewing the **Alerts** area of the Windows Admin Center dashboard. Alternatively, you can display the list of drives and examine their status. The **View** pane supports sorting, grouping, and keyword search. The failed drive should be listed with the **Retired** status and its storage capacity bar should be empty.

You can use either method to determine the drive's physical location. Depending on the hardware support, you might also be able to turn on the drive's indicator light from the drive's properties pane in Windows Admin Center.

Drive replacement is an online operation. You simply need to remove the failed drive and insert its replacement. Ensure that you’re using the matching drive model.

Following the replacement, the alert should automatically clear, and the storage rebalance to incorporate the newly added drive. There’s no additional action required on your part.
