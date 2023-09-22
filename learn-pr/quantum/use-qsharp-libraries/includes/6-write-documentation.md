In the previous unit, you successfully used your quantum program to find the missing digit of an ISBN for a book that you needed.

What if other space explorers find themselves in a similar predicament?  You can share your code on the Galactic Information Technology Hub, but your fellow explorers would certainly appreciate it being nicely documented.

The ability to write documentation allows quantum space crew members to contribute to the growth of the QDK and the Q# libraries with their own programs and insights. Other space crew members can then more easily solve similar problems, saving both time and resources for future missions.

In this unit, you'll learn how to write API documentation comments for your Q# operations, functions, and user-defined types.

## Documentation comments

As you've already seen, you can write general comments anywhere in Q# source code by using two forward slashes (`//`). The comment then extends from the slashes to the end of the line.

Documentation comments for a declared callable or type are written differently. To be recognized as documentation by the compiler, these comments use three slashes (`///`) and are written *before* the declaration.

Within the comments, the text is formatted as [Markdown](https://daringfireball.net/projects/markdown/syntax?azure-portal=true). Different parts of the documentation are indicated by different specially named headers. Each header is an "H1" with a single `#` preceding it.

We provide a full list of the possible headers later in the unit, but first let's document the oracle operation as an example:

:::code language="qsharp" source="../code/6-program-1.qs":::

## Using help

Documenting your code can help you along with helping others. The QDK makes this even easier by enabling help functions in various editors.

For example, if you're using Visual Studio Code, IntelliSense enables autocomplete functionality. You can see the overview of your callable by simply hovering the mouse over it:

:::image type="content" source="../media/6-mouseover.png" alt-text="Screenshot that shows a Visual Studio Code IntelliSense mouseover.":::

## Learn more

This is precisely the documentation format used in the Q# source code to generate the official API documentation that you explored earlier in the module.

You can find a full list of the recognized documentation headers on the [official Q# documentation page](/quantum/user-guide/language/programstructure/comments?azure-portal=true). The page includes more details and examples, including the ability to cross-reference other callables and add code examples to documentation.
