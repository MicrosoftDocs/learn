An alternate method for transferring data is the **AzCopy** tool. AzCopy v10 is the next-generation command-line utility for copying data to and from Azure Blob Storage and Azure Files. AzCopy v10 offers a redesigned command-line interface (CLI) and new architecture for high-performance reliable data transfers. You can use AzCopy to copy data between a file system and a storage account, or between storage accounts.

### Things to know about AzCopy

Let's look at some of the characteristics of the AzCopy tool.

- Every AzCopy instance creates a job order and a related log file. You can view and restart previous jobs, and resume failed jobs. 

- You can use AzCopy to list or remove files or blobs in a given path. AzCopy supports wildcard patterns in a path, `--include` flags, and `--exclude` flags.

- AzCopy automatically retries a transfer when a failure occurs.

- When you use Azure Blob Storage, AzCopy lets you copy an entire account to another account. No data transfer to the client is needed.

- AzCopy supports Azure Data Lake Storage Gen2 APIs.

- AzCopy is built into Azure Storage Explorer.

- AzCopy is available on Windows, Linux, and macOS.

#### Authentication options

There are two options to authenticate your transferred data when using AzCopy.

| Authentication | Support | Description |
| --- | --- | --- |
| **Azure Active Directory (Azure AD)** | Azure Blob Storage and Azure Data Lake Storage Gen2 | The user enters the `.\\azcopy` sign-in command to sign in by using Azure AD. The user should have the *Storage Blob Data Contributor* role assigned, which allows them to write to Blob Storage by using Azure AD authentication. When the user signs in from Azure AD, they provide their credentials only once. This option allows the user to circumvent having to append a SAS token to each command. |
| **SAS tokens** | Azure Blob Storage and Azure Files | On the command line, the user appends a SAS token to the blob or file path for every command they enter. |

#### AzCopy and Azure Storage Explorer

Azure Storage Explorer uses the AzCopy tool for all of its data transfers. If you want to use a graphical UI to work with your files, you can use Azure Storage Explorer and gain the performance advantages of AzCopy.

Azure Storage Explorer uses your account key to perform operations. After you sign into Azure Storage Explorer, you don't need to provide your authorization credentials again.

### Things to consider when using AzCopy

Review the following scenarios for using AzCopy. Consider how the tool features can enhance your Azure Storage solution.

- **Consider data synchronization**. Use AzCopy to synchronize a file system to Azure Blob Storage and vice versa. AzCopy is ideal for incremental copy scenarios.

- **Consider job management**. Manage your transfer operations with AzCopy. View and restart previous jobs. Resume failed jobs. 

- **Consider transfer resiliency**. Provide data resiliency for your data transfers. If a copy job fails, AzCopy automatically retries the copy.

- **Consider fast account to account copy**. Use AzCopy with Azure Blob Storage for the account to account copy feature. Because data isn't transferred to the client, the transfer is faster.

## Get started with the AzCopy CLI

You access the AzCopy tool by using the CLI in a console or terminal window. The tool offers a simple self-documented syntax.

:::image type="content" source="../media/azcopy-inline-help.png" alt-text="Screenshot that shows the command-line interface for AzCopy in a PowerShell terminal." border="false":::

The basic CLI syntax for AzCopy starts with the `azcopy` command followed by the type of job to perform, such as `copy`. For the `copy` command, you specify the `[source]` path of the files to copy, the `[destination]` path for the copied files, and any `[flags]` for options to apply to the transfer job. 

```console
azcopy copy [source] [destination] [flags]
```

Here's how you can get a list of available CLI commands for AzCopy:

```console
azcopy --help
```