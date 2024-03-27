We'll use the Azure AI Custom Vision service to create a machine learning model. Let's learn more about how Custom Vision works. Then, you'll see the step-by-step process we use to build a model, from idea to fully functioning model!

## What is machine learning?

It's likely that you've heard of AI, machine learning, or deep learning. Let's identify the terms, so we understand how they're different.

- **Artificial intelligence (AI)**: AI is the process of programming a computer to mimic human intelligence. AI includes *machine learning*. The idea of AI is to use a machine to mimic human intelligence, but AI offers many different techniques. The technique this module focuses on is machine learning.

- **Machine learning**: Machine learning is a subset of AI. Machine learning uses techniques to train machines based on *experience*. Think of experience as a dataset, with right and wrong answers already given. In machine learning, the computer uses the answers that are supplied to improve how the computer completes specific tasks. The field of machine learning also includes *deep learning*.

- **Deep learning**: Deep learning is a subset of machine learning that's based on *artificial neural networks (ANNs)*. The learning process is *deep* because ANNs consists of multiple layers: input, output, and hidden layers. Each layer contains units that transform the input data into information that the next layer can use for a specific predictive task. The neural network structure enables a machine to learn through its own data processing.

  :::image type="content" source="../media/machine-learning-types.png" alt-text="A graphical depiction of the nested relationship between A I, machine learning, and deep learning." border="false":::

When we build a model, we're trying to mimic human intelligence. We use data as "experience" to train a model to learn a specific task or function.

## What is transfer learning?

Azure AI Custom Vision uses *transfer learning*. Transfer learning is the ability to use prior knowledge to better solve the problem at hand. As humans, we take this approach to problem solving all the time. We're discovering new ways to do it with computers, too. 

In the Custom Vision service in Azure, transfer learning works by adding a layer that consists of a pre-trained model to the neural network. The trained model gives us a head start when we train new data. Training starts with a general-knowledge domain. New layers are added to the neural network to solve a specific problem. In this case, the problem we want to solve is how to identify birds. By starting with a pre-trained model, we get better results without adding large amounts of data.

## How to build a machine learning model

To better understand the process of building a machine learning model, here's a step-by-step overview of the process. We'll complete this process to create a machine learning model.

:::image type="content" source="../media/machine-learning-process.png" alt-text="A graphical depiction of six steps in the process of building a machine learning model." border="false":::

1. *Ask a pointed question.* Our question is, can we identify a bird's species from an image of a bird, to help document different trends and patterns of bird habits?

1. *Prepare data.* We have a dataset of bird images from the Cornell Lab that's clean and prepared, so this step is taken care of. If you built a different model, you would need to find and prepare data for training your model. You would want to find data that would help you answer the pointed question that you're interested in.

1. *Select an algorithm.* The Custom Vision service in Azure uses a *convolutional neural network (CNN)*, so we don't have to worry about this step. A CNN is a type of deep learning that's commonly used to analyze images. Having the algorithm already created saves us a *lot* of time!

1. *Select a candidate model.* The Custom Vision service gives us helpful graphs and data to help us determine whether our model is performing well enough to satisfactorily answer our question. When we think the model is performing at a satisfactory level, we move to the next step: test.

1. *Test the model by using unseen (new) data.* It's important to test our model by adding new data. We'll do an internet search and find some test images to see how the model performs with data it wasn't trained with. We'll discuss later in the module why testing this way is important.

1. *Deploy the model.* Custom Vision gives us some options when it's time to deploy our model. We can deploy to an endpoint to integrate the model or we can download the model. If you download the model, you can choose from multiple formats to deploy the way that works best for your project. In this module, we'll discuss how to use the quick-deploy option that's available in the Custom Vision portal.

Let's get started building our model!
