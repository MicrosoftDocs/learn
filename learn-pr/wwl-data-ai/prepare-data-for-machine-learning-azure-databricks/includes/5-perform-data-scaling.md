Scaling numerical features is an important part of preprocessing data for machine learning. Typically the range of values each input feature takes vary greatly between features. There are many machine learning algorithms that are sensitive to the magnitude of the input features and thus without feature scaling, higher weights might get assigned to features with higher magnitudes irrespective of the importance of the feature on the predicted output.

There are two common approaches to scaling numerical features: 
- **Normalization** 
- **Standardization** 

We will discuss each of these approaches below.

## Normalization

Normalization mathematically rescales the data into the range [0, 1].

For example, for each individual value, you can subtract the minimum value for that input in the training dataset, and then divide by the range of the values in the training dataset. The range of the values is the difference between the maximum value and the minimum value.

## Standardization

Standardization rescales the data to have mean = 0 and standard deviation = 1.

For the numeric input, you first compute the mean and standard deviation using all the data available in the training dataset. Then, for each individual input value, you scale that value by subtracting the mean and then dividing by the standard deviation.