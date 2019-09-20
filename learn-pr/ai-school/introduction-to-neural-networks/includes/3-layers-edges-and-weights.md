Layers, edges, and weights are the structural components of neural networks.

## Layers

![Diagram representing the network description. There are three layers of circles (nodes) - a left-hand layer with three nodes labeled 'input layer', a center layer with four nodes each labeled 'hidden layer' and an output layer with three nodes labeled 'output layer'. There are lines linking each node with each node on the adjacent layers, and these are labeled 'edge'.](../media/5.2_NetworkDescription.png)

Layers are the key component of neural networks. We choose how many nodes each layer contains and how many layers there are in order to maximize the accuracy of our output.

We can have large layers

![Diagram representing large layers. There are three layers of circles (nodes). There is a left-hand layer with six nodes labeled 'input layer', with a red line between the bottom two nodes to indicate there could be more nodes there. There is also a center layer with five nodes each labeled 'hidden layer', with a similar red line to indicate there could be more nodes. There is finally an output layer with three nodes labeled 'output layer', again with a red line. There are lines linking each node with each node on the adjacent layers.](../media/5.2_Large_Layers.png)

and lots of layers

![Diagram representing lots of layers. There are many layers of circles (nodes). There is a left-hand layer with 12 nodes indicating the input layer, with a 12 other layers of white nodes, with arrows in between several layers to indicate more layers could reside there. There are lines linking each node with each node on the adjacent layers.](../media/5.2_Many_Layers__1_.png)

With each layer, the neural network transforms the data we input.

### Edges

The connections between nodes from one layer to the next are called edges. Edges transform the data when it travels through them by simple multiplication.

### Weights

When data travels through the edges, it is multiplied by a value that we call a weight. Each edge has a different weight that starts off as a random value. The value of weights can be positive or negative. Weights are then optimized by gradient descent to give accurate outcomes.

Up next we've got an exercise where you will code a simple neural network.
