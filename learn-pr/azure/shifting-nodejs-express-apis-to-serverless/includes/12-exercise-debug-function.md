Now it's time to run the app and see if it all works! We'll do this through the VS Code debugger.

> Just to keep things separate, we'll make sure the Express app uses port **7070** and the Azure Functions app uses port **7071**. If we were truly removing the Express app (which we could absolutely do at this point) we could keep the same port. But for educational purposes, let's keep them both around

1. Open _proxy.conf.json_ and change the port to **7071** (our function app)
1. Open the VS Code Command Palette **F1**
1. Type **View: Show Debug** and press **ENTER**
1. Select **Debug Functions and Angular**
1. Press **F5**
1. Open the browser to <http://localhost:7071>

You may now set breakpoints in the Functions and Angular code.

![Debugging Azure Functions](https://thepracticaldev.s3.amazonaws.com/i/2l27psjcsqyh8f2u32ls.jpg)

> In case you missed it - the files _.vscode/launch.json_ and _.vscode/tasks.json_ are integral to the debugging experience for this project. I encourage you to explore those files and copy/refactor their contents for your own purposes.
