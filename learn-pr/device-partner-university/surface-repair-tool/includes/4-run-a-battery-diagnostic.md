Surface Repair Tool (SRT) provides guided diagnostics that help you evaluate individual hardware components and subsystems. The battery diagnostics check both charging and discharging behavior to help validate power delivery and battery reporting.

The battery diagnostic is an example of an interactive SRT test. Rather than running entirely in the background, it prompts you to connect and disconnect the charger at specific points in the workflow. Following these instructions helps SRT evaluate battery behavior under both conditions.

## Test battery charging

:::image type="content" border="true" source="../media/test-battery-charging.png" alt-text="Screenshot of the Test Battery Charging page in Surface Repair Tool showing the button to start the test with a prompt to connect the charger.":::

Begin by connecting the Surface power charger to the device.

1. Connect the Surface power charger.
2. Keep the charger connected throughout the charging portion of the test.
3. Select **Start**.
4. SRT checks the battery while it's charging.
5. Wait for the test to complete before continuing.

A progress indicator shows that the charging test is running. Keep the charger connected until SRT prompts you to continue.

## Test battery discharging

:::image type="content" border="true" source="../media/test-battery-discharging.png" alt-text="Screenshot of the Test Battery Discharging page in Surface Repair Tool showing the button to start the test with a prompt to disconnect the charger.":::

After the charging test, SRT guides you through testing battery behavior while the device is disconnected from external power.

1. Disconnect the charger from the Surface device.
2. Keep the charger disconnected for the next part of the test.
3. Select **Start**.
4. SRT checks battery behavior while the battery is discharging.
5. Wait for the test to complete.

The combination of charging and discharging tests allow SRT to evaluate battery behavior under both conditions.

## Apply the same guided approach to other diagnostics

The actions you perform vary on the hardware being tested. For example:

- **Keyboard:** Prepare the keyboard, choose the correct layout if necessary, and press the physical keys as instructed. Detected keys turn blue on the on-screen keyboard diagram.
- **Display:** Observe the screen as the brightness changes, then confirm whether the change occurred as expected. The color and defects test asks you to check for issues such as flickering, noise, distortion, ghosting, or blur.
- **Touch:** Trace the pattern displayed on the screen and confirm whether the tracing was successful.
- **USB ports:** Disconnect USB accessories and any Surface Dock, then follow the SRT prompts to test each USB port individually with a USB storage device.
- **Driver health:** SRT scans the hardware subsystems automatically and reports whether driver or device errors are found. No interaction is required while the test runs.

These examples demonstrate why it's important to read the instructions presented by SRT before and during each diagnostic. Some tests run automatically, while others require you to prepare the device, connect hardware, or interact with a component.

## Review the diagnostic results

:::image type="content" border="true" source="../media/review-diagnostic-results.png" alt-text="Screenshot of the Test Results page in Surface Repair Tool showing the outcomes of the diagnostic tests.":::

After testing is complete, SRT displays the **Test Results** page. The results show a pass or fail status for each subsystem tested and provide options to view more detailed results. You can also rerun individual tests or the complete test session.

When a failed test has an available fix option, the results page can link directly to the relevant repair workflow.

Reviewing the results helps you determine whether additional testing is appropriate or whether you should continue to an available repair workflow.

## Next steps

You've now seen how SRT guides you through an interactive hardware diagnostic from preparation through results. Next, you'll learn how to use diagnostic results to determine an appropriate next step and respond when a test identifies a potential hardware issue.
