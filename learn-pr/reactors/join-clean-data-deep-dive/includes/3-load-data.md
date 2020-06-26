By the end of this unit, you should be comfortable loading data from files into pandas DataFrames and troubleshooting any difficulties that might arise.

Because pandas DataFrames are two-dimensional data structures, they're similar to flat-file formats such as comma-separated value (CSV) files. CSV files are the most common import and export format for spreadsheets and databases. 

Adding to this ease of translation from CSV files to DataFrames, pandas provides a convenient function to load the contents of CSV files into DataFrames. This function is more convenient than the native Python [CSV library](https://docs.python.org/3.6/library/csv.html?azure-portal=true). Let's get comfortable with [pandas.read_csv](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html?azure-portal=true), because we'll be using it often.

After we've talked up the convenience of pd.read_csv, it might seem strange that we immediately encounter an error. The clue as to what went wrong is in the last line of the error message:

`UnicodeDecodeError: 'utf-8' codec can't decode byte 0xf1 in position 2: invalid continuation byte`

The data in the CSV file uses a character that the default Unicode Standard ([UTF-8](https://en.wikipedia.org/wiki/UTF-8?azure-portal=true)) codec reading this file doesn't understand. Remember, this is real-world data, and the real world is a messy place.

It's time to use the pd.read_csv documentation to look for ideas on what to try next.

### Try it yourself

Use Visual Studio Code IntelliSense for information on how to use pd.read_csv.

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Refer to the discussion at the start of this section if you forgot the syntax.
  
  ```python
  df = pd.read_csv?
  ```

  This output should appear (note that this is a shortened version):

  ```Output
  Signature:
  pd.read_csv(
      filepath_or_buffer: Union[str, pathlib.Path, IO[~AnyStr]],
      sep=',',
      delimiter=None,
      header='infer',
      ...
  )
  Docstring:
  Read a comma-separated values (csv) file into DataFrame.
  
  Also supports optionally iterating or breaking of the file into chunks.
  
  Additional help can be found in the online docs for `IO Tools `_.
  
  Parameters
  
  ...
  
  Returns
  -------
  DataFrame or TextParser
      A comma-separated values (csv) file is returned as two-dimensional
      data structure with labeled axes.
  
  See Also
  --------
  to_csv : Write DataFrame to a comma-separated values (csv) file.
  read_csv : Read a comma-separated values (csv) file into DataFrame.
  read_fwf : Read a table of fixed-width formatted lines into DataFrame.
  
  Examples
  --------
  >>> pd.read_csv('data.csv')  # doctest: +SKIP
  File:      c:\users\sarah\appdata\local\programs\python\python38-32\lib\site-packages\pandas\io\parsers.py
  Type:      function
  ```

</details>

<br /><br />

***

There are quite a few parameters for this function. The intuitively named `encoding` parameter accepts `str` input from the list of Python [standard encodings](https://docs.python.org/3.6/library/codecs.html#standard-encodings?azure-portal=true). We'll go with `'latin1'` here.

> [!NOTE]
> Although data science practitioners develop a familiarity with encodings they've encountered, selecting the correct encoding can sometimes come down to trial and error. That's true even for professionals!

```python
df = pd.read_csv('Data/USDA-nndb.csv', encoding='latin1')
```

There was no error message this time, so `'latin1'` worked and we successfully read in the CSV file to the `df` DataFrame.

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> There's a saying that the difference between data science in academia and the real world is that academia likes to do complex analysis on clean datasets, whereas the real world often does simpler analysis on messier datasets. Troubleshooting difficulties - even ones encountered while merely loading your data - is a large part of successful data science.
