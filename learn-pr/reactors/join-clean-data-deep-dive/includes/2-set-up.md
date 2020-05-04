
## Reminders about importing, built-in Help, and documentation

The standard convention in Python-centric data science is to import pandas under the alias `pd`, which is what we will use here:

```python
import pandas as pd
```

Because this is such a common convention, it is the way we will use and refer to pandas throughout the rest of this section and this course. You should also adopt this usage in your own code to make it easily readable for other data scientists.

Pandas is a big package and there can be a lot to keep track of. Fortunately, IPython (the underlying program that powers this notebook and other like it) gives you the ability to quickly explore the contents of a package like pandas by using its tab-completion feature. If you want to see all of the functions available with pandas, type this:

```python
ipython
pd.<TAB>
```

> **SARAH TBD** - in VSCode, the completion feature doesn't require <TAB> and using <TAB> inserts an actual tab into the code.

When you do so, a drop-down menu will appear next to the `pd`.

### Try it yourself

Place your cursor after the period and press <TAB>:

```python
pd.compat?
```

The output is:

```Output
```

:::image type="content" source="../media/pd-compat-help-vscode-flyout.png" alt-text="Help flyout menu in Visual Studio Code UI when typing 'pd.'":::

Now select an item using tab-completion and then add a period and use tab-completion to explore *that*.

For example, you could try pressing <TAB> after `pd.DataFrame`.

```python
pd.DataFrame.
```

The output is:

```Output
```

:::image type="content" source="../media/pd-dataframe-help-vscode-flyout.png" alt-text="Help flyout menu in Visual Studio Code UI when typing 'pd.DataFrame.'":::

As we progress through Section 1.1, don't forget that IPython also provides a tab-completion feature and function documentation with the `?` (question mark) character. If you don't understand something about a function you see in this section, taking a moment to csonult the documentation can help a great deal. You will find this documentation to be a very valuable reference source for your own data science work, both now and in the future. As a reminder, use this code to display the built-in pandas documentation:

```python
ipython
pd
```

### Try it yourself

Run this code cell and review the documentation for the pandas DataFrame object. We are going to use it quite a bit.

```python
pd.
```

The output is:

```Output
```

:::image type="content" source="../media/pd-help-vscode-flyout-dataframe-selected.png" alt-text="Help flyout menu in Visual Studio Code UI when typing 'pd.' and hovering over 'DataFrame'":::

## A brief reminder about Jupyter notebooks

This course makes extensive use of Jupyter notebooks hosted on Microsoft Azure. Azure-hosted Jupyter notebooks provide an easy way for you to experiment with programming concepts in an interactive fashion that requires no installation of software by students on local computers.

Jupyter notebooks are divided into cells. Each cell either contains text written in the Markdown markup language or a space in which to write and execute computer code. Because all the code resides inside code cells, you can run each code cell inline rather than using a separate Python interactive window.

> [!NOTE]
> This notebook is designed to have you run code cells one by one, and several code cells contain deliberate errors for demonstration purposes. As a result, if you use the **Cell** > **Run All** command, some code cells past the error won't be run. To resume running the code in each case, use **Cell** > **Run All Below** from the cell after the error.
