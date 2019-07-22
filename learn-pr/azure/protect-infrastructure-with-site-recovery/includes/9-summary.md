In this unit, you have learned about the benefits of Azure Site Recovery and how it fits into a companies BCDR policy. You have protected your companies infrastructure against disaster, and tested its integrity with a disaster recovery drill. You then failed over a Virtual Machine, reprotected it and then failed it back to its original region.

## Clean up

As you've used your own subscription, or a free account, you'll need to manually delete all the created resources. As part of the exercise steps, two regions have been created:

1. Delete the east-**coast-datacenter**, and **west-coast-datacenter** resource groups.
1. Another resource group was created automatically by Azure Site Recover, so you also need to delete the **west-coast-datacenter-asr** resource group.

## Resources

To learn more about how to troubleshoot any replication issues, see:

- [Full list of troubleshooting Azure-to-Azure VM replication issues](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-troubleshoot-errors)