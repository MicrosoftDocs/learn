By the end of this subsection, you should be comfortable loading data from files into panda `DataFrame`s and troubleshooting any difficulties that might arise.

Because pandas `DataFrame`s are two-dimensional data structures, they are inherently similar to flat-file formats such as comma-separated value (CSV) files, the most common import and export format for spreadsheets and databases. Adding to this ease of translation from CSV files to `DataFrame`s, pandas provides a convenient function to load the contents of CSV files into `DataFrame`s (more convenient, in fact, then the native Python [CSV library](https://docs.python.org/3.6/library/csv.html?azure-portal=true)). Let's get comfortable with [pandas.read_csv](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_csv.html?azure-portal=true) because we will be using often.

```python
df = pd.read_csv('Data/USDA-nndb.csv')
```

The output is:

```Output
TBD
```

After talking up the convenience of pd.read_csv, it might seem strange that we immediately encounter an error. The clue as to what went wrong is in the last line of the error message:

`UnicodeDecodeError: 'utf-8' codec can't decode byte 0xf1 in position 2: invalid continuation byte`

The data in the CSV file uses a character that the default Unicode Standard ([UTF-8](https://en.wikipedia.org/wiki/UTF-8?azure-portal=true)) codec reading this file doesn't understand. Remember, this is real-world data and the real world is a messy place.

It's time to use the pd.read_csv documentation to look for ideas on what to try next.

### Try it yourself

Use the built-in IPython documentation to on `pd.read_csv.`

<br />

<details>

  <summary>Hint <i>(expand to reveal)</i></summary>

  Refer to the discussion at the start of this section if you forgot the syntax.
  
  ```python
  pd.read_csv.
  ```

  The output is:

  ```Output
  ```
  
  ***Jak: Add screenshot***

</details>

<br /><br />

***

There are quite a few of parameters for this function. The intuitively named `encoding` parameter accepts `str` input from the list of Python [standard encodings](https://docs.python.org/3.6/library/codecs.html#standard-encodings?azure-portal=true). We will go with `'latin_1'` here.

> [!NOTE]
> Although data-science practitioners do develop a familiarity with different encodings they have encountered, selecting the correct encoding can sometimes come down to trial and error, even for professionals!

```python
df = pd.read_csv('Data/USDA-nndb.csv', encoding='latin_1')
```

The output is:

```Output
TBD
```

There was no error message this time, so `'latin_1'` did the trick and we successfully read in the CSV file to the `df` `DataFrame`.

> [!div class="alert is-tip"]
>
> ### Takeaway
>
> There is a saying that the difference between data science in academia and the real world is that academia likes to do complex analysis on clean datasets, whereas the real world often does simpler analysis on messier datasets. Troubleshooting difficulties - even ones encountered while merely loading your data - is a large part of successful data science.
