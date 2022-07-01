An *array* is a data structure that's designed to store a collection of items of the same type. You can think of an array as a variable containing multiple values or objects. Variables that contain a single value are useful, but for complex tasks you often need to work with groups of items. For example, you might need to update the Voice over IP (VoIP) attribute on multiple domain user accounts. Or you might need to check the status of a group of services and restart all of them that are stopped. When you put multiple objects or values into a variable, it becomes an array.

You can create an array by providing multiple values in a comma-separated list. For example:

```powershell
$computers = "LON-DC1","LON-SRV1","LON-SRV2"
$numbers = 228,43,102
```

> **Note:** To create an array of strings, you put quotes around each item. If you put one set of quotes around all the items, it's treated as a single string.

You also can create an array by using the output from a command. For example:

```powershell
$users = Get-ADUser -Filter *
$files = Get-ChildItem C:\
```

You can verify whether a variable is an array by using the **GetType()** method on the variable. The **BaseType** listed will be **System.Array**.

You can create an empty array before you're ready to put content in it. This can be useful when you have a loop later on in a script that adds items to the array. For example:

```powershell
$newUsers = @()
```

You also can force an array to be created when adding a single value to a variable. This creates an array with a single value into which you can add items later. For example:

```powershell
[array]$computers="LON-DC1"
```
