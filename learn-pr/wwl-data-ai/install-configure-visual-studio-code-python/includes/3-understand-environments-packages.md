
::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=65eb4cf1-a211-44c5-b771-2fd251b15859]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Python has a huge ecosystem of third-party **packages**—reusable code libraries that extend what Python can do. Before installing packages, it's good practice to set up a **virtual environment** so that your project's dependencies stay organized and don't interfere with other projects.

## What is a virtual environment?

A virtual environment is an isolated folder that contains its own copy of Python and any packages you install. Think of it as a clean workspace for each project—packages you install in one environment don't affect another.

## Create a virtual environment

In VS Code, open the integrated terminal (**Terminal > New Terminal**) and navigate to your project folder. Then run:

```bash
python -m venv .venv
```

This command creates a hidden folder called `.venv` containing the isolated environment. Activate it with:

| Platform | Command |
|---|---|
| Windows | `.venv\Scripts\activate` |
| macOS / Linux | `source .venv/bin/activate` |

When active, you see `(.venv)` appear at the start of your terminal prompt. You can also use the `Python: Select Interpreter` command in VS Code to create and activate a virtual environment.

## Install packages with pip

**pip** is Python's built-in package manager. Once your virtual environment is active, use it to install packages:

```bash
pip install requests
```

To see all installed packages in the current environment:

```bash
pip list
```

To save your project's dependencies, so others can recreate the environment:

```bash
pip freeze > requirements.txt
```

And to install from that file:

```bash
pip install -r requirements.txt
```

> [!TIP]
> VS Code detects your virtual environment automatically. When you open a Python file, look for the Python version in the bottom status bar—select it to choose your `.venv` environment if it isn't already selected.

::: zone-end
