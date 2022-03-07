A common type of data that is prevalent in machine learning is called *categorical* data. Categorical data implies discrete or a limited set of values. For example, a person’s gender or ethnicity is considered as categorical. Let’s consider the following data table:

| SKU | Make | Color | Quantity | Price | 
| --- | --- | --- | --- | --- |
| 908721 | G | Blue | 789 | 45.33 |
| 456552 | T | Red | 244 | 22.91 | 
| 789921 | A | Green | 387 | 25.92 |
| 872266 | G | Blue | 154 | 17.56 |

In the table above, the row describes a single observation, and each column describes different properties of the observation. In the table, we have two types of data, numeric data such as `Quantity` and `Price`, and categorical data such as `Make` and `Color`. In the previous lesson, we looked at examples of how to scale numeric data types. Furthermore, it is important to note that in machine learning, we ultimately always work with numbers or specifically, `vectors`. In this context, a vector is either an array of numbers, or nested arrays of numbers. So how does one encode categorical data for the purposes of machine learning? We will look at two common approaches for **encoding** categorical data: 
- Ordinal encoding
- One-hot encoding

## Ordinal encoding

Ordinal encoding, converts categorical data into integer codes ranging from 0 to (number of categories – 1). For example, the categories `Make` and `Color` from the above table are encoded as:

| Make | Encoding |
| --- | --- |
| A | 0 |
| G | 1 |
| T | 2 |

| Color | Encoding |
| --- | --- |
| Red | 0 |
| Green | 1 |
| Blue | 2 |

Using the above encoding, the transformed table is shown below:

| SKU | Make | Color | Quantity | Price |
| --- | --- | --- | --- | --- |
| 908721 | 1 | 2 | 789 | 45.33 |
| 456552 | 2 | 0 | 244 | 22.91 | 
| 789921 | 0 | 1 | 387 | 25.92 | 
| 872266 | 1 | 2 | 154 | 17.56 |

## One-hot encoding

One-hot encoding is often the recommended approach, and it involves transforming each categorical value into n (= number of categories) binary values, with one of them 1, and all others 0. For example, the above table can be transformed as:

| SKU | A | G | T | Red | Green | Blue | Quantity | Price |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 908721 | 0 | 1 | 0 | 0 | 0 | 1 | 789 | 45.33 |
| 456552 | 0 | 0 | 1 | 1 | 0 | 0 | 244 | 22.91 |
| 789921 | 1 | 0 | 0 | 0 | 1 | 0 | 387 | 25.92 |
| 872266 | 0 | 1 | 0 | 0 | 0 | 1 | 154 | 17.56 |

One-hot encoding is often preferred over ordinal encoding because it encodes each category item with equal weight. In our above example, the ordinal encoder assigned color `Green = 1` and color `Blue = 2`, and that can imply that color Blue is twice as important as color Green. Whereas, with one-hot encoding each color is weighted equally.