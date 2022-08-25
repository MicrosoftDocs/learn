Within your scripts, you'll need to refer to the data that you place in arrays. You can either access all items in the array simultaneously or access them individually. To display all items in an array, you enter the variable name and then press the Enter key, just as you would for a variable with a single value.

You can refer to individual items in an array by their index number. When you create an array, each item is assigned an index number starting at 0. So, the first item placed in the array is item 0, the second item in the array is item 1, and so on. To display a specific item, place the index number in brackets after the variable name. The following example displays the first item in an array that's stored in the variable $users:

```powershell
$users[0] 
```

You also can add a new item to an array. The following example adds the user account stored in `$user1` to the `$users` array:

```powershell
$users = $users + $user1
```

Alternatively, when adding items to an array, you can use the following shorthand notation:

```powershell
$users += $user1
```

To identify what you can do with the content in an array, use the **Get-Member** cmdlet. Pipe the contents of the array to **Get-Member**, and the results returned identify the properties and methods that you can use for the items in the array. For example:

```powershell
$files | Get-Member
```

> [!NOTE]
> When you pipe an array containing mixed data types to **Get-Member**, results are returned for each data type. This is also a helpful way of determining which data types are in the array.

To review the properties and methods available for an array rather than the items within the array, use the following syntax:

```powershell
Get-Member -InputObject $files
```

## Working with array lists

The default type of array that Windows PowerShell creates is a fixed-size array. This means that when you add an item to the array, the array is actually recreated with the additional item. When you work with relatively small arrays, this is not a concern. However, if you add thousands of items to an array one by one, recreating an array each time has a negative performance impact. The other concern when using fixed-size arrays is removing items. There's no simple method to remove an item from a fixed-size array.

To address the shortcomings of arrays, you can use an array list. An array list functions similar to an array, except that it doesn't have a fixed size. This means that you can use methods to add and remove items.

To create an array list when assigning values, use the following syntax:

```powershell
[System.Collections.ArrayList]$computers = "LON-DC1","LON-SVR1","LON-CL1"
```

To create an array list that's empty and ready to add items, use the following syntax:

```powershell
$computers=New-Object System.Collections.ArrayList
```

When you use an array list, you can use methods to both add and remove items. However, these methods will fail when you try to use them on a fixed-size array. For example:

```powershell
$computers.Add("LON-SRV2")
$computers.Remove("LON-CL1")
```

> [!NOTE] 
> When you remove an item from an array list, if there are multiple matching items then only the first instance is removed.

If you want to remove an item from an array list based on the index number, you use the **RemoveAt()** method. For example:

```powershell
$computers.RemoveAt(1)
```
