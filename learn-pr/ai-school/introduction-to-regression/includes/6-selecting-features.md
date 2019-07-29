Although using polynomial regression is very similar to multiple linear regression, behind the scenes the model is more complex. As training time increases when models get more complex it is vital to ensure your data is in an appropriate format.

### Selecting features for your data set

Good features will allow your algorithm to become more accurate. To increase the chance of having a successful AI project, you should allocate a large proportion of your time to collecting and preparing good data first. After you’ve made sure your data is good, *then* you can experiment with different algorithms to increase your model’s accuracy. For most kinds of machine learning, selecting features yourself can be important in making accurate models.

#### What is a good feature

Usually, good features are things which are related to what you want to measure or predict. For example, if you are using AI to try to identify the breed of a dog, features such as tail curl, weight, height and ear droop might be quite useful, whereas the dog’s age is not likely to be very useful.  
  
Features should appear in the data set many times, as models need many examples in order to learn. If you gathered data about three species of flowers to predict their petal length, adding a single example of a new species would not be recommended.
  
#### Good data sets

Good data sets do not contain duplicates, and good features do not contain missing values or bad data points. Often data is not missing but incorrect, such as having a 0 for the height of a child. You can save a lot of time by checking for inaccurate or bad data points early, such as having a negative value in a column of values which should only be positive.

### Feature scaling

Feature scaling is reformatting your data set so all your features are within a similar range. You might decide to use feature scaling if your model was trying to predict the price of a couch based on how many people it would seat (2, 3, 4) and its length in millimeters (1500, 2000, 2500). The values for each feature are quite different, so your model may take a while to make and be less accurate.  
  
Some modern AI tools use feature scaling automatically for you.

Next up we have a summary of the module.