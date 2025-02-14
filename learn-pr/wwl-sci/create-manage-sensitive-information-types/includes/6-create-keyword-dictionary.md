As businesses grow and regulatory environments become more complex, managing sensitive information across different departments and platforms becomes increasingly challenging. Keyword dictionaries in Microsoft Purview provide a scalable solution by enabling organizations to create and manage large lists of sensitive terms automatically, reducing manual oversight in data loss prevention (DLP). These dictionaries can support up to 1 MB of compressed terms. They're essential for flagging and protecting sensitive information in services like Exchange, SharePoint, OneDrive, and Teams.

Keyword dictionaries are useful in industries that handle regulated data, such as healthcare, finance, and legal sectors. They allow organizations to ensure compliance with data protection standards by flagging sensitive information that could violate privacy regulations.

## What are keyword dictionaries?

Keyword dictionaries in Microsoft Purview are files that contain lists of sensitive terms, phrases, or keywords used to detect and flag information that requires protection. These dictionaries can store words or phrases relevant to specific industries or organizational needs, such as legal terms, medical conditions, or internal business jargon.

The dictionaries can be created in formats like `.txt` or `.csv`, and once uploaded into the Microsoft Purview portal become custom sensitive information types (SITs). These SITs can then be used within DLP policies to automatically identify and manage sensitive information across platforms like Exchange, SharePoint, OneDrive, and Teams.

## Create a keyword dictionary

Keyword dictionaries can be created and managed through two main methods: directly in the Microsoft Purview portal for a user-friendly, visual experience, or through PowerShell for more flexibility and automation. Both methods allow you to build and customize dictionaries for use in data protection policies, depending on your organization's workflow preferences.

### Create a keyword dictionary in the Microsoft Purview portal

Creating a keyword dictionary in the Microsoft Purview portal involves uploading a file of sensitive terms or manually entering them. This method is ideal for users who prefer a graphical interface to manage and configure their keyword dictionaries.

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true), then navigate to **Solutions** > **Information Protection** > **Classifiers** > **Sensitive info types**.

1. Select **+ Create sensitive info type** and then enter a **Name** and **Description** for your sensitive info type. Select **Next**.

1. On the **Define patterns for this sensitive info type** page, select **+ Create pattern**.

1. In the **New pattern** flyout panel, select a **Confidence level**.

1. Choose **Add a Primary element** and select **Keyword dictionary**.

1. On the **Add a keyword dictionary** flyout, you can:
    1. **Upload a dictionary** file in **TXT** or **CSV** format.
    1. **Choose from existing dictionaries**.
    1. or create a new dictionary by entering keywords manually and giving it a name.

   :::image type="content" source="../media/keyword-dictionary-creation.png" alt-text="Screenshot showing where to adjust the confidence level in creating a document fingerprint SIT." lightbox="../media/keyword-dictionary-creation.png":::

1. Still in the **New Pattern** flyout panel, for **Character proximity**, specify how far away (in number of characters) that any supporting elements must be to be detected. The closer the primary and supporting elements are to each other, the more likely the detected content is going to be what you're looking for.

1. Add the **Supporting elements** you wish to use to increase the accuracy of detecting what you're looking for.

1. Add any **Additional checks** and then choose **Create**.

1. Select **Next** to continue creating your sensitive information type. When you're finished, choose **Done**.

### Create a keyword dictionary from a file using PowerShell

For larger or more complex dictionaries, using PowerShell can provide greater flexibility and automation. PowerShell allows you to create keyword dictionaries directly from files, making it easier to handle large lists of terms or integrate with existing data sources. To begin, you need to [connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

1. Copy your keywords into a text file and make sure that each keyword is on a separate line.

2. Save the text file with Unicode encoding. In Notepad, navigate to > **Save As** > **Encoding** > **Unicode**.

3. Read the file into a variable by running this cmdlet:

    ```powershell
    $fileData = [System.IO.File]::ReadAllBytes('<filename>')
    ```

4. Create the dictionary by running this cmdlet:

    ```powershell
    New-DlpKeywordDictionary -Name <name> -Description <description> -FileData $fileData

## Keyword dictionary management

After creating a new keyword dictionary and using it in a DLP policy, you might need to modify the keywords as your organizational requirements change. For example, a keyword dictionary used to detect medical disease classifications might need updates when new terms are introduced or outdated ones are removed. These changes ensure that your policies stay relevant and effective over time.

For more information, see [Modify a keyword dictionary](/purview/sit-modify-keyword-dictionary?azure-portal=true).

## Keyword dictionary as a custom sensitive information type

Keyword dictionaries can be used in rule package definitions for a custom sensitive information type. They can be selected as sensitive information types when creating policies in the Microsoft Purview compliance portal or with the Security & Compliance PowerShell module. When using the PowerShell module, the keyword dictionary must be specified with its ID.

For more information, see [Using keyword dictionaries in custom sensitive information types and DLP policies](/purview/sit-create-a-keyword-dictionary?azure-portal=true#using-keyword-dictionaries-in-custom-sensitive-information-types-and-dlp-policies).
