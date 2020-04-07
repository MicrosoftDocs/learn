Python libraries such as [NumPy](https://www.numpy.org/) and [Pandas](https://pandas.pydata.org/) make data handling easier and allow you to manipulate, clean, and analyze data with a minimum of code. [Matplotlib](https://matplotlib.org/) adds spice to mix by letting you produce rich charts and graphs, and it provides the foundation for Pandas' own plotting capabilities. But don't sell Python itself short. Features such as slicing, comprehensions, and lambda functions make Python a first-class language for working with data. It's no coincidence that data scientists use Python more than any other language, and that some of the best libraries available for manipulating data and building machine-learning models are Python libraries.

## Check your knowledge

1. What is the primary difference between lists and tuples in Python?
	- Tuples are mutable, while lists are not
	- Lists are mutable, while tuples are not
	- Lists support insertion and deletion, while tuples support only deletion
	- Lists can be enumerated, but tuples can not

1. Which of the following statements produces a count of the duplicate rows in a Pandas DataFrame?
	- `len(df.duplicated())`
	- `len(df[df.duplicated()])`
	- `df.duplicated().count()`
	- `df.duplicated.count()`
 
1. Which of the following statements accurately describes lambda functions?
	- Small, one-line functions that have no names
	- Small, one-line functions that are called with the `->` operator
	- Small, one-line functions that are called with the `=>` operator
	- Small, one-line functions that accept no arguments

1. Which of the following statements regarding `%matplotlib inline` is true?
	- It imports Matplotlib
	- It imports *just* the part of Matplotlib that you use
	- It only works outside of Jupyter notebooks
	- It prevents you from having to call `plt.show()`

1. Which of the following statements regarding NumPy is false?
	- NumPy arrays require less memory than Python lists
	- Operations on NumPy arrays are faster than operations on Python lists
	- It includes support for loading data from CSV and TSV files
	- It's not free, but developer licenses are available for just $15 per year

1. Which of the following statements lists all the columns in a Pandas DataFrame and the number of missing values in each?
	- `df.list_missing_values()`
	- `df.list_missing_values().columns.all()`
	- `df.isnull().sum()`
	- `df.columns[==NaN].all()`
