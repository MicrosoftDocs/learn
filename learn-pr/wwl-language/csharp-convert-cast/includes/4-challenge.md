Code challenges reinforce what you've learned and help you gain some confidence before continuing.

This module features two code challenges. This first challenge forces you to split up the data depending on its type and either concatenate or add the data accordingly.

1. Select and delete all code lines in the Visual Studio Code Editor. Optionally, use the line comment operator `//` to comment out all of the code from the previous step.

1. To instantiate a string array, enter the following "starter" code:

    ```csharp
    string[] values = { "12.3", "45", "ABC", "11", "DEF" };
    ```

1. Create a looping structure that can be used to iterate through each string value in the array `values`.

1. Complete the required code, placing it within the array looping structure code block. It's necessary to implement the following business rules in your code logic:

    - Rule 1: If the value is alphabetical, concatenate it to form a message.
    - Rule 2: If the value is numeric, add it to the total.
    - Rule 3: The result should match the following output:

        ```Output
        Message: ABCDEF
        Total: 68.3
        ```

1. Once your code is complete, in the Visual Studio Code **File** menu, select **Save**.

    The Program.cs file must be saved before building or running the code.

1. In the EXPLORER panel, to open a Terminal at your TestProject folder location, right-click **TestProject**, and then select **Open in Integrated Terminal**.

    A Terminal panel should open, and should include a command prompt showing that the Terminal is open to your TestProject folder location.

1. At the Terminal command prompt, to run your code, type **dotnet run** and then press Enter.

    You should see the following output:

    ```Output
        Message: ABCDEF
        Total: 68.3
    ```

    > [!NOTE]
    > If you see a message saying "Couldn't find a project to run", ensure that the Terminal command prompt displays the expected TestProject folder location. For example: `C:\Users\someuser\Desktop\csharpprojects\TestProject>`

Whether you get stuck and need to peek at the solution or you finish successfully, continue to view a solution to this challenge.
