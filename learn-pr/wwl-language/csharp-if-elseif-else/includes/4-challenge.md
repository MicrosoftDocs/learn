Code challenges will reinforce what you've learned and help you gain some confidence before proceeding.

## Challenge: Improve renewal rate of subscriptions

You've been asked to add a feature to your company's software. The feature is intended to improve the renewal rate of subscriptions to the software. Your task is to display a renewal message when a user logs into the software system and is notified their subscription will soon end. You'll need to add a couple of decision statements to properly add branching logic to the application to satisfy the requirements.

## Prepare your coding environment

1. Ensure that you have an empty Program.cs file open in Visual Studio Code.

    If necessary, open Visual Studio Code, and then complete the following steps to prepare a Program.cs file in the Editor:

    1. On the **File** menu, select **Open Folder**.

    1. Use the Open Folder dialog to navigate to, and then open, the **CsharpProjects** folder.

    1. In the Visual Studio Code EXPLORER panel, select **Program.cs**.

    1. On the Visual Studio Code **Selection** menu, select **Select All**, and then press the Delete key.

1. To create the initial code for this challenge, enter the following code:

    ```c#
    Random random = new Random();
    int daysUntilExpiration = random.Next(12);
    int discountPercentage = 0;
    
    // Your code goes here
    
    ```

    Notice that this code will generate a random number with a value of 0 - 11. The random number is assigned to an integer variable named `daysUntilExpiration`. You have another integer variable named `discountPercentage` that is initialized to `0`.

    > [!IMPORTANT]
    > In this challenge, you can only remove the code comment. In other words, you may remove the line of code that starts with `//`, but you may not remove any other code. Furthermore, you must use each of the variables in your solution.

## Review the business rules for this challenge

1. Rule 1: Your code should only display one message.

    The message that your code displays will depend on the other five rules. For rules 2-6, the higher numbered rules take precedence over the lower numbered rules.

1. Rule 2: If the user's subscription will expire in 10 days or less, display the message:

    ```Output
    Your subscription will expire soon. Renew now!
    
    ```

1. Rule 3: If the user's subscription will expire in five days or less, display the messages:

    ```Output
    Your subscription expires in _ days.
    Renew now and save 10%!
    
    ```

    >[!NOTE]
    > Be sure to replace the `_` character displayed in the message above with the value stored in the variable `daysUntilExpiration` when you construct your message output.

1. Rule 4: If the user's subscription will expire in one day, display the messages:

    ```Output
    Your subscription expires within a day!
    Renew now and save 20%!
    
    ```

1. Rule 5: If the user's subscription has expired, display the message:

    ```Output
    Your subscription has expired.
    
    ```

1. Rule 6: If the user's subscription doesn't expire in 10 days or less, display nothing.

## Implement your solution code using `if` statements

Your solution must use separate `if` and `if-else` statements to implement the business rules. The `if-else` statement can include multiple `else if` parts.

1. Create an `if-else` statement that displays a message about when the subscription will expire.

    > [!TIP]
    > Use an `else if` to ensure each expiration rule is accounted for.

1. Create a separate `if` statement that displays a discount offer.

    The business rules indicate when a discount should be offered.

Whether you get stuck and need to peek at the solution or you finish successfully, proceed to view a solution to this challenge.
