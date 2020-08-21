In this unit we will introduce the Quantum Machine Learning Library
of the Quantum Development Kit. The library is an API, written in Q#, that gives
you the ability to run hybrid quantum/classical machine learning experiments.

## Introduction to Quantum Machine Learning

Quantum machine learning is an emerging field of interest for those interested
in quantum computing and how it will impact the future of computing. Classical
machine learning is already revolutionizing the world of science and business.
However, the training of Machine Learning algorithms is computationally costly
and hinders the development and scope of the field. There are some things that 
are very useful in ML that are not very costly to compute, but in general, the 
state-of-the-art models require huge processes of training that cost up to 
millions of dollars in terms of cloud-computing resources. This is why 
researches are exploring how to use quantum technology to train models and 
potentially provide some advantage over classical machine learning algorithms.

The Quantum Machine Learning Library available today provides the necessary
tools to implement a circuit-centric quantum classifier. This classifier is a
new hybrid quantum-classical algorithm to solve supervised classification
problems. It is currently a research library to explore this model of quantum machine
learning, rather than a production-ready tool.

### Classification problem

Classification is a supervised machine learning task. The goal is to infer the
labels $y1, y2, ..., y_d$ of certain data samples by learning from a given
*training data set*. The training data set is a collection of samples
$D_{\text{train}}=(x,y)$ with known pre-assigned labels, where $x$ is a data
sample and $y$ is its known label called *training label*.

#### Classical approach

There are many different classical algorithms to address the classification
problem. Most of them work in the following way:

1. Start with a parametrized classifier function
   $p(x|y_i,\theta)$ that assigns a probability for each label $y_i$ given a sample $x$.
1. Configure the parameters $\theta_\text{model}$ of $p(x|y_i,\theta)$ so that
   it classifies correctly the samples $x$ by assigning the correct label.
1. Test the classifier function $p(x|y_i,\theta)$ in an external dataset
   $D_{\text{test}}$ different from the training set.

A good classifier learns to classify the training data set $D_{\text{train}}$ so
that it can be generalized to any $D_{\text{test}}$. For example, a classifier
that predicts perfectly all the elements of $D_{\text{train}}}$ but performs
badly on $D_{\text{test}}$ is a bad classifier, since it got very specialized in
learning $D_{\text{train}}$ but is not able to generalize. This is commonly
known as *overfitting*.

The general goal of machine learning classification is to find the optimal set of
parameters $\theta$ that yields the best performance.

#### Circuit-centric classifier

The model implemented in the Quantum Machine Learning Library is called *circuit-
centric classifier* and follows a similar logic. In this model, instead of using
a classical function to predict the probabilities, we apply parametrized
operations to a register of qubits encoding the sample $x$. Then by measuring
one of the qubits and repeating this sequence multiple times we can infer the
probabilities associated to each class.

A simple outline of the process would be:

1. Encode the data samples $x$ into the quantum state of the register.
1. Apply the parametrized operations to the qubit register.
1. Measure one of the qubits to obtain the label.
1. Run the circuit many times to obtain the probablities for each label.
1. Adjust the parameters of the operations to improve the performance.
1. Repeat the sequence.

![Deep learning vs circuit centric
classifier](../media/deeplearning-vs-circuitcentric.png)

## Use the Quantum Machine Learning Library

Now let's see how to use the Quantum Machine Learning Library and Q# to solve a
binary classification task. For the moment, the library only admits binary
classification problems. The process would be the following:

1. Load the data of your classification problem.
1. Design the operations that will compose your circuit classifier.
1. Use the library to train the circuit classifier in Q#.
1. Use the library to validate your model.
1. Use your host program (usually Python) to plot and interpret the results of
   the training.

### Try the library

VIDEO PLACEHOLDER

If you want to get hands-on experience with the library, we recommend you to try
our [Q# samples for quantum machine
learning](https://docs.microsoft.com/samples/microsoft/quantum/training-sequential-models-with-q-using-built-in-datasets/)
and read the [library official
documentation](https://docs.microsoft.com/quantum/user-guide/libraries/machine-learning/?view=qsharp-preview).
There you will find a more detailed description and practical examples of how to
use the library.

In the next unit you will learn about another Q# library, the Numerics Library,
that you can use to solve mathematical problems like integer factorization.
