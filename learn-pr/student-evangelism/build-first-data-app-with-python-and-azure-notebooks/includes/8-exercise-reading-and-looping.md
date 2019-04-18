The U.S. [Bureau of Transportation Statistics](https://www.transtats.bts.gov) (BTS) maintains a wealth of information regarding transportation in the United States and makes much of that data available to the public. One of the datasets you can download from the BTS Web site lists all the airports in the world and includes their three-letter airport codes, the cities they're located in, and their names.

In this exercise, you'll download that dataset in the form of a CSV file and load it into the notebook you created earlier.

## Download a CSV file containing airport data

The first step is to download the dataset and have a look at its content and structure. The dataset is a text file containing [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) (Comma-Separated Values) data. CSV is an extremely common data format — so common that there are Python libraries whose only purpose is to simplify reading and writing CSV files.

1. Return to the Azure notebook that you created in the previous unit.

    ![Jupyter notebook in Azure](../media/third-run.png)

    _Jupyter notebook in Azure_

1. Enter the following command into the next cell of the notebook:

    ```bash
    !curl https://www.transtats.bts.gov/Download_Lookup.asp?Lookup=L_AIRPORT -o airports.csv
     ```

    `curl` is a Bash command. You can execute Bash commands in a Jupyter notebook by prefixing them with an exclamation mark. This command downloads a CSV file from the Learn website saves it using the name **airports.csv**. Don't worry too much if this step doesn't make sense - it's not a core Python concept, just a way to get the data downloaded.

### Load the CSV file into your notebook

Now let's use what you learned about files and loops to open **airports.csv** and display its contents in your notebook.

1. Add the following Python statements to the empty cell at the end of the notebook:

    ```python
    with open('airports.csv', 'r') as airport_file:
        airport_file.readline() # Skip header line
        for airport in airport_file:
            print(airport)
    ```

    This code opens **airports.csv** for reading and reads it a line at a time, printing each line that it is read. This file is from the United States Bureau of Transportation Statistics and provides identification codes and names for all airports in the world.

1. Run the cell and confirm that the output looks like this:

    ![Printing the contents of the data file](../media/print-airports-1.png)

    _Printing the contents of the data file_

    Observe that the first line is a header containing column names. Each line thereafter contains information regarding a specific airport. Furthermore, each line begins with a quoted string containing an airport code (for example, "JFK" for John F. Kennedy airport in New York), and ends with another quoted string containing the airport's location and name, separated by a colon.
    
    > [!div class="alert is-success"]
    > **What about this?**
    >
    > How many airports are represented in the file? How would you determine how many of those airports are located in the U.S.? How easy would it be to determine how many airports are located in a specific state such as Tennessee (TN) or Virginia (VA)?

## Cleanup the output

Notice that the output has a blank line between every line. This is because each line that was read from the text file ends with a newline character, and `print` adds a newline of its own. In Python 3, there's an easy solution to this. 

1. Modify the `print` statement in the previous cell to pass a second parameter to the `print` function:

    ```python
    print(airport, end='')
    ```

    The second parameter tells `print` to end the line with an empty string rather than a newline character. It leverges the fact that in Python, you can use parameter names to specify parameter values in function calls without providing values for *all* parameters. `end` is an example of a *named parameter*, a subject that you will learn more about in a subsequent lesson.

1. Run the cell again. How does the output differ from before?

1. Scroll to the bottom of the output and confirm that the final line is formatted differently than all the others:

    ```csv
    "ZZZ","Unknown Point in Alaska"
    ```

The line doesn't look like `"<code>","<city name>:  <airport name>"`.

This difference isn't harmful, but later on, you'll want to ignore the line when parsing individual lines in the data file.