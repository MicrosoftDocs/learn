## Layers

![5.2 NetworkDescription](../media/5.2_NetworkDescription.png)

Layers are the key component of neural networks. We choose how many nodes each layer contains and how many layers there are in order to maximize the accuracy of our output.

We can have large layers

![5.2 Large Layers](../media/5.2_Large_Layers.png)

and lots of layers

![5.2 Many Layers (1)](../media/5.2_Many_Layers__1_.png)

With each layer, the neural network transforms the data we input.

### Edges

The connections between nodes from one layer to the next are called edges. Edges transform the data when it travels through them by simple multiplication.

### Weights

When data travels through the edges, it is multiplied by a value which we call a weight. Each edge has a different weight which starts off as a random value. The value of weights can be positive or negative. Weights are then optimized by gradient descent to give accurate outcomes.

## Summary In this section we have covered the core components of neural networks - nodes, layers and edges (connections). We have learnt that:

* __Neural networks__ are systems made up of nodes. Nodes combine data coming in, and output the combined data to other nodes. 
* __Nodes__ are contained within __layers__. We can alter the size of layers, and the number of layers, to give us the most accurate results.
* Each __layer__ is connected by __edges__, which join nodes from different layers together. 
* As data travels through the neural network, it is modified by the __weights__ of the connections.
* __Weights__ start off as a random value, and are optimized by gradient descent to give accurate outcomes.

Up next we've got an introduction to coding neural networks.