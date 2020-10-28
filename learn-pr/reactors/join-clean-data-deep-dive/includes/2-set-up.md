Here are some reminders about importing, built-in help, and documentation.

## Importing

The standard convention in Python-centric data science is to import pandas under the alias `pd`:

```python
import pandas as pd
```

Because this is such a common convention, it's the way we'll use and refer to pandas throughout the rest of this section and this course. You should also adopt this usage in your own code to make it easily readable for other data scientists.

## Built-in help

Pandas is a big package, and there can be a lot to keep track of. Fortunately, you can use IntelliSense in Visual Studio Code to quickly explore the contents of a package like pandas. If you want to see all of the functions available with pandas, enter this and leave your cursor after the `.`:

```python
pd.
```

When you do so, a drop-down menu will appear next to `pd`.

### Try it yourself

Alternatively, if you have a function you know you want to use but don't know how, you can add a question mark `?` to the end of a function and run the cell to get the documentation for a particular function:

```python
pd.compat?
```

The output looks like:

```Output
Type:        module
String form: 
File:        c:\users\sarah\appdata\local\programs\python\python38-32\lib\site-packages\pandas\compat\__init__.py
 Docstring:  
compat
======

Cross-compatible functions for different versions of Python.

Other items:
* platform checker
```

Now select an item by using IntelliSense, and then add a period and use IntelliSense to explore *that*.

For example, you can try adding a period after `pd.DataFrame` and waiting for Visual Studio IntelliSense.

```python
pd.DataFrame.
```

You should see:

:::image type="content" source="../media/pd-dataframe-help-vscode-flyout.png" alt-text="Help flyout menu in Visual Studio Code UI when typing 'pd.DataFrame.'":::

## A brief reminder about Jupyter notebooks

This course makes extensive use of Jupyter notebooks hosted running within Visual Studio Code. Visual Studio Code embedded Jupyter notebooks are an easy way for you to experiment with programming concepts in an interactive way. Visual Studio Code can be installed on most operating systems.

Jupyter notebooks are divided into cells. Each cell contains either text written in the Markdown language or a space in which to write and run computer code. Because all the code resides inside code cells, you can run each code cell inline rather than using a separate Python interactive window.

> [!NOTE]
> This notebook is designed to have you run code cells one by one. Several code cells contain deliberate errors for demonstration purposes. If you use the **Cell** > **Run All** command, some code cells after an error won't be run. To resume running the code in each case, use **Cell** > **Run All Below** from the cell after the error.
