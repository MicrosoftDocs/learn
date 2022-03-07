The next step is to split your data into training data and testing data. Providing your machine learning classifier with all of your data only makes it effective at telling you what data you have. It won't yield accurate predictions.

## Why should you split data?

One way to explain the importance of splitting data is to compare it to an exam you might take in a formal class. Throughout the class, you're shown example problems and told what the answers are. This scenario happens in lectures, homework, and on practice exams.

Imagine a class where your instructor gave you the exact exam and the answers the day before the exam. Would you ace the test? Yes!

Would you know if you had learned the concepts? No. You're more likely to have learned the answers to the questions on the test and not the concepts the exam was trying to test.

If you want to *actually* learn, you should practice with problems for which you have the answers. When you feel confident about those problems, try problems for which you don't already know the answers. That's basically how the machine learning classifier "learns."

## Split data

You'll want to split your data into four new variables. You already have `X` and `y` that represent your input and your output. Now it's time to split them both into training and testing data.

By using scikit-learn and the classifier's splitting function, you can get a random sampling of `X` and `y` that match in order. If you didn't split the data randomly, but instead took the first 80% of the rows for training data and left the rest for testing, it would introduce problems.

For example, let's say the data is sorted by date. If the first 240 rows were taken to train, then you would be training your model on data that predates 1999. This scenario is a problem because the sensors might have changed over time. *Only* looking at older data might not be a good indicator for decisions that would be made with new technology.

Paste this code in a cell in Visual Studio Code to split your data:

```python
X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=0.2, random_state=99)
```

This code randomly separates the data into four groups: `X_train`, `X_test`, `y_train`, and `y_test`. With scikit-learn's `train_test_split` function, you specify four important parameters:

- Input data: `X` - All of the columns that we want to use to predict a launch.
- Output data: `y` - The outcome of each row (whether a rocket launched or not).
- Test size: `0.2` - Training on 80% of your data and testing on 20% is a common split in data science.
- Random state: `99` - A random seed that will change the randomness of selecting the data.

You can come back and modify the test size and random state to try out other options, too.