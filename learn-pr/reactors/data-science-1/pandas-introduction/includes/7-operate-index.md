As you begin to work in data science, operating on data is imperative. It is the very heart of data science. Another aspect of pandas that makes it a compelling tool for many data scientists is pandas' capability to perform efficient element-wise operations on data. pandas builds on ufuncs from NumPy to supply theses capabilities and then extends them to provide additional power for data manipulation:

> [!Note]
> **Sarah: Action items**
> 
> - Add output for commands.
>

For unary operations (such as negation and trigonometric functions), ufuncs in pandas preserve index and column labels in the output.
For binary operations (such as addition and multiplication), pandas automatically aligns indices when passing objects to ufuncs.
These critical features of ufuncs in pandas mean that data retains its context when operated on and, more importantly still, drastically helps reduce errors when you combine data from multiple sources.

## Index preservation

pandas is explicitly designed to work with NumPy. As a results, all NumPy ufuncs will work on Pandas Series and DataFrame objects.

We can see this more clearly if we create a simple Series and DataFrame of random numbers on which to operate.

```Python
rng = np.random.RandomState(42)
ser_example = pd.Series(rng.randint(0, 10, 4))
ser_example
```


```output
TBD
```

Did you notice the NumPy function we used with the variable rng? By specifying a seed for the random-number generator, you get the same result each time. This can be useful trick when you need to produce psuedo-random output that also needs to be replicatable by others. (Go ahead and re-run the code cell above a couple of times to convince yourself that it produces the same output each time.)

```Python
df_example = pd.DataFrame(rng.randint(0, 10, (3, 4)),
                  columns=['A', 'B', 'C', 'D'])
df_example
```


```output
TBD
```

Let's apply a ufunc to our example Series:

```Python
np.exp(ser_example)
```


```output
TBD
```

The same thing happens with a slightly more complex operation on our example DataFrame:

```Python
np.cos(df_example * np.pi / 4)
```


```output
TBD
```

Note that you can use all of the ufuncs we discussed in Section 3 the same way.

## Index alignment

As mentioned above, when you perform a binary operation on two Series or DataFrame objects, pandas will align indices in the process of performing the operation. This is essential when working with incomplete data (and data is usually incomplete), but it is helpful to see this in action to better understand it.
