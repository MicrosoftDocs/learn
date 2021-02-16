Recall that we're working on a photo-sharing application that will use Azure Storage to manage pictures and other bits of data we store on behalf of our users.

::: zone pivot="csharp"

To simplify our scenario so that we can focus on the Storage APIs, we'll create a new .NET Core Console application. We'll also assume it always has network connectivity. However, you should always harden your app to ensure network failures will not impact the user experience or result in a failure of the application itself.

## Create a .NET Core application

.NET Core is a cross-platform version of .NET that runs on macOS, Windows, and Linux. You can install the tools locally or use the Cloud Shell on the right side of the window to execute the following steps.

1. Sign in to the Cloud Shell or open a command-line session, and create a new .NET Core Console application with the name "PhotoSharingApp". You can add the `-o` or `--output` flag to create the app in a specific folder.

    ```dotnetcli
    dotnet new console --name PhotoSharingApp
    ```

1. Change into the application directory.

    ```bash
    cd PhotoSharingApp
    ```

1. Run the app to make sure it builds and executes correctly. It should display "Hello World!" to the console.

    ```dotnetcli
    dotnet run
    ```

::: zone-end

::: zone pivot="javascript"

To simplify our scenario so that we can focus on the Storage APIs, we'll create a new Node.js application that can run from the console. We'll also assume it always has network connectivity. However, you should always harden your app to ensure network failures will not impact the user experience, or result in a failure of the application itself.

## Create a Node.js application

Node.js is a popular framework for running JavaScript apps. It is most commonly used for web apps, but you can use it to run logic from the command line as well. If you have the tools installed locally, you can run the following steps from a command line. Alternatively, you can use the Cloud Shell on the right side of the window to execute the following steps.

1. Sign in to the Cloud Shell or open a command-line session, and create a new folder named "PhotoSharingApp".

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

1. Open the **index.js** file with an editor. If you are using the Cloud Shell, you can enter `code .` to open an editor.

1. Paste the following program into the **index.js** file. You can press <kbd>Ctrl+V</kbd> or right-click to paste.

    ```javascript
    #!/usr/bin/env node
    
    function main() {
        console.log('Hello, World!');
    }
    
    main();
    ```

1. Save the file. Select the "..." menu on the top-right corner of the Cloud Shell editor, and select **Save**.

1. Run the app to make sure it executes correctly. It should display "Hello, World!" in the console.

    ```bash
    node index.js
    ```

::: zone-end
