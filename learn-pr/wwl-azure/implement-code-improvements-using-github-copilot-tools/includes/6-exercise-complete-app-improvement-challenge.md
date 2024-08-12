Code challenges reinforce what you learned and help you gain some confidence before proceeding.

## Challenge: Use GitHub Copilot Chat to improve the APL2007M5SalesReport application

In this challenge exercise, you need to update the APL2007M5SalesReport project in each of the three improvement areas covered during this module:

1. Code quality. For this area, you focus on improving modularity.
1. Reliability and Performance. For this area, you focus on improving error handling.
1. Security. For this area, you focus on restricting access to authenticated users.

## Prepare your coding environment

To open and test the **APL2007M5SalesReport** sample application, complete the following steps:

1. Locate the SampleApps folder.

    If you can't locate the SampleApps folder, the following link to download a zip file containing the sample apps: [SampleApps](https://raw.githubusercontent.com/MicrosoftLearning/APL-2007-Accelerate-app-development-by-using-GitHub-Copilot/master/LearnModuleExercises/Downloads/SampleApps.zip).

1. Open the **APL2007M5SalesReport** sample application in Visual Studio Code.

1. Ensure that the application builds and runs successfully before you start the challenge.

## Challenge requirements

You need to complete the following tasks in the order listed:

1. Use the suggestions from two or more prompts to improve the modularity of the **QuarterlySalesReport** method.

    - Extract the code that builds report tables to a separate method named DisplayReports. This method should accept the required input parameters and return a Boolean that indicates successful completion.
    - Extract the code that identifies the top three products to a separate method named TopThree.

1. Use the suggestions from one or more prompts to improve error handling for the **QuarterlyIncomeReport** class.

    - Implement error handling for at least three methods that contribute displaying the sales report.

1. Use the suggestions from one or more prompts to ensure that only authenticated users are able to access sales information.

    - Restrict access to the **QuarterlySalesReport** method to authenticated users only.
    - Ensure that unauthenticated users can't access the methods used to generate sales reports.

1. You aren't allowed to write code directly. You must use GitHub Copilot or GitHub Copilot Chat to generate the code. Starting a code line to see code completion suggestions is allowed (for example, typing `if` and then using the suggestions to complete the code).

1. You're allowed to fix errors in code updates suggested by GitHub Copilot and GitHub Copilot Chat when GitHub Copilot is unable to fix the issue.

## Challenge instructions

You need to submit prompts to GitHub Copilot Chat and use the generated suggestions to improve the **APL2007M5SalesReport** application.

Use the following steps to complete this challenge:

1. Create prompts that address the following improvement goals:

    - Improve the modularity of the **QuarterlySalesReport** method.
    - Improve error handling for three methods in the **QuarterlyIncomeReport** class that contribute generating the sales report.
    - Restrict access to the **QuarterlySalesReport** method to authenticated users. Ensure that unauthenticated users can't access the methods used to generate sales reports.

1. Submit each of your modularity prompts, then review and implement suggested updates.

    > [!NOTE]
    > After implementing the first "modularity" prompt, you can use code line completion suggestions to further improve the modularity of the **QuarterlyIncomeReport** class without submitting additional prompts.

1. Submit each of your reliability prompts, then review and implement suggested updates.

    > [!NOTE]
    > After implementing the first "reliability" prompt, you can use code line completion suggestions to further improve the modularity of the **QuarterlyIncomeReport** class without submitting additional prompts.

1. Submit each of your code security prompts, then review and implement suggested updates.

    > [!NOTE]
    > After implementing the first "code security" prompt, you can use code line completion suggestions to further improve the modularity of the **QuarterlyIncomeReport** class without submitting additional prompts.

1. You can improve the application beyond the specified requirements.

1. Once you're done making improvements, Build the solution and ensure that there are no build errors.

1. Review your solution and ensure that it meets the following requirements:

    - The code that builds report tables is in a method named DisplayReports. This method defines the necessary data parameter and returns a Boolean that indicates successful completion.
    - The code that identifies the top three products is in a method named TopThree.
    - Exception handling is implemented in at least three methods that contribute displaying the sales report.
    - Only authenticated users can access the **QuarterlySalesReport** method.
    - Unauthenticated users can't access the methods used to generate sales reports.

1. Run the application and ensure that:

    - sales data reports can be generated by authenticated users.
    - sales data reports can't be generated by unauthenticated users.
    - all reports generated by authenticated users are displayed correctly.
    - exception handling is secure and works as expected.
