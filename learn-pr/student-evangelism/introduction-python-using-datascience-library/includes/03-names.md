Names are given to values in Python using an *assignment* statement. In
an assignment, a name is followed by `=`, which is followed by any
expression. The value of the expression to the right of `=` is
*assigned* to the name. Once a name has a value assigned to it, the
value will be substituted for that name in future expressions.

``` python
a = 10
b = 20
a + b
```

    30

A previously assigned name can be used in the expression to the right of
`=`.

``` python
quarter = 1/4
half = 2 * quarter
half
```

    0.5

However, only the current value of an expression is assigned to a name.
If that value changes later, names that were defined in terms of that
value will not change automatically.

``` python
quarter = 4
half
```

    0.5

Names must start with a letter, but can contain both letters and
numbers. A name cannot contain a space; instead, it is common to use an
underscore character `_` to replace each space. Names are only as useful
as you make them; it's up to the programmer to choose names that are
easy to interpret. Typically, more meaningful names can be invented than
`a` and `b`. For example, to describe the sales tax on a \$5 purchase in
Berkeley, CA, the following names clarify the meaning of the various
quantities involved.

``` python
purchase_price = 5
state_tax_rate = 0.075
county_tax_rate = 0.02
city_tax_rate = 0
sales_tax_rate = state_tax_rate + county_tax_rate + city_tax_rate
sales_tax = purchase_price * sales_tax_rate
sales_tax
```

    0.475
