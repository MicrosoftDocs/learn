Testing is crucial for ensuring resize and reflow. In this section, we'll introduce some of the processes and tools that are helpful for testing and debugging resize and reflow support in your digital products.

## Manual Testing

Here are some ways to manually test your website or app for resize and reflow support.

- Change Display DPI Setting
  - Adjust the Display DPI setting on your device.
  - Verify that the apps render as expected without needing a restart.
- Check for Layout Issues
  - Look for any truncation or overlap of text and UI elements.
  - Ensure that all elements are displayed correctly.
- Test Across Monitors
  - Drag the app window between monitors with different DPI settings.
  - Confirm that the app renders correctly at the new DPI setting.
- Resize Web App Window
  - Manually resize the web app window.
  - Check that the reflow logic is functioning as expected.
- Use Browser Debugger
  - Utilize the browser debugger to test layout and reflow.
  - Verify that elements adjust properly as the window size changes.
- Set Specific Screen Size for Testing
  - Adjust your display settings to test at a screen size of 320 CSS pixels by 256 CSS pixels.
  - Ensure the following settings:
    - Set DPI to 100%.
    - Adjust the resolution to 1280 by 1024.
    - Set text scaling to 100%.
    - Ensure browser tech scaling is at default.
    - Set the browser zoom to 400%.
- Test with assistive technologies
  - Test on various devices and screen sizes to ensure that resize and reflow work correctly. Use both emulators and real devices to identify and address any issues.
  - Test with screen magnifiers to ensure appropriate scaling.
  - Test with screen readers to ensure compatibility. Verify that focus indicators, text insertion points, and selections are accessible.
  - Test keyboard navigation to ensure that all interactive elements can be accessed and navigated using a keyboard.
- Document Findings
  - Take note of any issues or discrepancies during testing.
  - Address any layout problems identified during the checks.

## User Testing

User testing for resize and reflow support is crucial to ensure that websites and applications are usable by everyone, including people with disabilities. This type of testing helps identify and address barriers that might prevent users who rely on assistive technologies, such as screen readers and screen magnifiers, from fully interacting with digital products. By involving people with disabilities in the testing process, developers can gain valuable insights into real-world challenges and ensure that the user experience is inclusive and accessible.
