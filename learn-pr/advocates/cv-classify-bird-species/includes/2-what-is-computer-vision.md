We are going to be using an Azure service that creates a Computer Vision model. Lets learn a little bit more about how Computer Vision works and how the service uses Transfer Learning to increase accuracy with less data. Then you will see the step by step process for building a model from idea to model!

## What is Machine Learning?

You've most likely heard about AI, Machine Learning, or Deep Learning before. However, you may not be clear about what they mean and the differences between them. Let's break it down!

**Artificial intelligence (AI)** is a technique that enables computers to mimic human intelligence. It includes machine learning. We're simply trying to mimic human intelligence with a machine and includes different techniques. The one we're focusing on is Machine Learning.

**Machine learning (ML)** is a subset of artificial intelligence that uses techniques that enable machines to use experience. Think of experience as a dataset used to improve at tasks. It includes what is called Deep learning.

**Deep learning (DL)** is a subset of machine learning that's based on artificial neural networks. The learning process is deep because the structure of artificial neural networks consists of multiple input, output, and hidden layers. Each layer contains units that transform the input data into information that the next layer can use for a certain predictive task. The neural network structure allows a machine to learn through it's own data processing.

In summary, when we build a model we're trying to mimic human intelligence. We use data as "experience" to train a model to learn a specific task or function.

## What is Transfer Learning?

The ability to use prior knowledge to better solve the current problem. We do this all the times as humans and we are discovering new ways to do this with computers too. The way it works for computer vision is we add a layer in the neural network that is a trained model. This trained model gives us a head start with training. It starts with a general knowledge domain and then new layers are added to the neural network to solve the specific problem we are trying to solve. In this case, identifying birds.

## The Model Building Process

Here is a step by step overview of the model building process and how we will complete it to create this model.

1. Ask a pointed question

   - Our question is can we identify the birds from an image to help document different trends and patterns of the bird habits?

2. Prepare data

   - We will have a cleaned and prepared dataset of bird images from Cornell so this step was taken care of for us. If you were to build a different model you would need to find and prepare data for training. You would want to find data that would help you answer the pointed question from step 1.

3. Select algorithm

   - The Custom Vision service uses a CNN (Convolutional neural network) so we don't have to worry about this step. This saves a LOT of time!

4. Select candidate model

   - The Custom Vision service gives us helpful graphs and data to decide if our model is performing well enough. Once we think it is performing good enough we will move to the next step: test.

5. Test model with unseen data

   - It's important to test our model with unseen data. We will do a google search and find some test images to see how it preforms with data it was not trained with. We will discuss later in the module why this is important.

6. Deploy model

   - Custom vision gives us lots of options here. We can use the deploy button which gives us an endpoint to integrate or download the model in a format of our choice to operationlize the way that works best for the project. In this module we will go over two options: use the one click deploy or download the model and run it on a IoT device with a camera.

Lets get started on building our model!!
