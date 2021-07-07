# View, Run, and Debug tests

<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: state what's in this unit and how it aligns to the 'describe' learning objective.

    Pattern:
        One paragraph of 2-3 sentences:
            Sentence 1: State that this unit addresses ("how it works").
            Sentence 2: State that this unit targets this learning objective: "Describe how (features) of (product) work to (solve problem)."
            Sentence 3-4 (optional): Give the rationale ("helps you decide if it will meet your needs").
        Table-of-contents as a bulleted list (do not simply list every heading you'll have on the page, group them into about 3 high-level areas).

    Heading: none

    Example: "Here, we'll discuss how Logic Apps works behind the scenes. You'll learn about all the pieces of Logic apps and see how they fit together into an app. This knowledge will help you decide whether Logic Apps will work for you without any customization. In cases where you do need to create custom components, you'll be able to determine how difficult it will be.
        * Connectors, triggers, actions
        * Control actions
        * Logic Apps Designer"
-->
Testing 

* 

## View your tests in the Test Explorer.

* You can view your list of tests in the Test Explorer in Visual Studio. To open this window use the top-level "Test" menu and select "Test Explorer."
* The name of each of your tests appear in an easily navigable list. Note you can use the search box to search for a specific test or substring.
* The view of tests is highly customizable to better handle navigating huge code bases with hundreds of thousands of tests. You can use buttons to filter the view to by state. Try filtering to show only failed tests.
* The "Group by" button lets you customize how the test groupings appear in the hierarchy. Try a new grouping by de-selecting the presets and only grouping by Project and Namespace. You can control what levels appear in the hierarchy and how many.

![image](../media/test)

## Run your tests

* Click the green run button in the Test Explorer to Run All Tests.
* Note that small icons now show the test result in the code editor at every test method. This helpful feature is one part of CodeLens. You can use these icons to run, debug, and view test output without leaving the code editor.

## Debug a test

* Set a breakpoint in one of the tests you have created by clicking in the margin of the code editor.
* Right-click inside of the test in the code editor and select 'Debug Test.' Debugging tests let you pause the application to explore variables and what is happening during the execution of your test. Debugging tests is especially helpful because you can precisely isolate which function you'd like the debugger to step through programmatically rather than manually using your app until you trigger the method you would like to test.

![image](../media/)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->