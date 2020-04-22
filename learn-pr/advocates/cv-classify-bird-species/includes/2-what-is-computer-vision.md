We are going to be using an Azure service that creates a model using Computer Vision. Lets learn a little bit more about how Computer Vision works and how the service uses Transfer Learning to increase accuracy with less data.

## What is Machine Learning?

You've most likely heard about AI, Machine Learning, or Deep Learning before. However, you may not be clear about what they mean and the differences between them. Let's break it down!

**Artificial intelligence (AI)** is a technique that enables computers to mimic human intelligence. It includes machine learning. We're simply trying to mimic human intelligence with a machine and includes different techniques. The one we're focusing on is Machine Learning.

**Machine learning (ML)** is a subset of artificial intelligence that uses techniques that enable machines to use experience. Think of experience as a dataset used to improve at tasks. It includes what is called Deep learning.

**Deep learning (DL)** is a subset of machine learning that's based on artificial neural networks. The learning process is deep because the structure of artificial neural networks consists of multiple input, output, and hidden layers. Each layer contains units that transform the input data into information that the next layer can use for a certain predictive task. The neural network structure allows a machine to learn through it's own data processing.

## What is a Neural Netowork

## What is Transfer Learning

The ability to use prior knowledge to better solve the current problem. We do this all the times as humans and we are discovering new ways to do this with computers too. The way it works for computer vision is we add a layer in the Neural Network that is a pretrained model. This pretrained model gives us a head start with training. Its able to not start with 0. It starts with a genernal knowledge domain and then new layers are added to the neural network to solve the speific problem we are trying to solve. In this case, identifying birds.

## The model building process overview

1. Ask a question.

- Our question is can we identify the birds from our endangered species list?

2. Prepare data

- We will scrape an image dataset and review it to make sure it is correct.

3. Select algorithm

- With the Custom Vision service we don't have to worry about this step. This saves a LOT of time!

4. Select candidate model

- The Custom Vision service gives us helpful graphs and data to decide if our model is performing well enough.

5. Test model with unseen data

- When we scrape our data set we will parse every 3rd image to a test folder to generate and unseen dataset for testing.

6. Deploy model

- Custom vision gives us lots of options here. We can use the deploy button which gives us an endpoint to integrate or download the model in a format of our choice to opperationlize the way that works best for the project. We are going to download our model and run it on a raspberry pi with a camera.

In summary, when we build a model we're trying to mimic human intelligence. We use data as "experience" to train a model to learn a specific task or function.
