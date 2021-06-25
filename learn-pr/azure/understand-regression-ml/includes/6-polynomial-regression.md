So far, we’ve only looked at linear regression models – i.e. models that can be modelled as straight lines. Regression models can work with virtually any other kind of relationship, though.

## What is polynomial regression?
Polynomial regression models relationships as a particular kind of curve. Polynomials are a family of curves – ranging from simple to complex shapes. The more parameters in the equation (model), the more complex the curve can be.

For example a two-parameter polynomial is simply a straight line:

y = intercept + B1*x

![polynomial regression graph](../media/6-polynomial-graph.png)

While a three-parameter polynomial has a single bend in it:

y = intercept + B1*x + B2 * x2

![three parameter polynomial graph](../media/6-three-parameter-polynomial.png)

And a four-parameter polynomial can have two bends:

y = intercept + B1*x + B2 * x2 + B3 * x3

![four parameter polynomial graph](../media/6-four-parameter-polynomial.png)

### Polynomial versus other curves

There are many kinds of curves, such as log curves, and logistic (s-shaped) curves, all of which can be used with regression.

![polynomial example curves](../media/6-polynomial-vs-curves.png)

A major advantage of polynomial regression is that it can be used to look at all sorts of relationships. For example, polynomial regression it can be used for relationships that a negative within a certain range of feature values, but positive within others. It can also be used where the label (y value) has no theoretical upper limit.

![polynomial example curves with plots](../media/6-example-curves.png)

The major disadvantage to polynomial curves is that they often extrapolate poorly. In other words, if we try to predict values that are larger or smaller than our training data, polynomials can predict unrealistically extreme values. Another disadvantage is that polynomial curves are easy to overfit. This means that noise in the data can change the shape of the curve much more than simpler models, such as simple linear regression.

![polynomial curve with plots](../media/6-curve.png)

### Can curves be used with multiple features?

We have seen how multiple regression can fit several linear relationships at the same time. There is no need for these to be limited to linear relationships, however. Curves of all kinds can be used for these relationships where appropriate. Care should be taken, however, not to use curves (such as polynomials) in with multiple features where they are not necessary. This is because the relationships can end up very complex, which makes it harder to understand the models, and assess whether they will make predictions that do not make sense, from a real-world standpoint.