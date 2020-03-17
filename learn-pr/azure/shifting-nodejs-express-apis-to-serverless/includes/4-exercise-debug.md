When I want to become familiar with an app, I find it helpful to run and step through an app with the debugger. Let's do this together.

Let's start by opening the app in Visual Studio Code.

1. Open _proxy.conf.json_ and change the port to **7070** (our Express app)
1. Open the VS Code Command Palette **F1**
1. Type **View: Show Debug** and press **ENTER**
1. Select **Debug Express and Angular**
1. Press **F5**
1. Notice the browser opens to <http://localhost:7070>

You may now set breakpoints in the Express and Angular code.

Here the debugger is stopped on a breakpoint in the Angular app.

![Debugging Angular](https://thepracticaldev.s3.amazonaws.com/i/ak08usxnehfpgfj8vg9a.jpg)

Here the debugger is stopped on a breakpoint in the Express app.

![Debugging Express](https://thepracticaldev.s3.amazonaws.com/i/z328yfch0tflkw46wk88.jpg)

> The files _.vscode/launch.json_ and _.vscode/tasks.json_ are integral to the debugging experience for this project. I encourage you to explore those files and copy/refactor their contents for your own purposes.
