Now let's go over some of the test tools built in to Visual Studio to help you get the most out of testing.

## View your test suite in Test Explorer

A test suite is any collection of tests. There are many ways you can group tests, depending on what task is at hand.

You can view a list of all your tests in Test Explorer in Visual Studio. To open this window, use the top-level **Test** menu and select **Test Explorer**.

:::image type="content" source="../media/test-explorer-menu.png" alt-text="Screenshot that shows selections for opening Test Explorer in Visual Studio.":::

The name of each test appears in an easily browsable list. The following example shows six tests, with five passing and one failing.

:::image type="content" source="../media/test-explorer.png" alt-text="Screenshot of the Test Explorer window in Visual Studio, with a list of tests.":::

You can use the search box to search for a specific test or substring. The following example shows the word *null* typed into the search box. The test list is filtered to only the test names that contain the substring `null`.

:::image type="content" source="../media/test-explorer-search.png" alt-text="Screenshot of Test Explorer with the test names filtered based on a word in the search box.":::

The view of tests is highly customizable to better handle browsing through huge code bases with thousands (or even hundreds of thousands) of tests. You can use buttons to filter the view by state.

The **Group by** button lets you customize how the test groupings appear in the hierarchy. You can control what levels appear in the hierarchy and how many tiers there are. The following example shows a list of grouping options for the test hierarchy view. Only the class grouping is selected, and the test list shows the tests grouped by class.

:::image type="content" source="../media/test-explorer-groupby.png" alt-text="Screenshot of Test Explorer with the button and menu for grouping options.":::

The following example shows tests grouped by **Project** and then **Namespace**.

:::image type="content" source="../media/test-explorer-customized-groupby.png" alt-text="Screenshot of Test Explorer with Project and Namespace groupings.":::

In the next exercise, we'll delve deeper into Test Explorer functionality. If you want a full list of capabilities of this window, you can read more in the [Test Explorer docs](/visualstudio/test/run-unit-tests-with-test-explorer).

## Run test suites

The green run button in Test Explorer runs all tests. If you hover over the button, a tip that reads **Run All Tests In View** appears.

:::image type="content" source="../media/test-explorer-run-all.png" alt-text="Screenshot of the Visual Studio Test Explorer toolbar with the green run button and hover tip.":::

After the first test run, the small CodeLens test glyphs show the test result in the code editor at every test method. In the following example, the glyphs at the top of test method signatures are green to signify passing tests.

:::image type="content" source="../media/code-lens.png" alt-text="Screenshot of the editor with CodeLens test glyphs at the top appearing in green.":::

## Debug tests

Debugging lets you pause the application to explore variables and what's happening during the execution of your test. Debugging tests is especially helpful because you can precisely isolate which function you want the debugger to step through programmatically. This avoids the need to manually browse through your app until you trigger the method that you want to test.

To hit a breakpoint, right-click the `AddTest` method in the Visual Studio editor, and then select **Debug Test(s)**.

:::image type="content" source="../media/debug.png" alt-text="Screenshot of the Visual Studio editor with the right-click menu open inside the AddTest method and Debug Tests selected.":::

As in debugging a regular app, when you debug a test, you can hover over or pin variables to see their values and step through the execution of the code. In the following example, Visual Studio is paused during debugging at a breakpoint set inside the `AddTest` method on the `Assert` line. Debugger windows are visible, along with a window that shows the value of the variable in the test.

:::image type="content" source="../media/breakpoint.png" alt-text="Screenshot that shows Visual Studio paused during debugging, with debugger windows visible.":::

## Additional learning

* [Test Explorer documentation](/visualstudio/test/run-unit-tests-with-test-explorer)
* [Documentation for advanced Visual Studio testing tools](/visualstudio/test/improve-code-quality)
