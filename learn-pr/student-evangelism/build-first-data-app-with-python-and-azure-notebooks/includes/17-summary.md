## Show your Pythonic mettle

You have come a long way in a few short lessons. But there is still more that you can do if you would like. Here are a few suggestions:

- Define a function named `print_airport` that replaces the following line in the previous code sample and gives the output nicer formatting. See this helpful site for ideas of how to do string formatting: <https://pyformat.info/>

    ```python
    print(airport)
    ```

    Then replace that statement with calls to `print_airport` like this:

    ```python
    for airport in state_airports:
        print_airport(airport)
    ```

    What advantages are there to creating your own function to replace the default? Is it possible to define the function in such a way that it accepts parameters specifying the widths of the columns? Would default parameters be useful in this regard so callers could opt to use default column widths without specifying those widths in each call?

- Write a function that determines which U.S. state has the most airports
- Write a function that determines which U.S. city has the most airports

There are some great Python tutorials online, including [this one](https://docs.python.org/3/tutorial/) from the Python Software Foundation. Python is a simple language, and yet a powerful one. Learning it opens the door to a whole new world of data exploration, discovery, and even visualization. Now that you've learned the basics, use them as building blocks for Python applications of your own.


For a complete list of string functions, see <https://www.w3schools.com/python/python_ref_string.asp>.
A complete list of built-in functions can be found [here](https://docs.python.org/3/library/functions.html).