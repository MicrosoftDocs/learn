Now that we've explored NumPy, it's time to get to know the other workhorse of data science in Python: pandas. The pandas library in Python really does a lot to make working with data, like importing, cleaning, and organizing it, so much easier, that it's hard to imagine doing data science in Python without it.

But it was not always this way. Wes McKinney developed the library out of necessity in 2008 while at AQR Capital Management in order to have a better tool for dealing with data analysis. The library has since taken off as an open-source software project that has become a mature and integral part of the data science ecosystem. (In fact, some examples in this module will be drawn from McKinney's book, _[Python for Data Analysis](https://wesmckinney.com/pages/book.html)_.)

The name _pandas_ actually has nothing to do with Chinese bears, but rather comes from the term _panel data_, a form of multi-dimensional data involving measurements over time that comes out the econometrics and statistics community. Ironically, while panel data is a usable data structure in pandas, it's not generally used today and we won't examine it in this course. Instead, we'll focus on the two most widely used data structures in pandas: `Series` and `DataFrames`.

> [!Note]
> **Sarah: Conversion feedback**
> 
> The environment set up content is the first module in this learning path and it's extremely short--one unit topic.
> Suggest moving the setup content into this unit topic, and duplicate the set up content in all modules (as needed) in the learning path.
>
> **Sarah: Action items**
>
> - Add list of learning objectives.
> - Add list of prerequisites, or "None."
> - Lead sentence mentions NumPy module in the LP, which isn't standard for Learn content.

## Tips: Import data and access the docs

Just as you imported NumPy with the alias `np`, we will import pandas under the alias `pd`. Make sure you've installed Pandas first (run `pip install pandas` in the terminal below).

```Python
import pandas as pd
```

As with the NumPy convention, `pd` is an important and widely used convention in the data science world. We will use it here and we advise you to use it in your own coding.

As we progress through this module, don't forget that IPython provides the tab-completion feature and function documentation with the `?` character. If you don't understand anything about a function you see in this module, take a moment and read the documentation. The docs can help a great deal. As a reminder, to display the built-in pandas documentation, use this code:

```Python
ipython
pd?
```

Because it can be useful to lean about `Series` and `DataFrames` in pandas a extension of `ndarrays` in NumPy, go ahead also import NumPy. You will want it for some of the examples later on:

```
import numpy as np
```

## Learning objectives
In this module, you will:

- Explore Pandas
- TBD
- TBD

## Prerequisites

None.

Now, on to pandas!
