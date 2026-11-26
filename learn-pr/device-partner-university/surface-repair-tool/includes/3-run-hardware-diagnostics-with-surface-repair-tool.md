Now that you are familiar with Surface Repair Tool (SRT), you can use its diagnostic capabilities to evaluate the functional health of hardware components on a Surface device. SRT provides guided tests for components and subsystems such as battery, display, cameras, audio, sensors, touch, wireless connectivity, storage, USB ports, Bluetooth, and Surface Pen.

Some tests require you to interact with the device, such as pressing keys or tracing a pattern on the touchscreen. Others ask you to change the device environment, such as adjusting lighting or connecting an accessory. SRT can also perform automated checks, such as validating storage health or checking for a wireless adapter. Each diagnostic concludes with a result and results summary.

## Choose diagnostic tests

:::image type="content" border="true" source="../media/choose-diagnostic-tests.png" alt-text="Screenshot of the Choose Diagnostic Tests page in Surface Repair Tool featuring check boxes for selecting diagnostic tests.":::

To begin testing, select **Test** from the left navigation menu. The Test page displays the available diagnostic tests for the device.

You can:

- Select individual tests to focus on specific hardware.
- Select multiple tests to investigate more than one component.
- Use **Select All** to select every available test.
- Use **Deselect All** to clear your selections.
- Run the selected tests within a single testing session.

When selecting tests, consider the hardware associated with the issue you're investigating. For example, if you're troubleshooting charging behavior, you can select the battery charging and discharging tests. For an issue with the display, you can use the brightness and color gradation tests. SRT also provides dedicated tests for components such as cameras, speakers, microphones, storage, USB ports, Bluetooth, touch, and other supported hardware.

## Run selected diagnostic tests

:::image type="content" border="true" source="../media/run-selected-tests.png" alt-text="Screenshot of the Run Selected Tests page in Surface Repair Tool showing the selected diagnostic tests ready to be executed.":::

After selecting the appropriate tests, follow the guided experience in SRT.

1. **Start the selected tests** and review the instructions presented for each test.
2. Complete any required actions, such as connecting or disconnecting hardware, pressing keys, interacting with the touchscreen, or responding to an on-screen prompt.
3. Use **Back** to return to the previous step if necessary.
4. Use **Skip** to bypass the current test or **Skip All** to bypass the remaining tests.
5. Continue through the guided experience until the selected tests are complete.
6. **Review the results summary** after testing concludes.

## Understand different types of diagnostic tests

Although SRT provides a consistent guided experience, the actions required depend on the hardware being tested.

For example, the **Driver Health Test** doesn't require interaction while the test is running. SRT automatically scans the hardware subsystems and reports whether driver or device errors are found.

Other tests require you to prepare additional hardware before starting. The USB diagnostic, for example, requires you to disconnect USB accessories and any connected Surface Dock before testing individual ports with a USB storage device.

This means it's important to review the instructions shown for each test and complete any required preparation before proceeding.

## Review your test results

:::image type="content" border="true" source="../media/test-results.png" alt-text="Screenshot of the Test Results Summary page in Surface Repair Tool showing the outcomes of the diagnostic tests.":::

After the diagnostic tests are complete, SRT provides a **Test Results** page summarizing the outcomes. The results include the pass or fail status for each subsystem tested and options for viewing additional details.

From the results, you can also rerun individual tests or the complete test session. When a failed test has an available fix option, SRT can link to the relevant repair workflow.

The results therefore provide a natural transition from diagnosing an issue to determining what to do next. A passed test can help validate the tested subsystem, while a failed test can identify where further troubleshooting or an available workflow is needed.

## Next steps

You've now seen how to select, run, and review hardware diagnostics in SRT. Next, you'll step through a specific diagnostic workflow to see how SRT guides you through the actions required to evaluate a Surface hardware component.
