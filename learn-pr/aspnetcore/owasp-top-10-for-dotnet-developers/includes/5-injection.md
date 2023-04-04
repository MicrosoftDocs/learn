Let's consider how your application handles input data. The injection category is attributed to an application accepting data as input and processing it as instruction instead of as data​.

As a golden rule, ensure validation is performed whenever you're processing user input. Never assume any user data input as safe to process until proven otherwise.

> [!IMPORTANT]
> Neutralize or verify user input in your application. Always verify that input is safe, legitimate and in the correct format.

.NET provides build-in capabilities for data annotation and validation. The attributes from `System.ComponentModel.DataAnnotations` namespace can decode your data model to provide the necessary validation functionality. Email, phone, credit card or date validators are only a few examples of the build-in validators that can spare you the effort of writing and maintaining custom code.

```csharp
using System.ComponentModel.DataAnnotations; ​

public class ExampleModel ​
{​
    [Required]​
    [StringLength(10, ErrorMessage = "Name is too long.")]​
    public string? Name { get; set; }​
    
    [Required]​
    [Range(typeof(bool), "true", "true", ErrorMessage = "Unapproved design.")] ​
    public bool IsValidatedDesign { get; set; }​
}​
```

### SQL Injection

Injection can take different forms and shapes, from SQL, process to command injection.
The canonical example of SQL injection could be the following statement, where `username` in an unsanitised query input parameter:

```sql
string sql = ​"SELECT * FROM users WHERE name = '" + username + "';";
```

Without validation of user input, a malicious actor could supplement a genuine user name for a crafted part of SQL statement:

```sql
SELECT * FROM Users WHERE name = 'a';DROP TABLE users;--
```


### File Input Validation

In client-server scenarios, make sure the input is validated on both client and server side.
Additionally, if validation passes on the server, process the form and send back a success status code (200 - OK). ​However, if validation fails, return a failure status code (400 - Bad Request) and the field validation errors.Validation details from server may give the malicious actor more insights on how your app logic works if displayed on the client side.

Input validation also includes the way you handle file upload. Following example (from ASP.NET Blazor component) attempts to validate correctness of file before uploading it to Azure Blob Storage, including check for expected extension, max file size and overriding supplied filename with a random name.

```csharp actor
<InputFile OnChange = "@LoadFile" />

@code {

    private string[] permittedExtensions = { ".txt", ".pdf" };
    private long maxFileSize = 1024 * 15;

    private async void LoadFile(InputFileChangeEventArgs e)
    {
        if (e.File != null)
        {    
            if (e.File.Size == 0 || e.File.Size > maxFileSize)
            {
                // log error
            }            
            else 
            {
                var ext = Path.GetExtension(e.File.Name).ToLowerInvariant();

                if (string.IsNullOrEmpty(ext) || !permittedExtensions.Contains(ext))
                {
                    var trustedFileNameForFileStorage = Path.GetRandomFileName();

                    await new BlobContainerClient("connection", "blob").UploadBlobAsync(trustedFileNameForFileStorage, e.File.OpenReadStream());                    
                }
            }
        }
    }
}
```

As an exercise check if your web app is correctly validating user input by typing in `<iframe src="javascript:alert('HACKED')">` into a text input area. If a browser displays an alert there might be a room for improvement in your validation logic.


### Code Review Notes

Your team uses Entity Framework Core (Object-Relational Mapping) as the glue between the C# code and database which eliminates the need for writing your own SQL queries and prevents from SQL injection.
You've noticed that every single user input, uploaded files or form entry fields, are always validated. Sanitization and normalization of user input is a must.
