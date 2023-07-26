


Code challenges will reinforce what you've learned and help you gain some confidence before continuing on.

## Decision logic challenge

In this challenge, you'll implement decision logic based on a series of business rules. The business rules specify the access that will be granted to users based on their role-based permissions and their career level. Code branches will display a different message to the user depending on their permissions and level.

### Initialize permission and level values

1. Ensure that you have an empty Program.cs file open in Visual Studio Code.

    If necessary, open Visual Studio Code, and then complete the following steps to prepare a Program.cs file in the Editor:

    1. On the **File** menu, select **Open Folder**.

    1. Use the Open Folder dialog to navigate to, and then open, the **CsharpProjects** folder.

    1. In the Visual Studio Code EXPLORER panel, select **Program.cs**.

    1. On the Visual Studio Code **Selection** menu, select **Select All**, and then press the Delete key.

1. Type the following code into the Visual Studio Code Editor:

    ```c#
    string permission = "Admin|Manager";
    int level = 55;
    ```

1. Review the initial code lines.

    Your application will be using a combination of `permission` and `level` to apply/evaluate the business rules in this challenge scenario. The full list of conditions for business rules is specified in the next step. Your completed solution must use `permission` and `level`.

    > [!TIP]
    > To sufficiently test all of the combinations for `permission` and `level` that are described in the business rules below, you will need to assign additional values to these variables and run the application multiple times.

### Implement business rules

> [!IMPORTANT]
> You will need to use the `Contains()` helper method to determine whether the value assigned to the `permission` string contains one of the permission values specified by the "business rules". For example, the expression `permission.Contains("Admin")` will return `true` when using the initial data values specified in the code above.

Here are the **Business Rules** that your solution must satisfy:

- If the user is an Admin with a level greater than 55, output the message:

    ```Output
    Welcome, Super Admin user.
    ```

- If the user is an Admin with a level less than or equal to 55, output the message:

    ```Output
    Welcome, Admin user.
    ```

- If the user is a Manager with a level 20 or greater, output the message:

    ```Output
    Contact an Admin for access.
    ```

- If the user is a Manager with a level less than 20, output the message:

    ```Output
    You do not have sufficient privileges.
    ```

- If the user is not an Admin or a Manager, output the message:

    ```Output
    You do not have sufficient privileges.
    ```

1. Update your Program.cs code to accommodate each of the business rules.

1. Save your code.

### Test your solution using the initial data values suggested

1. Build and run your code.

1. Evaluate the output.

    When you run your code, including the initial configuration data, you should see the following output:

    ```Output
    Welcome, Admin user.
    ```

### Test for the other business rules

1. Update the values assigned to `permission` and `level`.

1. Save and run your code.

1. Evaluate the output to verify that the other business rules are satisfied.

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.
