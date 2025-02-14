In this module, you learned about variables and some rules for how to use them. Additionally, you learned to identify the properties and methods for use in Windows PowerShell scripts. The following are the key takeaways:
- Variables store values and objects in memory so you can perform complex and repetitive operations on them.
- In addition to simple data types such as numbers or strings, variables can contain objects too. When a variable contains an object, you can access all of the object’s characteristics.
- You should create variable names that describe the data stored in them. 
- The $ symbol is not part of the variable name but it distinguishes variables from other syntax elements of Windows PowerShell. 
- Variable names aren't case sensitive. For improved legibility, the common convention is to use lowercase characters and capitalize the first letter of each word in a variable name.
- To assign a value to a variable, you use the equal (=) operator. You can also set the value of a variable by using the **Set-Variable** cmdlet.
- You can display the value of a variable by entering the variable name and then pressing the Enter key. You can also display the value as part of a command by using **Write-Host**.
- Windows PowerShell automatically determines the type of a variable during assignment of its value. Common variable types used in Windows PowerShell are String, int, Double, DateTime, and Bool.
- The **Get-Member** cmdlet displays all the available properties and methods for a specific variable based on its variable type. 
- The string variable has only one property, **Length**. When you review the length for a string variable, it returns the number of characters in the string.
- A DateTime variable contains both the date and the time. You can use the DateTime variable properties to access specific parts of the date or time. 


## Additional reading

To learn more, go through the following documents:

- [About Assignment Operators](https://aka.ms/lewact)

- [System Namespace](https://aka.ms/system-namespace)

