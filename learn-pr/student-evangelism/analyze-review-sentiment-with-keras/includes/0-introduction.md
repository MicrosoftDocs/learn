Building neural networks isn't easy. Even with popular libraries such as the [Microsoft Cognitive Toolkit](https://www.microsoft.com/cognitive-toolkit/) and [TensorFlow](https://www.tensorflow.org/) to help out, it often requires several hundred lines of code to get a neural network up and running. That's one reason [Keras](https://keras.io/) has become popular in the deep-learning community. Keras is an open-source Python library that dramatically simplifies the building of neural networks. Under the hood, it uses the Microsoft Cognitive Toolkit, TensorFlow, or [Theano](https://github.com/Theano) to do the heavy lifting. With Keras, you can build sophisticated neural networks with just a few dozen lines of code and train them to classify images, analyze text for sentiment, do natural-language processing, and perform other tasks at which deep learning excels.

![Keras documentation](../media/0-keras.png)

In this module, you'll use Keras to build a neural network that scores text for sentiment. An input such as "Great service, and some of the best sushi I've ever tasted" will score close to 1.0 indicating the sentiment is positive, while an input such as "The food was bland and the service was terrible" will score closer to 0.0. Such systems are widely used today to monitor Twitter, Yelp, and other social-media services for sentiment regarding businesses and political candidates. To minimize setup and configuration, you'll use Keras in a [Jupyter notebook](http://jupyter.org/) hosted in [Azure Notebooks](https://notebooks.azure.com/), where Keras, TensorFlow, and other libraries that you need are preinstalled.

## Learning objectives

In this module, you will:

- Create a Jupyter notebook in Azure Notebooks
- Use Keras to build and train a neural network to perform sentiment analysis
- Use the neural network to analyze text for sentiment