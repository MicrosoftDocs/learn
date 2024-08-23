


In this challenge exercise, you need to use the Visual Studio Code debugger tools to isolate and fix the issues that are preventing the `MakeChange` method from successfully balancing the till. Once your application is updated, you need to verify your results.

## Specification

The following specification requirements apply to the simulated transactions:

- top-level statements simulate transactions using randomly generated item costs.
- top-level statements generate random values for `itemCost` in the range `2 - 49`.
- top-level statements simulate 100 transactions.

The reported transaction output must include:

- A record of 100 attempted transactions.
- Instances of a message stating: "Could not make transaction: InvalidOperationException: Not enough money provided to complete the transaction."
- Instances of a message stating: "Could not make transaction: InvalidOperationException: The till is unable to make change for the cash provided."
- A reported till value that's equal to the expected till value.

## Debug the application

Use the following steps to isolate and fix the logic issues:

1. Configure the debug environment.

1. Run the application in a debug session.

1. Use the Visual Studio Code debugger tools to isolate and fix the logic issues.

1. Save the updated the application.

## Check your work

To validate that your updated application produces the expected results when implementing the specified simulation requirements, complete the following steps:

1. Open the Program.cs file in the Visual Studio Code Editor.

1. Configure the application variables to meet the simulated transaction requirements in the **Specification** section.

1. Run your updated application.

1. Verify that your application achieves the following output requirements:

    - The transactions report includes a record of 100 attempted transactions.
    - The transactions report includes a reported till value that's equal to the expected till value.
    - The transactions report includes instances of the following messages:

        ```output
        Could not make transaction: InvalidOperationException: Not enough money provided to complete the transaction.
        ```

        ```output
        Could not make transaction: InvalidOperationException: The till is unable to make change for the cash provided.
        ```

Congratulations if you succeeded in this challenge!
