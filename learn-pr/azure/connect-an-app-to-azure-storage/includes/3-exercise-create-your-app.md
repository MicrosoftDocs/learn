Recall that we're working on a photo-sharing application that uses Azure Storage to manage pictures and other bits of data we store on behalf of our users.

::: zone pivot="csharp"

To simplify our scenario so that we can focus on the Storage APIs, we'll create a new .NET Core Console application. We'll also assume it always has network connectivity. However, you should always harden your app to ensure network failures won't affect the user experience or result in a failure of the application itself.

## Create a .NET Core application

.NET Core is a cross-platform version of .NET that runs on macOS, Windows, and Linux. You can install the tools locally or use Cloud Shell on the right side of the window to execute the following steps.

1. Create a new .NET Core Console application with the name "PhotoSharingApp". Add the `-o` or `--output` flag to create the app in a specific folder.

    ```dotnetcli
    dotnet new console --name PhotoSharingApp
    ```

1. Change into the application directory.

    ```bash
    cd PhotoSharingApp
    ```

1. Run the app to make sure it builds and executes correctly.

    ```dotnetcli
    dotnet run
    ```

     The output "Hello World!" should display in the console.

::: zone-end

::: zone pivot="javascript"

To simplify our scenario so that we can focus on the Storage APIs, we'll create a new Node.js application that can run from the console. We'll also assume it always has network connectivity. However, you should always harden your app to ensure network failures won't affect the user experience, or result in a failure of the application itself.

## Create a Node.js application

Node.js is a popular framework for running JavaScript apps. It's most commonly used for web apps, but you can use it to run logic from the command line as well. If you have the tools installed locally, you can run the following steps from a command line. Alternatively, you can use Cloud Shell on the right side of the window to execute the following steps.

1. In the Cloud Shell on the right, create a new folder named "PhotoSharingApp".

    ```bash
    mkdir PhotoSharingApp
    ```

1. Change into the new folder, and use `npm` to initialize a new Node.js app. This will create a **package.json** file containing metadata that describes the app.

    ```bash
    cd PhotoSharingApp
    npm init -y
    ```

1. Create a new source file, **index.js**, which is where our code will go.

    ```bash
    touch index.js
    ```

1. Open the **index.js** file with an editor. If you're using Cloud Shell, enter `code .` to open an editor.

1. Paste the following program into the **index.js** file. Press <kbd>Ctrl+V</kbd> or right-click to paste.

    ```javascript
    #!/usr/bin/env node
    
    function main() {
        console.log('Hello, World!');
    }
    
    main();
    ```

1. Press <kbd>Ctrl+S</kbd> to save the file. Alternatively, in the Cloud Shell integrated editor title bar, select the ellipsis, and then select **Save** from the context menu.

1. Run the app to make sure it executes correctly.

    ```bash
    node index.js
    ```

     The output "Hello World!" should display in the console.

::: zone-end
