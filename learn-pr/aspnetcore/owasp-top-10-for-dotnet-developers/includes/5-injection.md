
The injection category describes instances when an application accepts data as input and processes it as instruction instead of as data​.

Let's consider how your team's application handles input data.

.NET provides built-in capabilities for data annotation and validation. The attributes from the `System.ComponentModel.DataAnnotations` namespace can decode your data model to provide the necessary validation functionality. Email, phone, credit card, or date validators are only a few examples of the built-in validators that can spare you the effort of writing and maintaining custom code.

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

### SQL injection

Injection attacks can take many forms; for example, SQL or command injection.

The following statement is a simple example of SQL injection, where `username` in an unsanitized query input parameter:

```sql
string sql = ​"SELECT * FROM users WHERE name = '" + username + "';";
```

In absence of user input validation, a malicious actor could supplement a genuine user name for a crafted part of a SQL statement `a';DROP TABLE users;--` resulting in a change of query intentions:

```sql
SELECT * FROM Users WHERE name = 'a';DROP TABLE users;--
```

As a result, the table containing user information is removed from the database. In a similar way, you can craft statements to extract data before data table deletion.

### File input validation

In client-server scenarios, make sure the input is validated on both the client and the server side.
Additionally, if validation passes on the server, process the form and send a success status code (`200 - OK`). ​However, if validation fails, return a failure status code (`400 - Bad Request`) and the field validation errors. Validation details from the server might give the malicious actor more insights on how your app logic works if they're displayed on the client side.

Input validation also includes the way you handle file uploads. Consider an ASP.NET Blazor component handling user file uploads. The component checks for correctness before uploading the file to Azure Blob Storage. It includes extension and maximum file size inspection, and overrides the supplied filename with a random name.

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

> [!IMPORTANT]
> Neutralize or verify user input in your application. Always verify that input is safe, legitimate, and in the correct format.

### Code review notes

After your review, you noticed that your team uses Entity Framework Core (Object-Relational Mapping (ORM)) as the glue between the C# code and the database. Simply using ORM eliminates the need to write your own SQL queries and prevents SQL injection.

You also noticed that every user input, uploaded file, or form entry field is always validated. Sanitizing and normalizing user input is a must.

As a golden rule, you should ensure validation is performed whenever you're processing user input. Never assume any user data input as safe to process until proven otherwise.

You decided, as an exercise, to check if your web app is correctly validating user input by typing in `<iframe src="javascript:alert('HACKED')">` into a text input area. If a browser displays an alert, there might be room for improvement in your validation logic.
