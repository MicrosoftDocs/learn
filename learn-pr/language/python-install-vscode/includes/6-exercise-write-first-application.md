With Python and Python tools installed, you can create your first Python application! In this exercise, you'll create an empty folder, open the folder in Visual Studio Code, and then create your first application.

## Step 1 - Start VS Code in a project folder

Many projects start with an empty folder, which is how you'll start yours.

1. In Visual Studio Code, open a new Terminal window by selecting **Terminal** > **New Terminal**.

1. Create an empty folder called "hello-world", navigate into it, and open VS Code (code) in that folder (.) by entering the following commands:

    ::: zone pivot="windows"

    1. Create a new folder called hello-world:

       ```bash
       md hello-world
       ```

    1. Navigate to the hello-world folder:

       ```bash
       cd hello-world
       ```

    1. Open Visual Studio Code in that folder:

       ```bash
       code .
       ```

    ::: zone-end

    ::: zone pivot="linux"

    1. Create a new folder called hello-world:

       ```bash
       mkdir hello-world
       ```

    1. Navigate to the hello-world folder:

       ```bash
       cd hello-world
       ```

    1. Open Visual Studio Code in that folder:

       ```bash
       code .
       ```

    ::: zone-end

    ::: zone pivot="macos"

    1. Create a new folder called hello-world:

       ```bash
       mkdir hello-world
       ```

    1. Navigate to the hello-world folder:

       ```bash
       cd hello-world
       ```

    1. Open Visual Studio Code in that folder:

       ```bash
       code .
       ```

    ::: zone-end

    > [!TIP]
    > Open the command prompt or terminal as administrator to run `code .`

    Alternatively, you can run VS Code through the operating system UI, then use File > Open Folder to open the project folder.

## Step 2 - Create a new Python file and add code

With Visual Studio Code open to your empty folder, you'll now create a Python file to display the message *Hello, World*.

1. In the **Explorer view**, HELLO_WORLD panel, hover over the title bar, and then select **New File**.

    :::image type="content" source="../media/visual-studio-code-new-file.png" alt-text="Screenshot of the Visual Studio Code Explorer window with New File highlighted.":::

1. Name the new file *hello.py* by entering it into the new textbox, and pressing <kbd>Enter</kbd>.

    :::image type="content" source="../media/visual-studio-code-name-file.png" alt-text="Screenshot of Explorer window with hello.py entered for new file.":::

   By using the `.py` file extension, you tell VS Code to interpret this file as a Python program, so that it evaluates the contents with the Python extension.

1. Enter the following Python code in the editor panel. This command uses the `print` function to display the text *Hello, World!* when your application is run.

    ```python
    print('Hello, World!')
    ```

1. Save the file by selecting **File** and **Save** (or <kbd>**Ctrl**+**S**</kbd>).

    :::image type="content" source="../media/visual-studio-code-save-file.png" alt-text="Screenshot of file menu with Save highlighted.":::

## Step 3 - Run your application

Since it's a single line program, you can actually run your application from inside Visual Studio Code.

1. Open the built-in terminal in Visual Studio Code by selecting **View** and **Terminal**.

    :::image type="content" source="../media/visual-studio-code-open-terminal.png" alt-text="Screenshot of view menu with Terminal highlighted.":::

1. In the new terminal window, run the following command to run your Python code.

    ::: zone pivot="windows"

    ```bash
    python hello.py
    ```

    ::: zone-end

    ::: zone pivot="linux"

    ```bash
    python3 hello.py
    ```

    ::: zone-end

    ::: zone pivot="macos"

    ```bash
    python3 hello.py
    ```

    ::: zone-end
    
    :::image type="content" source="../media/visual-studio-code-run-code.png" alt-text="Screenshot of running the Python code.":::

    *Hello, World!* appears in the terminal window. Congratulations! You've created a Python application!
