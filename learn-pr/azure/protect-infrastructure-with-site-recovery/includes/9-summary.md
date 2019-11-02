We've learned about the benefits of Azure Site Recovery and how it fits into a company's BCDR policy. We've protected our company's infrastructure against disaster and tested its integrity with a disaster recovery drill. We then failed over a virtual machine, reprotected it, and then failed it back to its original region.

## Clean up

As you've used your Azure subscription or a free account, you'll need to delete all the created Azure Site Recovery resources manually.

As part of the exercise steps, we created two regions and we'll need to delete both:

1. Delete the **east-coast-rg**, and **west-coast-rg** resource groups.
1. Another resource group was created automatically by Azure Site Recover, so we also need to delete the **west-coast-rg-asr** resource group.

## Resources

To learn more about how to troubleshoot any replication issues, see:

- [Full list of troubleshooting Azure-to-Azure VM replication issues](https://docs.microsoft.com/azure/site-recovery/azure-to-azure-troubleshoot-errors)
