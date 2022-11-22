JavaScript Object Notation (JSON) is a lightweight data format that's similar to XML, because it can represent multiple layers of data. JSON is a lightweight data-interchange format compared to XML because of its simpler syntax.

Windows PowerShell doesn't include cmdlets that import or export JSON data directly from a file. Instead, if you have JSON data stored in a file, you can retrieve the data by using **Get-Content** and then convert the data by using the **ConvertFrom-Json** cmdlet.

The **ConvertFrom-Json** cmdlet uses the following syntax:

```powershell
$users = Get-Content C:\Scripts\Users.json | ConvertFrom-Json
```

## Invoke-RestMethod

When you query a web service, the data is commonly provided using the JSON format. You can query data directly from a web service by using **Invoke-RestMethod**. **Invoke-RestMethod** sends a request to the specified URL and obtains data from the response. The retrieved data in JSON format is automatically converted to objects. You don't need to use **ConvertFrom-Json**.

The **Invoke-RestMethod** cmdlet uses the following syntax:

```powershell
$users = Invoke-RestMethod "https://hr.adatum.com/api/staff"
```

> [!NOTE] 
> The URLs used to retrieve data from a web service aren't standardized. You must review the documentation for the web service to identify the correct URLs to retrieve data.

> [!NOTE] 
> **Invoke-RestMethod** is also capable of working with XML, RSS feeds, and ATOM feeds.
