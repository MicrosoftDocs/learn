If you read the full Help for a command, you can see the pipeline input capability of each parameter. For example, in the Help file for **Sort-Object**, you will find the following information:

```powershell
-InputObject <PSObject>
    Specifies the objects to be sorted.
 
    To sort objects, pipe them to Sort-Object.

    Required?                    false
    Position?                    Named 
    Default value                None
    Accept pipeline input?       true (ByValue)
    Accept wildcard characters?  false
```

The **Accept pipeline input?** attribute is **true** because the **–InputObject** parameter accepts pipeline input. Additionally, Help shows a list of techniques the parameter supports. In this case, it supports only the **ByValue** technique.

