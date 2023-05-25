



In this guided project, you use Visual Studio Code to update an existing C# application. Your updates focus on code debugging and adding exception handling to the application. You review and debug the application, implement a `try-catch` pattern in top-level statements, and then throw exceptions from within a method that're caught in the top-level statements.

## Project overview

You're part of a team that's working on retail-support applications. The code that you're developing, the `MakeChange` method, manages the money till for a cash register application. Your application must meet the following specifications:

- A C# console application that simulates daily purchase transactions.
- The application calls the `MakeChange` method to manage the money till during transactions. `MakeChange` accepts cash payments and returns change.
- The calling application independently verifies the till balance after each transaction.
- A `try-catch` pattern is implemented to manage exceptions as follows:

    - Exceptions are used to report and handle any issue that prevents a transaction from completing successfully.
    - Exceptions are created and thrown in the `MakeChange` method.
    - Exceptions are caught and handled in the calling application.

An application that simulates transactions and calls the `MakeChange` method has already been developed. The Starter code project for this Guided project module includes a Program.cs file that includes the following code:

- Simulate transactions: the top-level statements configure application data and simulate a series of transactions using either a small `testData` array or a larger number of randomly generated transactions.
- Initialize the till: the `LoadTillEachMorning` method is used to configure the cash register till with a predefined number of bills in each denomination.
- Process transactions: the `MakeChange` method is used to manage the cash till during purchase transactions.
- Report till status: the `LogTillStatus` method is used to display the number of bills of each denomination currently in the till.
- Report till balance: the `TillAmountSummary` method is used display a message showing the amount of cash in the till.

> [!NOTE]
> To keep the calculations simple, all item costs are whole numbers and include any tax or fee. This keeps the coding tasks focused on debugging and exception handling.

Your goal for this module is to verify that the application logic is working correctly, isolate and correct any logic bugs, and implement exception handling. To achieve this goal, you'll complete the following exercises:

1. Review and debug the existing application code.
1. Update the application to implement exception handling.

## Setup

Use the following steps to prepare for the Guided project exercises:

1. To download a zip file containing the Starter project code, select the following link: [Lab Files](https://github.com/MicrosoftLearning/Guided-project-debugging-CSharp/archive/refs/heads/main.zip).

1. Unzip the download files.

    Unzip the files in your development environment. Consider using your PC as your development environment so that you have access to your code after completing this module. If you aren't using your PC as your development environment, you can unzip the files in a sandbox or hosted environment.

    1. On your local machine, navigate to your downloads folder.
    1. Right-click **Guided-project-debugging-CSharp-main.zip**, and then select **Extract all**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Copy the extracted **GuidedProject** folder to your Windows Desktop folder.

    > [!NOTE]
    > If a folder named **GuidedProject** already exists, you can select **Replace the files in the destination** to complete the copy operation.

1. Open the new **GuidedProject** folder in Visual Studio Code.

    1. Open Visual Studio Code in your development environment.
    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.
    1. Navigate to the Windows Desktop folder and locate the "GuidedProject" folder.
    1. Select **GuidedProject** and then select **Select Folder**.

        The Visual Studio Code EXPLORER view should show the **GuidedProject** folder and two subfolders named **Final** and **Starter**.

You're now ready to begin the Guided project exercises. Good luck!
