Like **ByValue** parameters, you can see the parameters that accept pipeline input by using the **ByPropertyName** technique and examining the full Help for the command. For example, run the command **Get-Help Stop-Process -Full** and you'll see the following parameters:

```powershell
-ID <Int32[]>

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByPropertyName)
    Accept wildcard characters?  False

-InputObject <Process[]>

    Required?                    true
    Position?                    0
    Default value                None
    Accept pipeline input?       True (ByValue)
    Accept wildcard characters?  false

-Name <String[]>

    Required?                    true
    Position?                    named
    Default value                None
    Accept pipeline input?       True (ByPropertyName)
    Accept wildcard characters?  false
```

Notice that two parameters potentially accept input **ByPropertyName**. Keep in mind that only one parameter can accept input at a time. Further, because there's a parameter that accepts **ByValue**, Windows PowerShell will try that one first.

It's also possible to have a single parameter that accepts pipeline input by using both **ByValue** and **ByPropertyName**. Again, Windows PowerShell will always try **ByValue** first and will use **ByPropertyName** only if **ByValue** fails.
