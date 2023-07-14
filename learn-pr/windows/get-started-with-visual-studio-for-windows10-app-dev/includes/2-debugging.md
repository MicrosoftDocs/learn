## Debugging basics

It's difficult to write error-free code. Use Visual Studio to find the bugs in your project.

## Simple debugging

Add `print` statements to your project to see how your code is being executed. Code that isn't executing effectively can cause bugs. Use this method for simple debugging on smaller projects. This method *isn't* recommended for anything other than simple projects.

Add `print` statements to your Universal Windows Platform (UWP) project:

1. In the **Solution Explorer**, expand **MainPage.xaml** and select **MainPage.xaml.cs**.

    :::image type="content" source="../media/open-code.png" alt-text="Screenshot of the Visual Studio solution explorer. The MainPage.xaml.cs file is highlighted.":::

    The C# code here is associated with the window that displays in your app.

2. Scroll down in the **Editor Window** until you find the following code:

    ```csharp
    public MainPage()
    {
      this.InitializeComponent();
    }
    ```

    Change it to this code:

    ```csharp
    public MainPage()
    {
      this.InitializeComponent();
      Hello();
    }

    public void Hello()
    {
      System.Diagnostics.Debug.WriteLine("Hello!");
    }
    ```

    Your **Editor Window** should look like this:

    :::image type="content" source="../media/print-example.png" alt-text="Screenshot of the editor window in Visual Studio. Sample code from the previous WriteLine steps is shown.":::

3. Select the **Run** button or press the *F5* key to run your project.

    :::image type="content" source="../media/run-app.png" alt-text="Screenshot showing the Visual Studio menu bar. The run button, represented by a green triangle, is highlighted.":::

4. Minimize the app window and bring Visual Studio back into view. Select **Output** to view the *Hello!* message created by your app.

    :::image type="content" source="../media/view-output.png" alt-text="Screenshot showing the Visual Studio output window with the Hello! message shown.":::

    > [!NOTE]
    > You can also display debug text in *Windows Presentation Foundation (WPF)* and *Windows Forms* apps.

5. Select the **Stop** button to stop the app.

    :::image type="content" source="../media/stop-app.png" alt-text="Screenshot showing the Visual Studio menu bar. The stop button, represented by a red square, is highlighted.":::

## Better debugging

Use *breakpoints* to stop an app at specific points to find out what's going on with it. Let's see how this works.

1. Update your `Hello()` function to match this code:

    ```C#
    public void Hello()
    {
      int a = 1;
      int b = 2;
      int c = a + b;

      if (c == 4)
      {
          // Success
      }
      else
      {
          // Fail
      }
    }
    ```

    Your **Editor Window** should look like this:

    :::image type="content" source="../media/breakpoint-example.png" alt-text="Screenshot of the editor window in Visual Studio. Sample code from the above breakpoint steps is shown.":::

    **Explanation**: The app wants a value of `4` to execute the `Hello()` function. Unfortunately, in this case, `a + b` doesn't equal `c`. Let's examine the line performing this calculation using a breakpoint.

2. Select inside the gray margin next to the line containing the code `int c = a + b;`. A red dot displays. This dot is your breakpoint.

    :::image type="content" source="../media/add-breakpoint.png" alt-text="Screenshot of the Visual Studio editor window. A breakpoint (red circle) has been placed in the margin.":::

3. Select the **Run** button or press *F5* to start your app again.

    :::image type="content" source="../media/run-app.png" alt-text="Screenshot showing the Visual Studio menu bar. The run button, represented by a green triangle, is highlighted.":::

    The app stops running immediately. A small **yellow arrow** appears within the margin, next to the line containing the error. The highlighted line of code is what runs next.

    :::image type="content" source="../media/error-indication.png" alt-text="Screenshot of the Visual Studio editor window. A yellow arrow is displayed within the breakpoint in the margin.":::

    With your program paused, you can step through it line by line using the **Step into**, **Step over**, and **Step out** buttons on the toolbar.

    :::image type="content" source="../media/step-options.png" alt-text="Screenshot of the Visual Studio menu bar. The step into, step over, and step out options are highlighted.":::

4. Select **Step into** and watch the yellow arrow follow the flow of control.

    :::image type="content" source="../media/step-into.png" alt-text="Screenshot of the Visual Studio menu bar. The step into option is highlighted.":::

5. Hover over the variable `c`.

    :::image type="content" source="../media/using-breakpoints.png" alt-text="Screenshot of the Visual Studio editor window. A pop-up displays where the mouse was hovering. It indicates c has a value of three.":::

    A window appears to display the current value of the variable. As we know, it's 3, not the 4 our function expects.

6. Hover near the closing braces until a green arrow appears.

    :::image type="content" source="../media/run-execution.png" alt-text="Screenshot of the Visual Studio editor window. A green arrow is displayed where the mouse was hovering.":::

    This breakpoint allows the app to run until it reaches the containing line.

7. Select the **Stop** button to stop running your app.

    :::image type="content" source="../media/stop-app.png" alt-text="Screenshot showing the Visual Studio menu bar. The stop button, represented red square, is highlighted.":::

## The philosophy of debugging

A quick word on debugging. Knowing the tools you have at your disposal is half the battle. Understanding why something isn't working takes experience, patience, and luck. Use these tips to debug code:

- Understand that your code is doing exactly what you asked it to do. You just asked it to do the wrong thing.
- Explain your code, line by line, to a friend, or even to yourself. Saying things out loud can help.
- Break up your code into smaller and smaller sections—a form of refactoring—to confirm that each section is working.
- Sometimes it helps to take a break and clear your mind.
