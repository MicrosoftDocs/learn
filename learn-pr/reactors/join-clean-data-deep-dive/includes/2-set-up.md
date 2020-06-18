Here are some reminders about importing, built-in help, and documentation.

## Importing

The standard convention in Python-centric data science is to import pandas under the alias `pd`:

```python
import pandas as pd
```

Because this is such a common convention, it's the way we'll use and refer to pandas throughout the rest of this section and this course. You should also adopt this usage in your own code to make it easily readable for other data scientists.

## Built-in help

Pandas is a big package, and there can be a lot to keep track of. Fortunately, you can use intellisense in Visual Studio Code to quickly explore the contents of a package like pandas. If you want to see all of the functions available with pandas, enter this and leave your cursor after the `.`:

```python
ipython
pd.
```

> [!div class="alert is-tip"]

When you do so, a drop-down menu will appear next to `pd`.

### Try it yourself

Alternatively, if you have a function you know you want to use but don't know how, you can add a question mark `?` to the end of a function and run the cell to get the documentation for a particular function:

```python
pd.compat?
```

The flyout looks like:

:::image type="content" source="../media/pd-compat-help-vscode-flyout.png" alt-text="Help flyout menu in Visual Studio Code UI when typing 'pd.'":::

Now select an item by using intellisense, and then add a period and use intellisense to explore *that*.

For example, you can try selecting the Tab key after `pd.DataFrame`.

```python
pd.DataFrame.
```

You should see:

:::image type="content" source="../media/pd-dataframe-help-vscode-flyout.png" alt-text="Help flyout menu in Visual Studio Code UI when typing 'pd.DataFrame.'":::

## Documentation

As we progress through section 1.1, don't forget that IPython also provides a tab-completion feature and function documentation with the `?` (question mark) character. If you don't understand something about a function that you see in this section, taking a moment to consult the documentation can help. You'll find this documentation to be a valuable reference source for your own data science work, both now and in the future. 

As a reminder, use this code to display the built-in pandas documentation:

```python
ipython
pd
```

### Try it yourself

Run this code cell and review the documentation for the pandas DataFrame object. We're going to use it quite a bit.

```python
pd.
```

Here's the flyout:

:::image type="content" source="../media/pd-help-vscode-flyout-dataframe-selected.png" alt-text="Help flyout menu in Visual Studio Code UI when typing 'pd.' and hovering over 'DataFrame'":::

## A brief reminder about Jupyter notebooks

This course makes extensive use of Jupyter notebooks hosted on Microsoft Azure. Azure-hosted Jupyter notebooks are an easy way for you to experiment with programming concepts in an interactive way. Students don't need to install software on local computers.

Jupyter notebooks are divided into cells. Each cell contains either text written in the Markdown language or a space in which to write and run computer code. Because all the code resides inside code cells, you can run each code cell inline rather than using a separate Python interactive window.

> [!NOTE]
> This notebook is designed to have you run code cells one by one. Several code cells contain deliberate errors for demonstration purposes. If you use the **Cell** > **Run All** command, some code cells after an error won't be run. To resume running the code in each case, use **Cell** > **Run All Below** from the cell after the error.
