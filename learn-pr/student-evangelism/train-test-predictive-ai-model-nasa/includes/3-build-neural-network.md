We'll build a neural network (or deep learning network) to learn the associations between features and each rock type. Features can include things like curves, edges, and texture.


## Neurons and wired networks

Neural networks process information similar to how our brains work. Our brains have neurons or nerve cells that transmit and process information from our senses. Many nerve cells are arranged as a network of nerves in the brain. The nerves pass electrical impulses from one neuron to the next in the network.

Neural networks have millions of neurons and nerves. To build a functional neural network, we wire the neurons and nerves together in two steps:

- Step A: Build all the neurons.
- Step B: Wire the neurons in an appropriate way.

   > _There are thousands of ways to wire neurons!_

In our model, we'll collect the features for a rock from an image and store them as a linear sequence of parameters. This step builds a single neuron. Every new image that's analyzed is another neuron. We supply the training data for our computer to build all the neurons.

Then we'll tell the computer to combine the sequences into a matrix. The matrix represents the best pattern we have to describe the features for types of space rock. This matrix is a wired network.

We'll train our model to predict the rock type. We'll compare the rock features in a new image with the matrix pattern. Each time we run the model, the matrix grows and the prediction accuracy improves. Our goal is to test the model and achieve a prediction accuracy close to 100%.


## Create a neural network

Follow these steps to create a neural network for your AI model. Insert each new section of code into an empty cell in your Jupyter Notebook file. Select the green arrow at the top of the cell to run the new code.


### Detect the device type

We need to help your computer determine the most efficient way to create the deep learning network. First, we need to find the type of device you're using: CPU or GPU. The PyTorch APIs offer support to form a neural network according to the device type.

1. Open Visual Studio Code, and then open the Jupyter Notebook file that you created earlier.

   In the previous exercises, we used the Jupyter Notebook file *ClassifySpaceRockProgram.ipynb*.

1. Make sure you're running the correct Jupyter kernel. At the upper-right and lower-left corners of Visual Studio, change to the Anaconda environment `('myenv')` that you created earlier.

1. Add the following code in a new cell, and then run the cell.

   ```python
   # Determine if you're using a CPU or a GPU device to build the deep learning network
   device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
   model = models.resnet50(pretrained=True)
   ```


### Build neurons and wire the network

Let's add code to your Jupyter Notebook file to build the neurons and wire the network.

- Add the following code in a new cell, and then run the cell.

   ```python
   # Build all the neurons
   for param in model.parameters():
       param.requires_grad = False

   # Create the parameters of our deep learning model
   model.fc = nn.Sequential(nn.Linear(2048, 512),
                                 nn.ReLU(),
                                 nn.Dropout(0.2),
                                 nn.Linear(512, 2),
                                 nn.LogSoftmax(dim=1))
   criterion = nn.NLLLoss()
   optimizer = optim.Adam(model.fc.parameters(), lr=0.003)
   model.to(device)
   print('done')
   ```

The neural network goes back and forth many times until it learns the best associations (wiring) between features and rock types.

:::image type="content" source="../media/neural-network-training.gif" alt-text="Dynamic diagram that demonstrates how neural networks are created to train a learning model."  loc-scope="Azure":::
