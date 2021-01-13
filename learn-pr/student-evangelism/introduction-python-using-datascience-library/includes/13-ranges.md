A *range* is an array of numbers in increasing or decreasing order, each
separated by a regular interval. Ranges are useful in a surprisingly
large number of situations, so it's worthwhile to learn about them.

Ranges are defined using the `np.arange` function, which takes either
one, two, or three arguments: a start, and end, and a 'step'.

If you pass one argument to `np.arange`, this becomes the `end` value,
with `start=0`, `step=1` assumed. Two arguments give the `start` and
`end` with `step=1` assumed. Three arguments give the `start`, `end` and
`step` explicitly.

A range always includes its `start` value, but does not include its
`end` value. It counts up by `step`, and it stops before it gets to the
`end`.

``` python
    np.arange(end): An array starting with 0 of increasing consecutive integers, stopping before end.
```

``` python
    np.arange(5)
```

``` output
    array([0, 1, 2, 3, 4])
```

Notice how the array starts at 0 and goes only up to 4, not to the end
value of 5.

``` python
    np.arange(start, end): An array of consecutive increasing integers from start, stopping before end.
```

``` python
    np.arange(3, 9)
```

``` output
    array([3, 4, 5, 6, 7, 8])
```



``` python
    np.arange(start, end, step): A range with a difference of step between each pair of consecutive values, starting from start and stopping before end.
```

``` python
    np.arange(3, 30, 5)
```

``` output
    array([ 3,  8, 13, 18, 23, 28])
```

This array starts at 3, then takes a step of 5 to get to 8, then another
step of 5 to get to 13, and so on.

When you specify a step, the start, end, and step can all be either
positive or negative and may be whole numbers or fractions.

``` python
    np.arange(1.5, -2, -0.5)
```

``` output
    array([ 1.5,  1. ,  0.5,  0. , -0.5, -1. , -1.5])
```

#### Example: Leibniz's formula for $\pi$

The great German mathematician and philosopher [Gottfried Wilhelm
Leibniz](https://en.wikipedia.org/wiki/Gottfried_Wilhelm_Leibniz) (1646
\- 1716) discovered a wonderful formula for $\pi$ as an infinite sum of
simple fractions. The formula is

$$\pi = 4 \cdot \left(1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} - \frac{1}{11} + \dots\right)$$

Though some math is needed to establish this, we can use arrays to
convince ourselves that the formula works. Let's calculate the first
5000 terms of Leibniz's infinite sum and see if it is close to $\pi$.

$$4 \cdot \left(1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \frac{1}{9} - \frac{1}{11} + \dots - \frac{1}{9999} \right)$$

We will calculate this finite sum by adding all the positive terms first
and then subtracting the sum of all the negative terms

> [!NOTE]
> $$4 \cdot \left( \left(1 + \frac{1}{5} + \frac{1}{9} + \dots + \frac{1}{9997} \right) - \left(\frac{1}{3} + \frac{1}{7} + \frac{1}{11} + \dots + \frac>{1}{9999} \right) \right)$$

The positive terms in the sum have 1, 5, 9, and so on in the
denominators. The array `by_four_to_20` contains these numbers up to 17:

``` python
by_four_to_20 = np.arange(1, 20, 4)
by_four_to_20
```

``` output
    array([ 1,  5,  9, 13, 17])
```

To get an accurate approximation to $\pi$, we'll use the much longer
array `positive_term_denominators`.

``` python
positive_term_denominators = np.arange(1, 10000, 4)
positive_term_denominators
```

``` output
    array([   1,    5,    9, ..., 9989, 9993, 9997])
```

The positive terms we actually want to add together are just 1 over
these denominators:

``` python
positive_terms = 1 / positive_term_denominators
```

The negative terms have 3, 7, 11, and so on on in their denominators.
This array is just 2 added to `positive_term_denominators`.

``` python
negative_terms = 1 / (positive_term_denominators + 2)
```

The overall sum is

``` python
4 * ( sum(positive_terms) - sum(negative_terms) )
```

``` output
    3.1413926535917955
```

This is very close to $\pi = 3.14159\dots$. Leibniz's formula is looking
good!

> [!NOTE]
> Surprisingly, when we add *infinitely* many fractions, the order can matter! But our approximation to $\pi$ uses only a large finite number of fractions, so
it's okay to add the terms in any convenient order.

## More on arrays

It's often necessary to compute something that involves data from more
than one array. If two arrays are of the same size, Python makes it easy
to do calculations involving both arrays.

For our first example, we return once more to the temperature data. This
time, we create arrays of average daily
[high](http://berkeleyearth.lbl.gov/auto/Regional/TMAX/Text/global-land-TMAX-Trend.txt)
and
[low](http://berkeleyearth.lbl.gov/auto/Regional/TMIN/Text/global-land-TMIN-Trend.txt)
temperatures for the decades surrounding 1850, 1900, 1950, and 2000.

``` python
baseline_high = 14.48
highs = make_array(baseline_high - 0.880, 
                   baseline_high - 0.093,
                   baseline_high + 0.105, 
                   baseline_high + 0.684)
highs
```

``` output
    array([ 13.6  ,  14.387,  14.585,  15.164])
```

``` python
baseline_low = 3.00
lows = make_array(baseline_low - 0.872, baseline_low - 0.629,
                  baseline_low - 0.126, baseline_low + 0.728)
lows
```

``` output
    array([ 2.128,  2.371,  2.874,  3.728])
```

Suppose we'd like to compute the average daily *range* of temperatures
for each decade. That is, we want to subtract the average daily high in
the 1850s from the average daily low in the 1850s, and the same for each
other decade.

We could write this laboriously using `.item`:

``` python
make_array(
    highs.item(0) - lows.item(0),
    highs.item(1) - lows.item(1),
    highs.item(2) - lows.item(2),
    highs.item(3) - lows.item(3)
)
```

``` output
    array([ 11.472,  12.016,  11.711,  11.436])
```

As when we converted an array of temperatures from Celsius to
Fahrenheit, Python provides a much cleaner way to write this:

``` python
highs - lows
```

    array([ 11.472,  12.016,  11.711,  11.436])

![Array subtraction.](../media/array-subtraction.png)

What we've seen in these examples are special cases of a general feature
of arrays.

### Elementwise arithmetic on pairs of numerical arrays

If an arithmetic operator acts on two arrays of the same size, then the
operation is performed on each corresponding pair of elements in the two
arrays. The final result is an array.

For example, if `array1` and `array2` have the same number of elements,
then the value of `array1 * array2` is an array. Its first element is
the first element of `array1` times the first element of `array2`, its
second element is the second element of `array1` times the second
element of `array2`, and so on.

### Example: Wallis' Formula for $\pi$

The number $\pi$ is important in many different areas of math. Centuries
before computers were invented, mathematicians worked on finding simple
ways to approximate the numerical value of $\pi$. We have already seen
Leibniz's formula for $\pi$. About half a century before Leibniz, the
English mathematician [John
Wallis](https://en.wikipedia.org/wiki/John_Wallis) (1616-1703) also
expressed $\pi$ in terms of simple fractions, as an infinite product.

$$
\pi = 2 \cdot \left( \frac{2}{1}\cdot\frac{2}{3}\cdot\frac{4}{3}\cdot\frac{4}{5}\cdot\frac{6}{5}\cdot\frac{6}{7}\dots \right)
$$

This is a product of "even/odd" fractions. Let's use arrays to multiply
a million of them, and see if the product is close to $\pi$.

Remember that multiplication can done in any order,
so we can readjust our calculation to:

> [!NOTE] 
> $$\pi \approx 2 \cdot \left( \frac{2}{1} \cdot \frac{4}{3} \cdot \frac{6}{5} \cdots \frac{1,000,000}{999999} \right) \cdot \left( \frac{2}{3} \cdot \frac{4}{5} \cdot \frac{6}{7} \cdots \frac{1,000,000}{1,000,001} \right)$$

We're now ready to do the calculation. We start by creating an array of
even numbers 2, 4, 6, and so on upto 1,000,000. Then we create two lists
of odd numbers: 1, 3, 5, 7, ... upto 999,999, and 3, 5, 7, ... upto
1,000,001.

``` python
even = np.arange(2, 1000001, 2)
one_below_even = even - 1
one_above_even = even + 1
```

Remember that `np.prod` multiplies all the elements of an array
together. Now we can calculate Wallis' product, to a good approximation.

``` python
2 * np.prod(even/one_below_even) * np.prod(even/one_above_even)
```

``` output
    3.1415910827951143
```

That's $\pi$ correct to five decimal places. Wallis clearly came up with
a great formula.

> [!NOTE] 
> As we saw in the example about Leibniz's formula, when we add *infinitely* many fractions, the order can matter. The same is true with multiplying fractions, as we are doing here. But our approximation to $\pi$ uses
only a large finite number of fractions, so it's okay to multiply the
terms in any convenient order.
