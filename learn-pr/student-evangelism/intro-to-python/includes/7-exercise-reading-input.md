Now let's use what you learned about `print`, `input`, and string concatenation to display a personalized greeting using a Python script.

1. Start the online code editor by typing `code` at the terminal prompt.

1. Type or paste the following statements into the editor.

    ```python
    print('Welcome!')
    name = input('Enter your name: ')
    print('Hello, ' + name)
    ```

1. Save the file as  **hello.py**. You can click the ellipse "..." in the right corner of the cloud editor, or use the accelerator key (<kbd>Ctrl+S</kbd> on Windows and Linux, <kbd>Cmd+S</kbd> on macOS).

1. Close the editor through the "..." context menu.

1. You can verify the file is on disk using the `ls` command.

1. Execute the script using the Python interpreter.

    ```bash
    python hello.py
    ```

1. When prompted, type your name and press <kbd>Enter</kbd>.

1. Confirm that a personalized greeting appears in the output:

    ```output
    Welcome!
    Enter your name: Hannah
    Hello, Hannah
    ```

If you want to add an exclamation mark after the name so the greeting reads `"Hello, Hannah!"`, how would you do it?

> [!TIP]
> A single Python statement can use multiple `+` operators to concatenate several strings.

Modify the program to add an exclamation point to the end of the output and run the app to verify the results.