NumPy is one of the two most important libraries in Python for data science, along with pandas. NumPy is a crucial library for effectively loading, storing, and manipulating in-memory data in Python. All these tasks will be at the heart of what you do with data science in Python.

Datasets come from a huge range of sources and in a wide range of formats, including text documents, images, sound clips, numerical measurements, and nearly anything else. Despite this variety, the start of data science is to think of all data fundamentally as arrays of numbers.

For example, the words in documents can be represented as the numbers that encode letters in computers or even as the frequency of particular words in a collection of documents. Digital images can be thought of as two-dimensional arrays of numbers that represent pixel brightness or color. Sound files can be represented as one-dimensional arrays of frequency versus time. But no matter what form our data takes, in order to analyze it, our first step is to transform it into arrays of numbers, which is where NumPy comes in (and pandas, down the road).

NumPy is short for *Numerical Python*. It provides an efficient means of storing and operating on dense data buffers in Python. Array-oriented computing in Python goes back to 1995, with the Numeric library. Scientific programming in Python took off over the next 10 years, but the collections of libraries splintered. The NumPy project began in 2005 as a way to bring the Numeric and NumArray projects together around a single array-based framework.

Some examples in this section are drawn from the *Python Data Science Handbook* by Jake VanderPlas (content available [on GitHub](https://github.com/jakevdp/PythonDataScienceHandbook?azure-portal=true)) and *Python for Data Analysis* by Wes McKinney. Text from the *Python Data Science Handbook* is released under the [CC-BY-NC-ND license](https://creativecommons.org/licenses/by-nc-nd/3.0/us/legalcode?azure-portal=true). Code is released under the [MIT License](https://opensource.org/licenses/MIT?azure-portal=true).

Let's get started exploring NumPy!

To get started, you'll need to install matplotlib. You can find instructions in [Getting started with Python in VS Code](https://code.visualstudio.com/docs/python/python-tutorial#_install-and-use-packages?azure-portal=true).

Our first step will be to import NumPy by using `np` as an alias:

```python
import numpy as np
```

Get used to this convention. It's a common convention in Python. It's the way we'll use and refer to NumPy throughout the rest of this course.

## Learning objectives

In this module, you will:

- Import the NumPy library
- Learn how NumPy arrays differ from the other Python data structures
- Explore data with NumPy arrays
- Learn about NumPy universal functions and how (and why) to use them
- Learn how to aggregate data in NumPy
- Learn how to broadcast in NumPy
- Learn how to use Boolean masking in NumPy

## Prerequisites

- [Visual Studio Code environment set up to run Python and Jupyter Notebooks](../../python-data-science/1-introduction.yml)
- [Introduction to Python for data science](../../python-data-science/index.yml)

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]
