After diagnostics identify a hardware issue that requires replacement, Surface Repair Tool (SRT) can guide you through supported Field-Replaceable Unit (FRU) repair workflows. These workflows help prepare the device for repair and provide validation, calibration, and functionality testing after the hardware replacement.

The steps can vary depending on the component being replaced. In general, an SRT repair workflow can include:

1. Optional pre-repair validation of the existing component.
2. Entering **System Repair Mode**.
3. Performing the physical hardware replacement.
4. Completing post-repair validation and calibration.
5. Running functionality tests to confirm the repair.

>[!IMPORTANT]
> SRT guides the repair workflow, but use the applicable Surface repair documentation for the physical hardware replacement procedure. SRT provides access to the Surface Service Repair Guide from the Home page and additional repair documentation through the Support section.

## Start a repair

:::image type="content" border="true" source="../media/start-repair.png" alt-text="Screenshot showing the Start a repair option in Surface Repair Tool with options for diagnostics for battery, touchpad, touch display module, and motherboard.":::

You can access repair workflows by selecting **Repair** from the left navigation menu or **Start a repair** from the Home page. From the Repair page, select the FRU repair workflow for the component you're replacing.

Before a physical hardware replacement, SRT prompts you to enter **System Repair Mode**, which shuts down the device. After replacing the component, power on the device, return to Windows, and relaunch SRT to continue the workflow.

>[!NOTE]
> In the above screenshot, the buttons are greyed out. This is to encourage end users to contact their IT administrators to initiate the repair on commercial devices.

## Follow a battery repair workflow

A battery replacement demonstrates how SRT can guide you from pre-repair validation through post-repair testing.

**Step 1: Verify battery health**

:::image type="content" border="true" source="../media/verify-battery-health.png" alt-text="Screenshot showing the battery health verification step in Surface Repair Tool.":::

SRT provides an optional check of the existing battery before replacement.

1. Select the battery repair workflow.
2. Select **Step 1**, and then select **Start**.
3. On the Checkup page, select **Next**.
4. Review whether SRT reports that the battery health falls within the appropriate range.
5. Select **Yes** or **No** to confirm the result, and then select **Finish**.

This step is optional, but provides an opportunity to validate the existing component before proceeding with the replacement.

**Step 2: Enter System Repair Mode**

:::image type="content" border="true" source="../media/system-repair-mode.png" alt-text="Screenshot showing the prompt to enter System Repair Mode in Surface Repair Tool.":::

Before replacing the battery, use SRT to enter System Repair Mode.

1. Select **Step 2** to initiate System Repair Mode.
2. When prompted, select **Yes** to confirm the shutdown.
3. Allow the device to shut down.
4. If it doesn't shut down within a few seconds, press and hold the power button until the device powers off.
5. With the device powered off, perform the battery replacement by following the applicable repair instructions.

**Step 3: Validate the repair**

After completing the hardware replacement, return to SRT to validate the repair.

1. Power on the Surface device and allow it to boot to Windows.
2. Relaunch Surface Repair Tool.
3. Select the **Battery repair** workflow.
4. Select **Step 3**.
5. Allow SRT to perform repair validation automatically.
6. Wait for validation to complete before continuing.

This return to SRT is an important part of the workflow because the repair process continues after the physical component has been replaced.

**Step 4: Complete functionality testing**

:::image type="content" border="true" source="../media/functionality-testing.png" alt-text="Screenshot showing the functionality testing step in Surface Repair Tool.":::

Finally, use SRT to check system functionality.

1. Select **Step 4**.
2. Follow the guided system functionality test workflow.
3. Continue following the on-screen instructions until the tests are complete.

Together, repair validation and functionality testing provide the post-repair portion of the SRT workflow.

## Next steps

You've now seen how Surface Repair Tool supports the workflow from identifying a potential hardware issue through validating a completed repair. Next, you'll explore the support resources and settings available in SRT and where to find additional guidance when a problem can't be resolved through the guided workflow.
