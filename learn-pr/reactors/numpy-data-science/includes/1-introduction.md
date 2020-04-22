NumPy is one of the two most important libraries in Python for data science, along with Pandas. NumPy is a crucial library for effectively loading, storing, and manipulating in-memory data in Python, all of which will be at the heart of what you do with data science in Python.

Datasets come from a huge range of sources and in a wide range of formats, such as text documents, images, sound clips, numerical measurements, and nearly anything else. Despite this variety, however, the start of data science is to think of all data fundamentally as arrays of numbers.

For example, the words in documents can be represented as the numbers that encode letters in computers or even the frequency of particular words in a collection of documents. Digital images can be thought of as two-dimensional arrays of numbers representing pixel brightness or color. Sound files can be represented as one-dimensional arrays of frequency versus time. However, no matter what form our data takes, in order to analyze it, our first step will be to transform it into arrays of numbers - which is where NumPy comes in (and pandas down the road).

NumPy is short for *Numerical Python*, and it provides an efficient means of storing and operating on dense data buffers in Python. Array-oriented computing in Python goes back to 1995 with the Numeric library. Scientific programming in Python took off over the next 10 years, but the collections of libraries splintered. The NumPy project began in 2005 as a means of bringing the Numeric and NumArray projects together around a single array-based framework.

Some examples in this section are drawn from the *Python Data Science Handbook* by Jake VanderPlas (content available [on GitHub](https://github.com/jakevdp/PythonDataScienceHandbook?azure-portal=true)) and *Python for Data Analysis* by Wes McKinney. Text from the *Python Data Science Handbook* is released under the [CC-BY-NC-ND license](https://creativecommons.org/licenses/by-nc-nd/3.0/us/legalcode?azure-portal=true); code is released under the [MIT license](https://opensource.org/licenses/MIT?azure-portal=true).

Let's get started exploring NumPy!

To get started, you will need to install matplotlib. Instructions can be found on the [VSCode Python Tutorial on Installing and Using Packages.](https://code.visualstudio.com/docs/python/python-tutorial#_install-and-use-packages?azure-portal=true)

Our first step will be to import NumPy using `np` as an alias:

```Python
import numpy as np
```

Get used to this convention - it's a common convention in Python, and it's the way we will use and refer to NumPy throughout the rest of this course.

## Learning objectives

In this module, you will:

- Import the NumPy library
- Understand how NumPy arrays differ from the other Python data structures
- Explore data with NumPy arrays
- Understand NumPy universal functions and how (and why) to use them
- Know how to aggregate data in NumPy
- Be able to broadcast in NumPy
- Understand how to use Boolean masking in NumPy

## Prerequisites

- [Introduction to Python for data science](../../python-data-science/index.yml)
