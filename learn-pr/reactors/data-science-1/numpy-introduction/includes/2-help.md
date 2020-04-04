There's a lot to learn about NumPy, and it can be tough to remember it all the first time through. Don't worry! IPython --- the underlying program that enables notebooks like this one to interact with Python---has you covered.

First off, IPython gives you the ability to quickly explore the contents of a package like NumPy by using the tab-completion feature. So, if you want to see all of the functions available with NumPy, type this:

```python
ipython
np.<TAB>
```

When you do so, a drop-down menu will appear next to the `np.`

### Exercise

Start typing `np.` and see the list of available functions come up.

```python
np.
```

You should see:

```output
TBA
```

From the drop-down menu, you can select any function to run. Better still, you can select any function and view the built-in help documentation for it. For example, to view the documentation for the NumPy `add()` function, you can hover over a specific function, or click the information icon next to the drop down list on intellisense.

Try this with a few different functions. Remember, these functions are just like ones you wrote in the introduction to python module; the documentation will help explain what parameters you can (or should) provide the function, in addition to what output you can expect.

For more detailed documentation (along with additional tutorials and other resources), visit [www.numpy.org](http://www.numpy.org/).

Now that you know how to quickly get help while you are working on your own, let's return to storing data in arrays.
