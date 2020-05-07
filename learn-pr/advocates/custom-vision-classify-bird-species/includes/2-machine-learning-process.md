We are going to be using an Azure service that creates a Custom Vision model. Let's learn more about how Custom Vision works! Then, you will see the step-by-step process for building a model from idea to model!

## What is machine learning?

You've most likely heard about AI, machine learning, or deep learning before. However, you may not be clear about what they mean and the differences between them. Let's break it down!

*Artificial intelligence (AI)* is a technique that enables computers to mimic human intelligence. It includes machine learning. The idea of AI is as simple as trying to mimic human intelligence by using a machine, but AI includes many different techniques. The technique this module focuses on is machine learning.

*Machine learning (ML)* is a subset of artificial intelligence. Machine learning uses techniques that enable machines to use experience. Think of experience as a dataset, with right and wrong answers already given. In machine learning, the computer uses these answers to improve in completing tasks. The field of machine learning also includes what is called *deep learning*.

*Deep learning (DL)* is a subset of machine learning. Deep learning is based on artificial neural networks. The learning process is deep because the structure of artificial neural networks consists of multiple input layers, output layers, and hidden layers. Each layer contains units that transform the input data into information that the next layer can use for a certain predictive task. The neural network structure allows a machine to learn through its own data processing.

In summary, when we build a model, we're trying to mimic human intelligence. We use data as "experience" to train a model to learn a specific task or function.

## What is transfer learning?

Azure Cognitive Services Custom Vision uses something called *transfer learning*. This is the ability to use prior knowledge to better solve the current problem. We do this all the time as humans, and we are discovering new ways to do this with computers, too. The way it works for Custom Vision is to add a layer in the neural network that is a pre-trained model. This trained model gives us a head start with training new data. It starts with a general knowledge domain, and then new layers are added to the neural network to solve our specific problem. In this case, the problem is identifying birds. This enables us to get better results with less data.

## The model building process

To better understand the model building process, here is a step-by-step overview of the process and how we will go through it to create the model in this module:

1. Ask a pointed question.

   Our question is, can we identify the birds from an image to help document different trends and patterns of the bird habits?

2. Prepare data.

   We have a cleaned and prepared dataset of bird images from Cornell, so this step was taken care of for us. If you were to build a different model, you would need to find and prepare data for training. You would want to find data that would help you answer the pointed question in step one.

3. Select an algorithm.

   The Custom Vision service uses a convolutional neural network (CNN), so we don't have to worry about this step. This saves a *lot* of time!

4. Select a candidate model.

   The Custom Vision service gives us helpful graphs and data to decide whether our model is performing well enough. When we think it is performing well enough, we will move to the next step: test.

5. Test the model by using unseen data.

   It's important to test our model with unseen data. We will do an internet search and find some test images to see how it performs with data it was not trained with. We will discuss later in the module why this is important.

6. Deploy the model.

   Custom Vision gives us a lot of options here. We can use the deploy button that gives us an endpoint to integrate or download the model. If you download the model, it gives you multiple formats to choose from that lets you deploy the way that works best for the project. In this module, we will go over how to use the quick deploy option.

Let's get started building our model!
