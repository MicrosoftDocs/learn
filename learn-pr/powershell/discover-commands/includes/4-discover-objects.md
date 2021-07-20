When a cmdlet runs, it returns an object. When you invoke a cmdlet, the response you see has been formatted and might not necessarily represent all the available information for the response. To know more about what's being returned and how you can modify what is returned, you can use the command `Get-Member`.

## Discover objects by using Get-Member

The `Get-Member` cmdlet is meant to be _piped_ on top of the command you run so that you can filter the output. A typical command-line invocation of `Get-Member` might look like the following example:

```bash
Get-Process -Name 'name-of-process' | Get-Member
```

This command first produces an object result by calling `Get-Process`. That result is passed as an input to `Get-Member` by using the pipe (`|`). In return, you get a table result that includes the `Name`, `MemberType`, and `Definition` columns. You also get the type of the returned object.

### Search by type

The first line of the response, running the `Get-Member` command, is the type of the returned object. When you know the type, you can search for other cmdlets that operate on the same type. Explore these related commands to quickly build your knowledge in the domain you're working in.

Let's say you invoked the PowerShell command that lists all members for a specific process. The first few rows of the result look something like this output:

```output
  TypeName: System.Diagnostics.Process

Name                       MemberType     Definition
----                       ----------     ----------
Handles                    AliasProperty  Handles = Handlecount
```

The first row indicates that the type is `System.Diagnostics.Process`. Use this type as a search argument to look for other cmdlets that use this type. Here's an example command:

```powershell
Get-Command -ParameterType Process
```

The result is a list of cmdlets that operate on this type. Little by little, you can learn more about PowerShell by using `Get-Member` and by learning to interpret its result.

> [!TIP]
> PowerShell is meant to be learned a little at a time. A great way to discover related cmdlets is by using the returned type to search for cmdlets by type.

### Filter a Get-Member result by using Select-Object

When you run `Get-Member`, the result is _verbose_. That is, many rows are returned. The object might have properties, like events and methods. To make the answer less verbose, you can filter on specific columns and also decide which columns to display. Keep in mind that the returned answer is already a subset of all the columns in the response.

Take a look at a `Get-Member` response that includes many columns. By introducing the `Select-Object` cmdlet, you can choose which columns appear in the response. The command expects either a comma-separated list of column names or a wildcard character, such as an asterisk (`*`), which indicates all columns.

When you use the `Select-Object` command in the context of `Select-Object Name, MemberType`, you specify only the columns you want. In this case, the columns are `Name` and `MemberType`. This filtering pattern returns an output that includes fewer columns. Here's an example of the result:

```powershell
Name                           MemberType
----                           ----------
Handles                     AliasProperty
```

You also can filter the response by rows. For example, you can use the `-MemberType Method` flag to specify that you're interested in the rows in which the member type is a method. You might want to show only specific rows, for example, if you want to locate and run a specific method.

> [!TIP]
> It's generally better to use dedicated cmdlets than to run methods on an object.
