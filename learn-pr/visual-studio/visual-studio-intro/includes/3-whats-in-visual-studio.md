Visual Studio is best known for the rich experiences it provides developers in the editor and debugger as well as many other programming tools!

## Editor

The Visual Studio editor has excellent code completion, syntax highlighting, quick info hints, errors and warnings that come with codefix suggestions. That help you understand more about the code you are writing.

:::image type="content" source="../media/vs-intro-editor.png" alt-text="Screenshot of Visual Studio's code editor with callouts indicating the different colors in the UI, the lightbulbs that give suggestions in the margin, quick info boxes that appear when hovering, and the IntelliSense completion list.":::

IntelliSense is taken a step further with IntelliCode, the AI tool that is build into the editor. [IntelliCode](https://aka.ms/intellicode) is trained from open source code to bring common patterns and smart completion to your editor. It may appear as you type in the form of gray text suggetsions or it can make our intellisense completion list smarted by bubbling the most likely completions to the top of the list.

Built-in codefixes and refactorings appear as lightbulbs or screwdrivers in the margin of the editor. These helpful menus can suggest common actions, code fixes for errors or warnings in your files, and even make suggestions to improve your code style.

:::image type="content" source="../media/vs-intro-lightbulb.png" alt-text="Screenshot of Visual Studio's code editor selecting Generate constructor from the light bulb menu. A second screenshot shows the generated constructor in the code editor.":::

There are many navigation commands that can help you move around your code and files such as Go To Definition, Peek Definition, and Go To Base. Icons in the margin can also help you navigate your inheritance chain. You can even navigate backward to a previos location your cursor was at where you made changes with a button or by using a keyboard shortcut (Ctrl+-).

:::image type="content" source="../media/vs-intro-navigation.png" alt-text="Multiple screenshots of Visual Studio. First is the right-click menu showing navigation commands including go to definition and peek definition. The second shows an icon in the margin showing the base type of a class. The last shpws the navigation buttons at the top left corner of Visual Studio that have arrows pointing forwards and backwards to help navigate the cursor to different edit points.":::

Visual Studio even comes pre-loaded with templates and snippets to help you scaffold the right projects and code. For example, simply typing "prop" in the editor and typing `tab tab` will insert a Property.

:::image type="content" source="../media/vs-intro-snippet.png" alt-text="Two screenshots of Visual Studio with the first picture triggering snippet completion by typing prop in the editor and prompting the user to type tab tab to accept the snippet. The second screenshot shows the full property declaration inserted in the editor now saying public int MyProperty { get; set; }":::

## Debugger

After you've written some code you want to see it running in your app or webste! The green play button at the top of Visual Studio can help you do that. This launches the debugger.

:::image type="content" source="../media/vs-intro-debug-button.png" alt-text="Screenshot of Visual Studio's big green play button that launches the debugger.":::

If your app is a website it will start up a browser in your local host.

:::image type="content" source="../media/vs-intro-web-app.png" alt-text="Screenshot of Visual Studio debugging a website with a browser window open to localhost to a website called My First Website.":::

If it's a console app a console will pop up to run your app.

:::image type="content" source="../media/vs-intro-console-app.ong" alt-text="Screenshot of Visual Studio with a debug console window in front of it showing the text Hello World.":::

You can click in the margin to set a break point. This pauses the debugger at that line of execution.

:::image type="content" source="../media/vs-intro-breakpoint.png" alt-text="Screenshot of Visual Studio in an active debug session. A red circle in the margin shows where the break point is in the code and a yellow arrow indicates where execution is currently at. The yellow arrow is overlaying the breakpoint.":::

Arrow buttons in the top of Visual Studio toolbar allow you to step into and around different lines of code. Note how the arrow is now one line past the breakpoint after selecting Step Into.

:::image type="content" source="../media/vs-intro-breakpoint-step.png" alt-text="Screenshot of Visual Studio debugging. The yellow arrow is now one line past the breakpoint. A red box calls out the Step Into button in the top visual Studio toolbar.":::

While debugging you can hover to view variables values at this point in execution. You can also pin these to your editor window so you can keep an eye on the values without needing to hover or you can search the autos, local, and watch windows for variable values as well.

:::image type="content" source="../media/vs-intro-debug-inspect.png" alt-text="Screenshot of Visual Studio debugging an object of type hobby. The cursor is hovering over the name property. The debugger shows the value in a window layered over it. At this point in execution the hobby name is "programming":::

The debugger can also break when an exception is thrown in your program. This can be really helpful to determine what is going wrong if you app doesn't seem to be running correctly and you need more information. For example, in this case, we can't call Length on a null string so the debugger is throwing a Null Reference Exception. This shows when and where a null reference is being used which could break the running program.

:::image type="content" source="../media/vs-intro-break-exception.png" alt-text="Screenshot of Visual Studio debugging with the yellow execution cursor paused on a Length call on a null string. An exception window appears over and highlights the line where the exception is occuring and calls out the string that is null.:::

## Customization (Check what top changes are in telemetry)

Visual Studio is highly customizable allowing different themes, fonts, colors, window layouts, and icons to be used! You can set these preferences in **Tools > Options**.

:::image type="content" source="../media/vs-intro-theme.png" alt-text="Screenshot of Visual Studio .:::

There are a ton of different themes created [by the community](https://devblogs.microsoft.com/visualstudio/custom-themes/) as well that might mimic some of your favortie color pallettes.

:::image type="content" source="../media/vs-intro-community-themes.png" alt-text="Screenshot of Visual Studio .:::

Customize the colors of different text display items and fonts in **Tools > Options > Environment > Fonts and Colors**

:::image type="content" source="../media/vs-intro-colors.png" alt-text="Screenshot of Visual Studio .:::

All the windows in Visual Studio can be dragged and dropped to different sections around the editor. You can even drag windows outside the editor entirely for use on a different desktop. You can also save and reset your window layout for different tasks.

- Window layouts
- Toolbar

## Extensions

- Popular extensions in marketplace (Editor guidelines, boost.test, xunit)
- Constantly expanding and evolving ecosystem (people have entire businesses of extending Visual Studio!)

## Live Share

- Benefits of pair programming and simplicity of tool
- Specifically good for students and teachers, but also used everyday by professional developers

## Publishing to the Cloud

- Publish to Azure so your website is live
- Connecting Azure account
- Other Git and pipeline tools
