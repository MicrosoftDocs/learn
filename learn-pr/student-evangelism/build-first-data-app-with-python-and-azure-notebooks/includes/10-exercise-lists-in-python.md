Earlier, you modified your Azure notebook to read **airports.csv** and print it to the screen. Now let's modify that logic to store the lines read from the file in a list.

1. Switch back to your Azure Notebook window or tab.

1. Add the following Python code to the empty cell at the end of the notebook:

    ```python
    all_airports = []

    with open('airports.csv', 'r') as airport_file:
        airport_file.readline() # Skip header line
        for airport in airport_file:
            all_airports.append(airport)

    all_airports = all_airports[:len(all_airports) - 1]
    ```

    Rather than print lines to the screen, this code declares an empty list named `all_airports` and appends each line read from the file to the list. It also removes the final line from the list since that line is an outlier.

1. Run the cell and verify that it executes without error. Then add the following statements to the empty cell at the end of the notebook to print the contents of the list:

    ```python
    for airport in all_airports:
        print(airport, end='')
    ```

1. Run the cell and confirm that the output looks like this:

    ![Printing the contents of the data file](../media/print-airports-2.png)

    _Printing the contents of the data file_

1. Finish up by using the **File** -> **Save and Checkpoint** command to save the notebook.

The data file has been uploaded to Azure Notebooks and loaded into a list, but right now it's nothing more than a list of strings containing airport codes, locations, and names. The strings need to be parsed to extract information regarding individual airports. Parsing requires that you learn a little more about strings in Python.