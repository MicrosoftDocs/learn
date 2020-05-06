We are going to be using an Azure service that creates a Computer Vision model. Lets learn more about how Computer Vision works! Then you will see the step by step process for building a model from idea to model!

## What is machine learning?

You've most likely heard about AI, machine learning, or deep learning before. However, you may not be clear about what they mean and the differences between them. Let's break it down!

**Artificial intelligence (AI)** is a technique that enables computers to mimic human intelligence. It includes machine learning. The idea of AI is as simple as trying to mimic human intelligence with a machine, but AI includes many different techniques. The technique this  module focuses on is machine learning.

**Machine learning (ML)** is a subset of artificial intelligence that uses techniques that enable machines to use experience. Think of experience as a dataset with right and wrong answers already given, that the computer can use to improve at tasks. The field of machine learning also includes what is called deep learning.

**Deep learning (DL)** is a subset of machine learning that's based on artificial neural networks. The learning process is deep because the structure of artificial neural networks consists of multiple input, output, and hidden layers. Each layer contains units that transform the input data into information that the next layer can use for a certain predictive task. The neural network structure allows a machine to learn through its own data processing.

In summary, when we build a model we're trying to mimic human intelligence. We use data as "experience" to train a model to learn a specific task or function.

## What is transfer learning?

Azure Custom Vision uses something called **transfer learning**. This is the ability to use prior knowledge to better solve the current problem. We do this all the time as humans and we are discovering new ways to do this with computers too. The way it works for computer vision is to add a layer in the neural network that is a pre-trained model. This trained model gives us a head start with training on new data. It starts with a general knowledge domain and then new layers are added to the neural network to solve our specific problem. In this case, identifying birds. This enables us to get better results with less data.

## The Model building process

To better understand the model building process, here is a step-by-step overview of the process and how we will go through it to create the model in this module:

1. Ask a pointed question

   - Our question is can we identify the birds from an image to help document different trends and patterns of the bird habits?

2. Prepare data

   - We have a cleaned and prepared dataset of bird images from Cornell so this step was taken care of for us. If you were to build a different model you would need to find and prepare data for training. You would want to find data that would help you answer the pointed question from step one.

3. Select algorithm

   - The Custom Vision service uses a CNN (convolutional neural network) so we don't have to worry about this step. This saves a LOT of time!

4. Select candidate model

   - The Custom Vision service gives us helpful graphs and data to decide if our model is performing well enough. Once we think it is performing good enough we will move to the next step: test.

5. Test model with unseen data

   - It's important to test our model with unseen data. We will do an internet search and find some test images to see how it performs with data it was not trained with. We will discuss later in the module why this is important.

6. Deploy model

   - Custom Vision gives us a lot of options here. We can use the deploy button that gives us an endpoint to integrate or download the model. If you download the model, it gives you multiple formats to choose from that lets you deploy the way that works best for the project. In this module, we will go over how to use the quick deploy option.

Lets get started on building our model!
