Microsoft 365 offers several ways for organizations to prevent mailbox content from being permanently deleted. Besides retention policies and retention labels that can be applied to multiple Microsoft 365 service locations at the same time, Exchange Online provides a feature called holds, which is applied on a single mailbox level.

There are two different types of mailbox holds in Exchange Online:

- **Litigation Hold**: Set on a mailbox level and prevents all content within a mailbox from being deleted.

- **eDiscovery Hold**: Created in an eDiscovery case to prevent only mailbox content that matches the search criteria from being changed or deleted.

> [!NOTE]
> The hold in context of an eDiscovery case was once available in the Exchange admin center and could be applied to any mailbox, even without a case connected. The creation of new in-place holds was retired in October 2020 and only existing in-place holds can be removed now from Exchange Online.

## Apply a litigation hold

To put a mailbox on litigation hold, which prevents the deletion of all content of that mailbox, the Exchange Admin Center or the Exchange Online PowerShell cmdlet can be used. Perform the following steps to set a mailbox on litigation hold.

1. Navigate to the Exchange Admin Center at [https://outlook.office.com/ecp](https://outlook.office.com/ecp) and sign in as Exchange administrator.

1. Select **Recipients** > **Mailboxes** in the left navigation pane.

1. Select the mailbox that you want to place on Litigation Hold, and then select **Edit**.

1. On the mailbox properties page, select **Mailbox features**.

1. Under Litigation hold: Disabled, select **Enable** to place the mailbox on Litigation Hold.

1. The same operation can also be performed via the Exchange Online PowerShell module.

1. To set a mailbox on litigation hold, you can also use the following cmdlet:

    ```powershell
    Set-Mailbox <username> -LitigationHoldEnabled $true

    ```

1. To modify the number of days to put the mailbox content on hold, use the following cmdlet:

    ```powershell
    Set-Mailbox <username> -LitigationHoldEnabled $true -LitigationHoldDuration <number of days>

    ```

