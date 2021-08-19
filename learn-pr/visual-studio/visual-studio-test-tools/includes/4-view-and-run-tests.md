Now that you can write and run tests let's go over some of the test tools built-in to Visual Studio to help you get the most out of testing.

* View your test suite in the Test Explorer
* Run test suites
* Debugging tests

## View your test suite in the Test Explorer

* A test suite is any collection of tests. There are many ways you can group tests depending on what task is at hand.
* You can view a list of all your tests in the Test Explorer in Visual Studio. To open this window use the top-level "Test" menu and select "Test Explorer."

   :::image type="content" source="../media/test-menu-test-explorer.png" alt-text="Screenshot in Visual Studio of top-level menu item Test open and Test Explorer highlighted within the sub menu.":::

   :::image type="content" source="../media/test-explorer.png" alt-text="Screenshot in Visual Studio of Test Explorer window. 6 tests are visible with 5 passing tests and 1 failing test in the list.":::

* The name of each test appears in an easily navigable list. Note you can use the search box to search for a specific test or substring.

   :::image type="content" source="../media/test-explorer-search.png" alt-text="Screenshot in Visual Studio of Test Explorer with the word null typed into the search box. The test list is filtered to only the test names that contain the substring null.":::

* The view of tests is highly customizable to better handle navigating huge code bases with thousands (or even hundreds of thousands!) of tests. You can use buttons to filter the view by state.
* The "Group by" button lets you customize how the test groupings appear in the hierarchy. You can control what levels appear in the hierarchy and how many tiers there are.

   :::image type="content" source="../media/test-explorer-groupby.png" alt-text="Screenshot in Visual Studio of Test Explorer with call out indicating the groupby button. The groupby menu is open showing a list of different grouping options for the test hierarchy view. Only the class grouping is selected and the test list shows the tests grouped by class.":::

* View of the Project and Namespace group by setting.

   :::image type="content" source="../media/test-explorer-customized-groupby.png" alt-text="Screenshot in Visual Studio of Test Explorer groupby showing two new groupings selected Project as the first selection and Namespace as the second. The test list shows tests grouped by Project and then Namespace.":::

In the next exercise we'll delve deeper into Test Explorer functionality, but if you want a full list of capabilities of this window you can read more in the [Test Explorer docs](/visualstudio/test/run-unit-tests-with-test-explorer).

## Run test suites

* The green run button in the Test Explorer Runs All Tests.

   :::image type="content" source="../media/test-explorer-run-all.png" alt-text="Screenshot of Visual Studio Test Explorer toolbar with the green run button selected and a hover tip that reads Run All Tests In View (CTRL+R,V)":::

* After the first test run the small CodeLens test icons now show the test result in the code editor at every test method.

   :::image type="content" source="../media/test-code-lens.png" alt-text="Screenshot in Visual Studio of editor where the CodeLens test icon at the top of test method signatures is now green to signify a passing test.":::

## Debugging tests

* Debugging lets you pause the application to explore variables and what is happening during the execution of your test. Debugging tests is especially helpful because you can precisely isolate which function you'd like the debugger to step through programmatically rather than manually using your app until you trigger the method you would like to test.

* Select `Debug test(s)` in the right-click context menu in order to hit a breakpoint.

   :::image type="content" source="../media/test-debug.png" alt-text="Screenshot of Visual Studio editor with the right click menu open inside the AddTest method. Debug Tests is selected.":::

* Just as in debugging a regular app, when you debug a test you can hover or pin variables to see there values and step through the execution of the code.

   :::image type="content" source="../media/test-breakpoint.png" alt-text="Screenshot of Visual Studio paused during debugging at a breakpoint set inside the AddTest method on the Assert line. Debugger windows are visible as well as a quick info window showing the value of the actual variable in the test.":::
