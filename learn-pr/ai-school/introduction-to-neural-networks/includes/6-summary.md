Well done! That's the hardest part of the course done.

You’ve now covered the fundamentals of neural networks. Don’t feel concerned if you are a little confused at this stage: neural networks are not at all intuitive, even to experts. There is also a lot of jargon, which is normal to feel is difficult. Lets recap what we have learned.

We learned that:
* Neural networks are made up of nodes.
  * Each node receives information, combines it using simple addition, plus some kind of __activation function__, and sends the result to other nodes (usually) in the next "layer".
  * The connections between nodes are called __edges__ and multiply the values passing through them by their __weight__ (number).
  * Eventually this information reaches the output layer and the values output by these final nodes are interpreted as a predicted category like "ear" or "dog".
* Training a neural network is all about changing __weights__ until accurate predictions are reliably made.
* Weights are changed using gradient descent. For each step in this:
  * A training example is processed by the neural network (__forward propagation__).
  * The prediction is compared to reality
  * __Back propagation__ identifies which weights need to change and by how much
  * Back propagation calculates error for each edge by working backwards from the output toward the input node.

Now that you have reviewed this module, you should be able to:

* Learn about neural network structures, layers, edges, and weights.
* Visualize predictions and refine neural network models.
* Apply different types of activation functions and optimizers.

Next up we’ll cover some variations of neural networks in deep learning, and their modern applications.