JavaScript Object Notation (JSON) is a lightweight data format. Like XML, it supports multiple layers of data, but its simpler syntax makes it less verbose.

Windows PowerShell doesn't include cmdlets that import or export JSON data directly from a file. Instead, if you have JSON data stored in a file, use **Get-Content** with the `-Raw` parameter to read the file as a single string, then pipe it to **ConvertFrom-Json**. The `-Raw` parameter is required for **ConvertFrom-Json** to parse multi-line JSON correctly.

The **ConvertFrom-Json** cmdlet uses the following syntax:

```powershell
$users = Get-Content -Raw C:\Scripts\Users.json | ConvertFrom-Json
```

## Invoke-RestMethod

When you query a web service, the data is commonly provided using the JSON format. You can query data directly from a web service by using **Invoke-RestMethod**. **Invoke-RestMethod** sends a request to the specified URL and retrieves data from the response. JSON data in the response is automatically converted to objects. You don't need to use **ConvertFrom-Json**.

The **Invoke-RestMethod** cmdlet uses the following syntax:

```powershell
$users = Invoke-RestMethod "https://hr.adatum.com/api/staff"
```

> [!NOTE] 
> The URLs used to retrieve data from a web service aren't standardized. Review the documentation for the web service to identify the correct URLs.

> [!NOTE] 
> **Invoke-RestMethod** is also capable of working with XML, RSS feeds, and ATOM feeds.
