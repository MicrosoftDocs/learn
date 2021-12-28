The PowerShell Azure Stack privileged endpoint (PEP) is a pre-configured remote PowerShell console that provides just enough capabilities to help you perform a required task. The endpoint uses PowerShell JEA (Just Enough Administration) to expose only a restricted set of cmdlets.

Below are the parameters for configuring a new Cloud Admin user role using the `New-CloudAdminUser` cmdlet from the PowerShell JEA.

## Syntax

```
New-CloudAdminUser [[-Password] <Object>] [[-UserName] <Object>] [-AsJob]

```

## Parameters

### \-Password

```
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False

```

### \-UserName

```
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False

```

### \-AsJob

```
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False

```
