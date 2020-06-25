In contrast to k-means clustering, Naive Bayes is a supervised machine learning algorithm. The Naive Bayes algorithm provides speed and accuracy in machine learning. It's often used in aspects of natural language processing, such as text classification. We'll use Naive Bayes for spam detection.

Spam emails are more than just a nuisance. In 2008, spam constituted an apocalyptic 97.8 percent of all email traffic, according to a [2009 Microsoft security report](https://download.microsoft.com/download/4/3/8/438BE24D-4D58-4D9A-900A-A1FC58220813/Microsoft_Security_Intelligence_Report%20_volume8_July-Dec2009_English.pdf?azure-portal=true). As of May 2019, spam makes up only about [85 percent of email traffic](https://www.talosintelligence.com/reputation_center/email_rep?azure-portal=true). Naive Bayes spam filters have contributed to that improvement.

Naive Bayes is a convenient algorithm to use for spam detection because it doesn't require encoding complex rules. All it needs is training examples, of which there are plenty when it comes to email spam. Naive Bayes does this work by using [conditional probability](https://wikipedia.org/wiki/Conditional_probability?azure-portal=true).

## Learning objectives

In this module, you will:

- Learn the strengths and limitations of conditional probability and Naive Bayes machine learning.
- Use pandas to evaluate a dataset of email messages for spam or ham.
- Use Matplotlib to generate a word cloud, and then use Natural Language Toolkit and scikit-learn for deeper analysis of the data.
- Use the Naive Bayes classifier to classify the data in a spam dataset and improve the accuracy of a machine learning model.

## Prerequisites

- Introduction to Python for data science

[!INCLUDE [Set up your environment](../../includes/set-up-environment.md)]
