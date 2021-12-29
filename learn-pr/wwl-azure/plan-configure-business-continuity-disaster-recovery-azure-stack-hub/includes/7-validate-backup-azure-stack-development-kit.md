After deploying Azure Stack and provisioning user resources (such as offers, plans, quotas, and subscriptions), you should enable Azure Stack infrastructure backup. Scheduling and running regular infrastructure backups will ensure infrastructure management data isn't lost if there's a catastrophic hardware or service failure.

It is recommended that you run an on-demand backup before beginning this procedure to ensure you have a copy of the latest infrastructure data available. Make sure to capture the backup ID after the backup successfully completes. This ID is required during cloud recovery.

Azure Stack infrastructure backups contain important data about your cloud that can be restored during redeployment of Azure Stack. You can use the Azure Stack Development Kit (ASDK) to validate these backups without impacting your production cloud.

Validating backups on ASDK is supported for the following scenarios:

:::row:::
  :::column:::
    **Scenario**
  :::column-end:::
  :::column:::
    **Purpose**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Validate infrastructure backups from an integrated solution.
  :::column-end:::
  :::column:::
    Short lived validation that the data in the backup is valid.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Learn the end-to-end recovery workflow.
  :::column-end:::
  :::column:::
    Use ASDK to validate the entire backup and restore experience.
  :::column-end:::
:::row-end:::


The following scenario is not supported when validating backups on the ASDK:

:::row:::
  :::column:::
    **Scenario**
  :::column-end:::
  :::column:::
    **Purpose**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ASDK build to build backup and restore.
  :::column-end:::
  :::column:::
    Restore backup data from a previous version of the ASDK to a newer version.
  :::column-end:::
:::row-end:::


## Cloud recovery deployment

Infrastructure backups from your integrated systems deployment can be validated by performing a cloud recovery deployment of the ASDK. In this type of deployment, specific service data is restored from backup after the ASDK is installed on the host computer.

### Cloud recovery prerequisites

Before starting a cloud recovery deployment of the ASDK, ensure that you have the following info:

**UI installer requirements**

:::row:::
  :::column:::
    **Prerequisite**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Backup share path
  :::column-end:::
  :::column:::
    The UNC file share path of the latest Azure Stack backup that will be used to recover Azure Stack infrastructure info. This local share will be created during the cloud recovery deployment process.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Backup ID to restore
  :::column-end:::
  :::column:::
    The backup ID, in the alphanumeric form of "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", that identifies the backup to be restored during cloud recovery.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Time server IP
  :::column-end:::
  :::column:::
    A valid time server IP, such as 132.163.97.2, is required for Azure Stack deployment.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External certificate password
  :::column-end:::
  :::column:::
    The password for the external certificate used by Azure Stack. The CA backup contains external certificates that need to be restored with this password.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Decryption certification password
  :::column-end:::
  :::column:::
    Optional. Required only if the backup is encrypted using a certificate. The password is for the self-signed certificate's (.pfx) that contains the private key necessary to decrypt backup data.
  :::column-end:::
:::row-end:::


**PowerShell installer requirements**

:::row:::
  :::column:::
    **Prerequisite**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Backup share path
  :::column-end:::
  :::column:::
    The UNC file share path of the latest Azure Stack backup that will be used to recover Azure Stack infrastructure info. This local share will be created during the cloud recovery deployment process.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Backup ID to restore
  :::column-end:::
  :::column:::
    The backup ID, in the alphanumeric form of "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", that identifies the backup to be restored during cloud recovery.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Time server IP
  :::column-end:::
  :::column:::
    A valid time server IP, such as 132.163.97.2, is required for Azure Stack deployment.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External certificate password
  :::column-end:::
  :::column:::
    The password for the external certificate used by Azure Stack. The CA backup contains external certificates that need to be restored with this password.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Decryption certification password
  :::column-end:::
  :::column:::
    The password is for the self-signed certificate's (.pfx) that contains the private key necessary to decrypt backup data.
  :::column-end:::
:::row-end:::
