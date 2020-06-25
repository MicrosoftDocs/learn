Now that you've explored NumPy, it's time to get to know the other workhorse of data science in Python: pandas. The pandas library in Python makes working with data, like importing, cleaning, and organizing it, easier. It's hard to imagine doing data science in Python without it.

But it was not always this way. Wes McKinney developed the library out of necessity in 2008, while at AQR Capital Management, in order to have a better tool for dealing with data analysis. The library has since taken off as an open-source software project that has become a mature and integral part of the data science ecosystem. (In fact, some examples in this module are drawn from McKinney's book, _[Python for Data Analysis](https://wesmckinney.com/pages/book.html?azure-portal=true)_.)

The name _pandas_ actually has nothing to do with Chinese bears, but rather comes from the term _panel data_. Panel data is a form of multidimensional data involving measurements over time, and it comes out of the econometrics and statistics community. Ironically, while panel data is a usable data structure in pandas, it's not generally used today and we won't examine it here. Instead, we'll focus on the two most widely used data structures in pandas: `Series` and `DataFrames`.

## Reminders about importing and documentation

Just as you imported NumPy with the alias `np`, you'll import pandas under the alias `pd`. Make sure you've installed pandas first (run `pip install pandas` in the following terminal).

```python
import pandas as pd
```

As with the NumPy convention, `pd` is an important and widely used convention in the data science world. We recommend that you use it in your own coding.

As you progress through this module, don't forget that IPython provides the tab-completion feature and function documentation with the `?` character. If you don't understand anything about a function you see in this module, take a moment and read the documentation. The docs can help a great deal. As a reminder, to display the built-in pandas documentation, use this code:

```python
ipython
pd?
```

Because it can be useful to learn about `Series` and `DataFrames` in pandas, which is an extension of `ndarrays` in NumPy, go ahead and also import NumPy. You will want it for some of the examples later on:

```python
import numpy as np
```

Here's the output:

```Output
Type:        module
String form: 
File:        /opt/anaconda3/lib/python3.7/site-packages/pandas/__init__.py
Docstring:  
pandas - a powerful data analysis and manipulation library for Python
=====================================================================

**pandas** is a Python package providing fast, flexible, and expressive data
structures designed to make working with "relational" or "labeled" data both
easy and intuitive. It aims to be the fundamental high-level building block for
doing practical, **real world** data analysis in Python. Additionally, it has
the broader goal of becoming **the most powerful and flexible open source data
analysis / manipulation tool available in any language**. It is already well on
its way toward this goal.

Main Features
-------------
Here are just a few of the things that pandas does well:

  - Easy handling of missing data in floating point as well as non-floating
    point data.
  - Size mutability: columns can be inserted and deleted from DataFrame and
    higher dimensional objects
  - Automatic and explicit data alignment: objects can be explicitly aligned
    to a set of labels, or the user can simply ignore the labels and let
    `Series`, `DataFrame`, etc. automatically align the data for you in
    computations.
  - Powerful, flexible group by functionality to perform split-apply-combine
    operations on data sets, for both aggregating and transforming data.
```

## Learning objectives

In this module, you will:

- Import the pandas library into Jupyter Notebooks in Visual Studio Code
- Understand how to use `Series` and `DataFrames` to store remote data
- Learn how to clean and manipulate large, remote datasets
- Apply operations to `Series` and `DataFrames` for data science analysis

## Prerequisites

- [Visual Studio Code environment set up to run Python and Jupyter notebooks](../../python-data-science/1-introduction.yml)
- [Introduction to Python for data science](../../python-data-science/index.yml)
- [Introduction to NumPy for data science](../../numpy-data-science/index.yml)

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]
