Code challenges reinforce what you've learned, and help you gain some confidence before continuing on.

The focus of this challenge is to create a method with the proper parameters, including an optional parameter.

## Display email addresses

Your challenge is to create a method that displays the correct email address for both internal and external employees. You're given lists of internal and external employee names. An employee's email address consists of their username and company domain name. 

The username format is the first two characters of the employee first name, followed by their last name. For example, an employee named "Robert Bavin" would have the username "robavin". The domain for internal employees is "contoso.com". 

In this challenge, you're given some starting code. You must decide how to create and call a method to display email addresses.

## Code challenge: Add a method to display email addresses

In the code you start with, there are two arrays for internal and external employees. Remember, the domain for internal employees is "contoso.com" and the username for all employees is the first two characters of their first name, followed by their full last name.

Your challenge is to create a method that will display the email address of internal and external employees. The method should include an optional parameter for the domain name of external employees.

1. Ensure that you have an empty Program.cs file open in Visual Studio Code.

    If necessary, open Visual Studio Code, and then complete the following steps to prepare a Program.cs file in the Editor:

    1. On the **File** menu, select **Open Folder**.

    1. Use the Open Folder dialog to navigate to, and then open, the **CsharpProjects** folder.

    1. In the Visual Studio Code EXPLORER panel, select **Program.cs**.

    1. On the Visual Studio Code **Selection** menu, select **Select All**, and then press the Delete key.

1. Copy and paste the following code into the Visual Studio Code Editor.

    ```c#
    string[,] corporate = 
    {
        {"Robert", "Bavin"}, {"Simon", "Bright"},
        {"Kim", "Sinclair"}, {"Aashrita", "Kamath"},
        {"Sarah", "Delucchi"}, {"Sinan", "Ali"}
    };

    string[,] external = 
    {
        {"Vinnie", "Ashton"}, {"Cody", "Dysart"},
        {"Shay", "Lawrence"}, {"Daren", "Valdes"}
    };

    string externalDomain = "hayworth.com";

    for (int i = 0; i < corporate.GetLength(0); i++) 
    {
        // display internal email addresses
    }

    for (int i = 0; i < external.GetLength(0); i++) 
    {
        // display external email addresses
    }
    ```

1. Update the code to use a method to display the email addresses according to the challenge specifications.

    Use what you've learned about using parameters and optional arguments to complete the update.

1. Verify that your code produces the following output:

    ```
    robavin@contoso.com
    sibright@contoso.com
    kisinclair@contoso.com
    aakamath@contoso.com
    sadelucchi@contoso.com
    siali@contoso.com
    viashton@hayworth.com
    codysart@hayworth.com
    shlawrence@hayworth.com
    davaldes@hayworth.com
    ```

Whether you get stuck and need to peek at the solution or you finish successfully, continue on to view a solution to this challenge.