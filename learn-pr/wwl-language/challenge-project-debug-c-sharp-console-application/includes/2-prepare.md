


In this challenge project, you'll use the Visual Studio Code debugger tools to debug a C# console application.

## Project specification

The Starter code project for this module includes a Program.cs file with the following code features:

- Simulate transactions: the top-level statements configure application data and simulate a series of transactions using either a small `testData` array or a larger number of randomly generated transactions.
- Initialize the till: the `LoadTillEachMorning` method is used to configure the cash register till with a predefined number of bills in each denomination.
- Process transactions: the `MakeChange` method is used to manage the cash till during purchase transactions.
- Report till status: the `LogTillStatus` method is used to display the number of bills of each denomination currently in the till.
- Report till balance: the `TillAmountSummary` method is used display a message showing the amount of cash in the till.

The `MakeChange` method contains logic issues that prevent it from successfully balancing the money till during simulated transactions. You need to use the Visual Studio Code debugger tools to isolate and fix the logic issues.

To ensure that your `MakeChange` method is working correctly, your code must verify a successfully balanced till under the following conditions:

- top-level statements simulate the transactions using randomly generated item costs.
- top-level statements generate random values for `itemCost` in the range `2 - 49`.
- top-level statements simulate 100 transactions.
- the till is successfully balanced when the reported till value is equal to the expected till value. For example:

    ```output
    The till has 1184 dollars
    Expected till value: 1184
    ```

## Setup

Use the following steps to prepare for the Challenge project exercises:

1. To download a zip file containing the Starter project code, select the following link: [Lab Files](https://github.com/MicrosoftLearning/Challenge-project-debugging-CSharp/archive/refs/heads/main.zip).

1. Unzip the download files.

    Unzip the files in your development environment. Consider using your PC as your development environment so that you have access to your code after completing this module. If you aren't using your PC as your development environment, you can unzip the files in a sandbox or hosted environment.

    1. On your local machine, navigate to your downloads folder.
    1. Right-click **Challenge-project-debugging-CSharp-main.zip**, and then select **Extract all**.
    1. Select **Show extracted files when complete**, and then select **Extract**.
    1. Make note of the extracted folder location.

1. Copy the extracted **ChallengeProject** folder to your Windows Desktop folder.

    > [!NOTE]
    > If a folder named **ChallengeProject** already exists, you can select **Replace the files in the destination** to complete the copy operation.

1. Open the new **ChallengeProject** folder in Visual Studio Code.

    1. Open Visual Studio Code in your development environment.
    1. In Visual Studio Code, on the **File** menu, select **Open Folder**.
    1. Navigate to the Windows Desktop folder and locate the "ChallengeProject" folder.
    1. Select **ChallengeProject** and then select **Select Folder**.

        The Visual Studio Code EXPLORER view should show the **ChallengeProject** folder and two subfolders named **Final** and **Starter**.

You're now ready to begin the Challenge project exercises. Good luck!
