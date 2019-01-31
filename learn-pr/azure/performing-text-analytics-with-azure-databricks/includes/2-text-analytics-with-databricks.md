Suppose you work for an analytics organization and currently your team is tasked with analyzing two different sets of textual data. The output required for both sets of data is classification. One set of data is for movie classification and the other is for insurance claim classification. You're responsible for developing machine learning algorithms to perform text analytics on both sets of data.

## Movie classification

The first set of data includes detailed information about movies on the IMDb website. Your machine learning model must analyze all the available information and categorize each movie as either drama or non-drama. You've decided to leverage the capabilities of Azure Databricks to develop your machine learning model using basic model training, evaluation, and predictions techniques.

You'll follow the steps listed below to work on your model for this data set:

1. **Perform exploratory data analysis (EDA)**. You'll first perform initial EDA to rule out some obvious variances in the data, such as description lengths, strong imbalance of two categories, and total word count.
1. **Split** your data set into training and testing data.
1. **Perform word embedding**, where you train your model to learn a common representation for words that have similar meaning.
1. **Train, evaluate, and predict** your machine learning model using different techniques.

## Claims classification

The second set of data includes insurance claim information and your machine learning model is required to categorize the data either as auto insurance or home insurance. You've decided to develop this model using deep learning techniques.

You'll be performing the following tasks to train your machine learning model:

1. **Normalize the training text data**. In this step, you'll clean up your data for basic formatting such as expand contractions, lowercase all text, remove special characters, and remove stop words (such as "a", "an", "the" that add no value).
1. **Extract the features of the training text as vectors**. The goal of this step is to create a numeric representation of the textual documents. During feature extraction, a "vocabulary" of unique words is identified and each word becomes a column in the output. In other words, the table is as wide as the vocabulary. Each row represents a document. The value in each cell is typically a measure of the relative importance of that word in the document, where if a word from the vocabulary doesn't appear that cell has a zero value in that column. In other words, the table is as tall as all of the documents in the data set. This approach enables machine learning algorithms, which operate against arrays of numbers, to also operate against text because each text document is now represented as an array of numbers. Deep learning algorithms operate on tensors, which are also vectors (or arrays of numbers) and so this approach is also valid for preparing text for use with a deep learning algorithm.
1. **Create and train a DNN-based classifier model**. Here you build  simple neural network with multiple layers consisting of inter-connected nodes. You'll train this model using regression techniques. 
1. **Use the model to predict classifications**. After training you machine learning model, you use it against different data set to predict insurance claims classification.