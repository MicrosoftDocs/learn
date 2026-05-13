In this module, you learned to use scripting constructs such as the **ForEach** construct to process all objects in an array and the **If..Else** and **Switch** constructs to make decisions in your scripts. Key takeaways:

- Use the **ForEach-Object** cmdlet to process the data in the pipeline. When you store data in an array, the **ForEach** construct allows you to process each item in the array.

- PowerShell 7 adds the `-Parallel` parameter to the **ForEach-Object** cmdlet, allowing the pipeline to process multiple objects simultaneously.

- Use the **If** construct in Windows PowerShell to make decisions. 

- The **Switch** construct is similar to an **If** construct that has multiple **ElseIf** sections. 

- The **For** construct performs a series of loops similar to a **ForEach** construct. However, when using the **For** construct, you must define how many loops occur, which is useful when you want an action to be performed a specific number of times. 

- Other less common looping constructs include **Do..While**, **Do..Until**, and **While**.

- Use **Break** and **Continue** to modify loop behavior. **Continue** ends processing for the current iteration. **Break** completely stops the loop. 

## Additional reading

To learn more, go through the following documents:

- [About ForEach](/powershell/module/microsoft.powershell.core/about/about_foreach)

- [About If](/powershell/module/microsoft.powershell.core/about/about_if)

- [About Switch](/powershell/module/microsoft.powershell.core/about/about_switch)

- [About For](/powershell/module/microsoft.powershell.core/about/about_for)

- [About While](/powershell/module/microsoft.powershell.core/about/about_while)

- [About Do](/powershell/module/microsoft.powershell.core/about/about_do)

- [About Break](/powershell/module/microsoft.powershell.core/about/about_break)

- [About Continue](/powershell/module/microsoft.powershell.core/about/about_continue)

- [ForEach-Object](/powershell/module/microsoft.powershell.core/foreach-object)
