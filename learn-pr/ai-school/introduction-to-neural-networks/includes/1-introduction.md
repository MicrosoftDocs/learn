Originally hypothesized in the 1940s, neural networks are now one of the main tools used in modern machine learning. Neural networks can be used for both regression and categorization applications. Recent advances with storage, processing power, and open-source tools have allowed many successful applications of neural networks in medical diagnosis, filtering explicit content, speech recognition, and machine translation.

## Nodes

Neural networks are made up of connected __nodes__, which data passes through. A node combines data sent to it from other nodes, then outputs the combined data to nodes further down the neural network. (Like brain pathways made up of neurons connected together by synapses.)

![Diagram representing a single node/neuron. There is a large white circle in the middle of the diagram, which has 3 blue circles either side of it. each blue circle has a line that connects it to the main white circle. The blue circles on the left-hand side are labeled 'input from other nodes' and the blue circles on the right-hand side are labeled 'output to other nodes'.](../media/51-nn.png)

Nodes are contained in __layers__. Like other AI models we have used in this course, neural networks have an input layer (our features) and an output layer (our labels). Where neural networks differ is what is in between the input and output layers - __hidden layers__.

![Diagram representing the flow of data through a neural network. There are 4 layers of circles (nodes) - a top layer with 2 nodes labeled 'input layer', two layers with 3 nodes each labeled 'hidden layers' and an output layer with 2 nodes labeled 'output layer'. There are lines linking each node with each node on the adjacent layers. The flow of data is shown by an arrow down the diagram, from the input layer towards the output layer.](../media/51-nf.png)

These layers are considered ‘hidden’ because they are not seen in the training set. Like our previous examples in this course, training sets for neural networks only contain our input (features) and output (labels).

Notice all the interconnecting lines - each node passes its output to the nodes on the next layer. All this data combination is what allows neural networks to interpret very complex data.

Deep learning and other variations of neural networks are very similar. The difference is in how the nodes are arranged and which nodes are connected to other nodes. For example, computer vision looks at the pixels close to a data point.

![Photo of an elephant with a red square in the middle of the photo, on the elephants ear.](../media/51-ee.jpg)

So to predict that what’s in this red square is part of an elephant’s ear, the neural network would look closely around the red square, and not at the grass at the bottom of the image.

## Layers

![Diagram representing the network description. There are three layers of circles (nodes) - a left-hand layer with three nodes labeled 'input layer', a center layer with four nodes each labeled 'hidden layer' and an output layer with three nodes labeled 'output layer'. There are lines linking each node with each node on the adjacent layers, and these are labeled 'edge'.](../media/52-nd.png)

Layers are the key component of neural networks. We choose how many nodes each layer contains and how many layers there are in order to maximize the accuracy of our output.

We can have large layers, which have many nodes

![Diagram representing large layers. There are three layers of circles (nodes). There is a left-hand layer with six nodes labeled 'input layer', with a red line between the bottom two nodes to indicate there could be more nodes there. There is also a center layer with five nodes each labeled 'hidden layer', with a similar red line to indicate there could be more nodes. There is finally an output layer with three nodes labeled 'output layer', again with a red line. There are lines linking each node with each node on the adjacent layers.](../media/52-ll.png)

and lots of layers, sometimes more than 100

![Diagram representing lots of layers. There are many layers of circles (nodes). There is a left-hand layer with 12 nodes indicating the input layer, with a 12 other layers of white nodes, with arrows in between several layers to indicate more layers could reside there. There are lines linking each node with each node on the adjacent layers.](../media/52-ml-1.png)

With each layer, the neural network transforms the data we input.

### Edges

The connections between nodes from one layer to the next are called edges. Edges transform the data when it travels through them by simple multiplication.

Up next we've got an exercise where you will code a simple neural network.

In this module, we’ll work through the fundamentals of neural networks and train two simple neural networks models in Azure Notebooks.

**In this module, you will learn to:**

* Learn about neural network structures, layers, edges, and weights.
* Visualize predictions and refine neural network models.
* Apply different types of activation functions and optimizers.

We’ll introduce you to the key concepts of neural networks and get you building your first neural networks in Azure Notebooks.

Let’s explore the fundamentals of neural networks.
