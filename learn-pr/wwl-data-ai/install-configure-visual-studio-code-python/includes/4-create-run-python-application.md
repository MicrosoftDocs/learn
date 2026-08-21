
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=08b246bb-6a0a-4f49-81cc-b7f9a89533fe]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Now that your environment is set up, it's time to create and run your first Python application inside VS Code.

## Create a Python file

1. In VS Code, open a folder for your project (**File > Open Folder**).
1. In the **Explorer** panel, click the **New File** icon and name it `app.py`. The `.py` extension tells VS Code this is a Python file.
1. Add some code:

```python
name = input("What is your name? ")
print(f"Hello, {name}! Welcome to VS Code.")
```

## Run your application

You have two ways to run a Python file in VS Code:

**Option 1 - Run button:** Click the **Run Python File** button (the play icon ▶) in the top-right corner of the editor. The output appears in the integrated terminal.

**Option 2 - Terminal:** With your virtual environment active, run:

```bash
python app.py
```

## Read error messages

When something goes wrong, Python prints an error message in the terminal. Don't ignore it—error messages tell you exactly what went wrong and on which line. For example:

```output
Traceback (most recent call last):
  File "app.py", line 2, in <module>
    print(mesage)
NameError: name 'mesage' is not defined
```

This message tells you there's a `NameError` on line 2—a typo in a variable name. Reading error messages carefully is one of the most important debugging skills you can develop.

::: zone-end
