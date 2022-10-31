**Break** and **Continue** are two commands that you can use to modify the default behavior of a loop. **Continue** ends the processing for the current iteration of the loop. **Break** completely stops the loop processing. You typically use these commands when the data you're processing has an invalid value.

In this example, the use of **Continue** prevents modification of the Administrator user account in the list of users to be modified:

```powershell
ForEach ($user in $users) {
   If ($user.Name -eq "Administrator") {Continue}
   Write-Host "Modify user object"
}
```

In this example, **Break** is used to end the loop when a maximum number of accounts has been modified:

```powershell
ForEach ($user in $users) {
   $number++
   Write-Host "Modify User object $number"
   If ($number -ge $max) {Break}
}
```
