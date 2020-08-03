You're getting so close! The next step is to split your data into training data and testing data. As introduced in LP3M1U7, providing your machine learning classifier with all of your data will only make it really effective at telling you what data you have, but will not actually yield accurate predictions. 

## Why Should You Split Data

One clear way of explaining the importance of splitting data is to compare it to an exam that you might take. Consider a formal class you might be taking. Throughout the class you are shown example problems and told what the answers are. This happens in lectures, homework, and on practice exams. 

Imagine a class where your instructor gave you the exact exam and the exam key (answers) the day before the exam. Would you ace the test?

Of course!!

Would you actually know if you have learned the concepts? Not so much. You're more likely to have learned the answers to the questions on the test - not the concepts that the exam was trying to tets. 

If you want to *actually* learn, you should practice with problems where you have the answers and when you feel confident about those, start trying problems where you don't already know the answers. That is basically what the classifier is doing to "learn". 

## How to Split Data

You will want to split your data into four new variables. Remember, you already have `X` and `y` that represent your input and your output. Now it's time to split both into training and testing data. 

By using scikit-learn and the classifier's splitting function, you can get a random sampling of `X` and `y` that match in order. If the data wasn't split randomly, but instead the first 80% of the rows were taken for training data and the rest were left for testing, it would introduce problems. For example, let's say the data is sorted in date order. If the first 240 rows were taken to train, then you would be training your model on data that pre-dates 1999. This is an issue because the sensors might have changed over time and *only* looking at older data might not be a good indicator to what decisions would be made with new technology.

Paste this code in a cell in Visual Studio code to split your data:

```python
X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=0.2, random_state=99)
```

This code randomly separates the data into four groups: `X_train`, `X_test`, `y_train`, and `y_test`. With scikit-learn's `train_test_split` function you specify 4 important parameters:
- Input data: `X` - These are all of the columns that we want to use to predict a launch
- Output data: `y` - This is the outcome of each row (whether a rocket launched or not)
- Test Size: `0.2` - Training your data on 80% and testing on 20% is a common split in data science
- Random State: `99` - This is a random see that will change the randomness of selecting the data

*Remember: You can come back here and modify the test size and random state to try out other options as well*