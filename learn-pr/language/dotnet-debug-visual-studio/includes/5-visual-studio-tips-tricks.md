## Debugging tips and tricks

Once you are comfortable debugging in Visual Studio, there are many different tips and tricks that can speed up your debugging workflows. Listed below are useful features and shortcuts to improve your productivity.

1. You can right-click in the breakpoint gutter area and to set advanced breakpoints more quickly.

:::image source="../media/visual-studio-advanced-breakpoint.png" alt-text="Screenshot of of inserting a Tracepoint.":::

2. Pin DataTips you are interested in by hovering over a variable and clicking the pin icon. This allows you to easily inspect your variables and still navigate to other code. Pinned DataTips persists across debugging sessions and restarting Visual Studio.

:::image source="../media/visual-studio-data-tips.png" alt-text="Screenshot of a DataTip.":::

3. You can label your breakpoints from the breakpoint window or by right clicking on them. This makes it easier to organize and export them to an XML file.

:::image source="../media/visual-studio-debugging-breakpoint-label.png" alt-text="Screenshot of breakpoint labels.":::

4. You can drag & drop or copy & paste code expressions from the Visual Studio Editor to the Watch Window to explore its values and properties. This also works with multiple watch windows.

5. You can drag and drop your breakpoints from one location to another to reuse the breakpoint. This feature also works with advanced breakpoint options.

6. Right click in the Call Stack window and select the **Show Parameter Values** option. Once selected, the parameter values will be displayed in the Call Stack window along with parameter names and types.

:::image source="../media/visual-studio-debugging-show-values.png" alt-text="Screenshot of Visual Studio debugging controls.":::

7. With the debugger paused on a line of code, use the mouse to grab the yellow arrow pointer on the left. You can then move the yellow arrow pointer to a different line of code to manually set the next statement for execution.

8. In the Autos, Watch, or Locals window, right-click a property and select **Break when value changes** in the context menu. This data breakpoint will break execution when the specific object's property changes.

:::image source="../media/visual-studio-debugging-break-change.png" alt-text="Screenshot of Visual Studio debugging controls.":::

9. To view return values for your functions, look at the functions that appear in the Autos window while you are stepping through your code.

10. You can use the Visualizer to display the contents of a variable or object in a way that is meaningful for the data type. Click the magnifying glass icon that appears next to a variable name in DataTips, a Watch window, or in the Autos, Locals, or Quick Watch window. 

:::image source="../media/visual-studio-debugging-magnify.png" alt-text="Screenshot of Visual Studio debugging controls.":::