In this section, we'll use the [SMS Spam Collection dataset](https://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection?azure-portal=true). It contains 5,574 messages collected for SMS spam research and tagged as "spam" or "ham." The dataset files contain one message per line with each line being composed of the tag and the raw text of the SMS message. For example:

| Class	| Message | 
| :----- | :--------- |
| ham |	What you doing?how are you? |
| ham |	Ok lar... Joking wif u oni... |

Let’s now import pandas and load the dataset. The path name is case-sensitive.

```Python
import pandas as pd 
df = pd.read_csv('Data/SMSSpamCollection', sep='\t', names=['Class', 'Message'])
```

### Try it yourself

What do the `sep` and `names` parameters do in the preceding code?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>
  
If you are unsure, you can refer to the built-in Help documentation using <code>pd.read_csv?</code> in a new code cell.

TBD - Provide an output?

----

</details>

Let's take an initial look at what's in the dataset:

```Python
df.head()
```

Note that several entries in the `Message` column are truncated. We can use the `set_option()` function to set pandas to display the maximum width of each entry.

```Python
pd.set_option('display.max_colwidth', -1)
df.head()
```

### Try it yourself

What do you think the purpose of the `-1` parameter passed to `pd.set_option()` is in the code cell above?

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>
  
TBD - Provide an output

----

</details>

Alternatively, we can dig into individual messages.

```Python
df['Message'][13]
```