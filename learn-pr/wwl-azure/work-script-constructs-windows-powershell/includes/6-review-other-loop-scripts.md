There are other less common looping constructs that you can use. These looping constructs are **Do..While**, **Do..Until**, and **While**. All of these loop constructs process a script block until a condition is met, but they vary in the details of how they do it.

## Do..While

The **Do..While** construct runs a script block until a specified condition isn't true. This construct guarantees that the script block is run at least once.

The **Do..While** construct uses the following syntax:

```powershell
Do {
   Write-Host "Script block to process"
} While ($answer -eq "go")
```

## Do..Until

The **Do..Until** construct runs a script block until a specified condition is true. This construct guarantees that the script block is run at least once.

The **Do..Until** construct uses the following syntax:

```powershell
Do {
   Write-Host "Script block to process"
} Until ($answer -eq "stop")
```

## While

The **While** construct runs a script block until a specified condition is false. It's similar to the **Do..While** construct, except that the script block isn't guaranteed to be run.

The **While** construct uses the following syntax:

```powershell
While ($answer -eq "go") {
   Write-Host "Script block to process"
}
```
