When you're working with nearly any programming language, one of the most important development tools at your disposal is the API documentation.

API documentation is essentially the reference manual for the a language's libraries. It contains the specifics about how all the puzzle pieces fit together. For example, it contains all types and functions along with any required/optional inputs.

Such documentation often includes both nitty-gritty details and bigger-picture context. For example, API documentation might include the accepted input types to a function along with a conceptual description of what the function actually does.

By taking advantage of this documentation for the Q# libraries, quantum space crew members can explore the vast capabilities of the Quantum Development Kit. They can develop the skills to tackle complex problems independently.

In this unit, you'll familiarize yourself with the Q# API documentation; where to find it and how to read it.

## Where is it?

The official documentation for the Q# libraries provided with the Quantum Development Kit is on the [Microsoft Quantum Documentation](/quantum?azure-portal=true) home page. It's under the **API reference** tab in the table of contents:

:::image type="content" source="../media/3-api-location.png" alt-text="Screenshot that shows the location of the Q sharp libraries API.":::

### Other API references

Alongside **Q# libraries** are a few other sets of API documentation. We won't focus on them here, but note that they concern various other parts of the QDK:

- *.NET libraries* contain references for the trace-simulator target machine and the .NET quantum chemistry library (those parts of the quantum chemistry library that are represented outside the Q# program).
- *Python libraries* contain details about integration with Python as a host program.
- *IQ# magic commands* are the magic commands that can be used in Jupyter Notebooks (for example, the [`%package` command](/qsharp/api/iqsharp-magic/package?azure-portal=true) that adds a package to the workspace).

### Q# library API references

In the **Q# libraries** drop-down list, you can find the documentation for all of the Q# libraries (operations, functions, and user-defined types) organized by namespace:

:::image type="content" source="../media/3-api-namespaces.png" alt-text="Screenshot that shows the Q sharp libraries API opened to namespaces.":::

### Finding something in particular

Are you looking for a specific operation, function, or type? Use the **Filter by title** box above the table of contents. It includes the API references and can take you straight to the right page. The following example shows how you can filter the table of contents if you want to find the `ControlledOnInt` function:

:::image type="content" source="../media/3-filter-by-title-1.png" alt-text="Screenshot that shows filtering titles for a specific function." border="false":::

## Where does it come from?

The API documentation is automatically generated from the documentation comments within the Q# source code. Later in the module, you'll learn more about how the documentation is embedded in the source code when you write documentation comments for your own operations.

For now, we'll take you through an example to show you what you can expect and learn from the documentation. Because it will be the centerpiece of our oracle in the next unit, let's check out the [`MultiplyAndAddByModularInteger` operation](/qsharp/api/qsharp/microsoft.quantum.arithmetic.multiplyandaddbymodularinteger?azure-portal=true). Although this is an operation, note that the pages for functions and types are laid out in the same way.

## What does it tell me?

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWxup4]

### What's next?

In the next unit, we change gears to actually start using the Q# libraries.

You'll use the standard library to define an oracle, and you'll use Grover's algorithm to determine the missing digit of the ISBN of a book you that desperately need to save your spaceship.
