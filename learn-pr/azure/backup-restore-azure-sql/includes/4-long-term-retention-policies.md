## Long-term Retention policies

In Azure SQL Database, you can configure a single or a pooled database with a long-term backup retention policy (LTR) to automatically retain backups in Azure Blob storage for up to 10 years. You can then recover a database using these backups using the Azure portal or PowerShell.

## How SQL Database long-term retention works

Long-term backup retention (LTR) leverages the full database backups that are automatically created to enable point-time restore (PITR). If an LTR policy is configured, these backups are copied to different blobs for long-term storage. The copy operation is a background job that has no performance impact on the database workload. The LTR backups are retained for a period of time set by the LTR policy. The LTR policy for each SQL database can also specify how frequently the LTR backups are created.

## Combine weekly/monthly/yearly retention policies and they are kept

Policies can be defined using a combination of four parameters to allow flexibility such as: weekly backup retention (W), monthly backup retention (M), yearly backup retention (Y), and week of year (WeekOfYear). If you specify W, one backup every week will be copied to the long-term storage. If you specify M, one backup during the first week of each month will be copied to the long-term storage. If you specify Y, one backup during the week specified by WeekOfYear will be copied to the long-term storage. Each backup will be kept in the long-term storage for the period specified by these parameters. Any change of the LTR policy applies to the future backups. For example, if the specified WeekOfYear is in the past when the policy is configured, the first LTR backup will be created next year.

Examples of the LTR policy:

- W=0, M=0, Y=5, WeekOfYear=3

    The third full backup of each year will be kept for five years.
- W=0, M=3, Y=0

    The first full backup of each month will be kept for three months.
- W=12, M=0, Y=0

    Each weekly full backup will be kept for 12 weeks.
- W=6, M=12, Y=10, WeekOfYear=16

    Each weekly full backup will be kept for six weeks. Except first full backup of each month, which will be kept for 12 months. Except the full backup taken on 16th week of year, which will be kept for 10 years.