In this module, you learned to use scripting constructs such as the **ForEach** construct to process all of the objects in an array and the **If..Else** and **Switch** constructs to make decisions in your scripts. The following are the key takeaways:

- Use the **ForEach-Object** cmdlet to process the data in the pipeline. When you store data in an array, the **ForEach** construct allows you to process each item in the array.

- In PowerShell 7, the **-Parallel** parameter was added to the **ForEach-Object** cmdlet. This allows the pipeline to process multiple objects simultaneously.

- Use the **If** construct in Windows PowerShell to make decisions. 

- The **Switch** construct is similar to an **If** construct that has multiple **ElseIf** sections. 

- The **For** construct performs a series of loops similar to a **ForEach** construct. However, when using the **For** construct, you must define how many loops occur, which is useful when you want an action to be performed a specific number of times. 

- There are other less common looping constructs that you can use. These are **Do..While**, **Do..Until**, and **While**. 

- **Break** and **Continue** are two commands that you can use to modify the default behavior of a loop. **Continue** ends the processing for the current iteration of the loop. **Break** completely stops the loop processing. 

## Additional reading

To learn more, go through the following documents:

- [About Assignment Operators](https://aka.ms/lewact)

- [Hosting your own NuGet Feeds](https://aka.ms/vm0ys1)
