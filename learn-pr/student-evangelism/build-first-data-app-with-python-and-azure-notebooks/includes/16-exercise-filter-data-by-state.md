Now let's enhance your notebook to allow users to interactively query for airports in a specified state. You will use a custom function to make the code compact and tidy, and Python's `input` function to solicit user input.

1. Return to the Azure notebook in which you generated a list of U.S. airports. 

1. In the empty cell at the end of the notebook, add the following function definition:

    ```python
    def get_airports_by_state(airports, state):
        result = []
        for airport in airports:
            if airport[1].endswith(state):
                result.append(airport)
        return result
    ```

1. Run the cell to make sure there are no syntax errors. Then add the following code to the empty cell at the end of the notebook:

    ```python
    state = input('Enter a state abbreviation: ')
    state_airports = get_airports_by_state(us_airports, state)

    for airport in state_airports:
        print(airport)
    ```

1. Run the cell and enter a state abbreviation such as WY or VA. Then press **Enter**. Confirm that the result is a list of airports in that state:

    ![Airports in the state of Wyoming](../media/print-wy-airports.png)

    _Airports in the state of Wyoming_

1. On your own, modify the code in the previous cell to show the **number** of airports in the specified state:

    > [!TIP]
    > You can use the `len` function to count the number of items in a list. And you can use Python's built-in `str` function to convert the number returned by `len` into a string.

    ![Modified output](../media/modified-output.png)

    _Modified output_

Finish up by using the **File** > **Save and Checkpoint** command to save the notebook.