Completing a diagnostic test is only part of the troubleshooting process. After Surface Repair Tool (SRT) completes one or more tests, use the results to review the hardware that was tested and determine an appropriate next step.

The **Test Results** page summarizes the outcome of the diagnostic session. It displays a pass or fail status for each subsystem tested and provides options to view detailed results, rerun tests, and access available fixes for failed tests.

## Review the test results

Start by reviewing the results for each diagnostic you ran.

The **Test Results** page provides:

- A pass or fail status for each subsystem tested.
- Options to view detailed results for an individual test.
- Fix options for failed tests when a relevant repair workflow is available.
- Options to rerun individual tests or the full test session.

These results help you determine whether to complete testing, repeat a diagnostic, or continue to an available repair workflow.

## Rerun a diagnostic test

In some situations, you can repeat a test before continuing to a repair workflow. SRT provides options to rerun an individual diagnostic or repeat the entire test session.

For example, some diagnostics depend on external hardware or specific device conditions. During the Bluetooth test, the Bluetooth accessory must be in pairing mode, and Bluetooth must be turned on for the Surface device. If the accessory isn't detected, the source guidance recommends checking these conditions and trying the test again before concluding that there is a hardware issue.

To troubleshoot a failed Bluetooth test:

1. Confirm that Bluetooth is turned on in **Settings** > **Bluetooth & devices**.
2. Make sure the Bluetooth accessory is in pairing mode.
3. Move the accessory within 1-2 meters of the Surface device.
4. Try another Bluetooth device to help rule out an accessory issue.
5. Restart the Surface device and run the test again if necessary.

This illustrates an important part of using SRT: a failed result can be followed by additional troubleshooting or retesting when appropriate.

## Move from diagnostics to repair

If a test fails and SRT provides a **Fix** option, you can use it to access the relevant repair workflow.

A typical progression is:

1. **Review the test result** and identify the subsystem that failed.
2. **View the available details** for the failed test.
3. **Rerun the test** if additional testing is appropriate.
4. If a fix option is provided, **open the relevant repair workflow**.

This creates a connected experience between SRT's two primary capabilities: diagnostics can help identify a hardware problem, while supported repair workflows guide you through the steps associated with hardware replacement and validation.

## Understand what happens during a repair workflow

When you move into a supported repair workflow, SRT uses a structured sequence. Depending on the repair, the sequence includes:

1. Optional pre-repair validation of the existing component.
2. Entering **System Repair Mode**, which shuts down the device.
3. Performing the physical hardware replacement.
4. Completing automated post-repair validation and calibration.
5. Running system functionality test to confirm the repair.

Before a physical hardware replacement in the documented SRT workflow, the tool prompts you to enter System Repair Mode. Following the replacement, you power on the device, relaunch SRT, and continue through the remaining workflow.

Detailed physical replacement procedures should be followed from the applicable Surface repair documentation. SRT provides access to the Surface Service Repair Guide from the Home page, and additional official repair documentation is available through its Support section.

## Next steps

You've now seen how diagnostic results can help you decide whether to rerun a test, continue troubleshooting, or move into an available repair workflow. Next, you'll explore how SRT guides you through a supported repair, from preparing the device for hardware replacement through post-repair validation and functionality testing.
