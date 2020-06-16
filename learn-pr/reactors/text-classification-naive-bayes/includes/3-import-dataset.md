In this section, we'll use the [SMS Spam Collection dataset](https://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection?azure-portal=true). The dataset contains 5,574 messages collected for SMS spam research and tagged as either _spam_ or _ham_. The dataset files contain one message per line. Each line is composed of the tag and the raw text of the SMS message. For example:

| Class	| Message | 
| :----- | :--------- |
| ham |	What you doing?how are you? |
| ham |	Ok lar... Joking wif u oni... |

Let’s import pandas and load the dataset. The path name in the following code is case-sensitive.

> **Sarah** TBD. It occurred to me to add a tip that links to the environment setup instructions. What do you think?

> [!TIP]
> Review steps to set up the learning environment, TBD--add link.
>

```python
import pandas as pd 
df = pd.read_csv('Data/SMSSpamCollection', sep='\t', names=['Class', 'Message'])
```

### Try it yourself

> **Sarah** TBD. Pease review the solution/answer I wrote for the following exercise. Thanks.

What do the `sep` and `names` parameters do in the preceding code?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>
  
  If you are unsure, you can refer to the built-in Help documentation by using <code>pd.read_csv?</code> in a new code cell.

  *Answer*:

  In the preceding code, `sep='\t'` displays the output elements separated by a tab character and `names` creates column names in the output.

</details>

<br /><br />

***

Let's take an initial look at what's in the dataset. 

Run:

```python
df.head()
```

Here's the output:

```Output
---------------------------------------------------------------------------------------------------------------------------------------
|   | Class  | Message                                                                                                                |
---------------------------------------------------------------------------------------------------------------------------------------
| 0 | ham    | Go until jurong point, crazy.. Available only ...                                                                      |
---------------------------------------------------------------------------------------------------------------------------------------
| 1 | ham    | Ok lar... Joking wif u oni...                                                                                          |
---------------------------------------------------------------------------------------------------------------------------------------
| 2 | spam   | Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry question(std txt |
|   |        | rate)T&C's apply 08452810075over18's                                                                                   |
---------------------------------------------------------------------------------------------------------------------------------------
| 3 | ham    |   U dun say so early hor... U c already then say...                                                                    |
---------------------------------------------------------------------------------------------------------------------------------------
| 4 | ham    |   Nah I don't think he goes to usf, he lives aro...                                                                    |
---------------------------------------------------------------------------------------------------------------------------------------
```

Note that several entries in the `Message` column are truncated. We can use the `set_option()` function to set pandas to display the maximum width of each entry.

```python
pd.set_option('display.max_colwidth', -1)
df.head()
```

```Output
---------------------------------------------------------------------------------------------------------------------------------------
|   | Class  | Message                                                                                                                |
---------------------------------------------------------------------------------------------------------------------------------------
| 0 | ham    | Go until jurong point, crazy.. Available only ...                                                                      |
---------------------------------------------------------------------------------------------------------------------------------------
| 1 | ham    | Ok lar... Joking wif u oni...                                                                                          |
---------------------------------------------------------------------------------------------------------------------------------------
| 2 | spam   | Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry question(std txt |
|   |        | rate)T&C's apply 08452810075over18's                                                                                   |
---------------------------------------------------------------------------------------------------------------------------------------
| 3 | ham    | U dun say so early hor... U c already then say...                                                                      |
---------------------------------------------------------------------------------------------------------------------------------------
| 4 | ham    | Nah I don't think he goes to usf, he lives aro....                                                                     |
---------------------------------------------------------------------------------------------------------------------------------------
```

### Try it yourself

> **Sarah** TBD, provide possible solution and output.

What do you think the purpose of the `-1` parameter passed to `pd.set_option()` is in the code cell above?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>
  
  TBD, provide a possible solution and output

</details>

<br /><br />

***

Alternatively, we can dig into individual messages.

```python
df['Message'][13]
```

```Output
"I've been searching for the right words to thank you for this breather. I promise i wont take your help for granted and will fulfil my promise. You have been wonderful and a blessing at all times."
```
