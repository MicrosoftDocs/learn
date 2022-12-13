Working with hash tables is similar to working with an array, except that to add items to a hash table you need to provide both the key for the item and the value. The following command creates a hash table named `$servers` to store server names and IP addresses:

```powershell
$servers = @{"LON-DC1" = "172.16.0.10"; "LON-SRV1" = "172.16.0.11"}
```

Notice the following syntax in the previous example:

- It begins with the at (@) symbol.
- The keys and associated values are enclosed in braces.
- The items are separated by a semicolon.

> [!NOTE]
> The semicolon between hash table items is required in the previous example because they're all on the same line. If you place each item on a separate line, it's not necessary to use semicolons as separators.

Adding or removing items from a hash table is similar to an array list. You use the methods **Add()** and **Remove()**. For example:

```powershell
$servers.Add("LON-SRV2","172.16.0.12")
$servers.Remove("LON-DC1")
```

You can also update the value for a key. For example:

```powershell
$servers."LON-SRV2"="172.16.0.100"
```

To review all properties and methods available for a hash table, use the **Get-Member** cmdlet. For example:

```powershell
$servers | Get-Member
```
