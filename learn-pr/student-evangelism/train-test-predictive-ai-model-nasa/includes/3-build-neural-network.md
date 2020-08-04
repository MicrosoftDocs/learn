Now lets Build a neural network / deep network to learn the associations between features (curves, edges, texture, ...) and each rock type.

The idea of neural networks is very similar to how our brains work. The human brain consists of neurons or nerve cells which transmit and process the information received from our senses. Many such nerve cells are arranged together in our brain to form a network of nerves. These nerves pass electrical impulses i.e the excitation from one neuron to the other. Copy the code below to tell your computer the most efficient way to create this network.

```python
# Determine if you are using a CPU or GPU for building the deep learning network
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = models.resnet50(pretrained=True)
```

Neural networks have millions of neurons and nerves, to build a functional neural network we have to wire all of them together and we do that in 2 steps: 1. Build all the neurons 2. Wire the neurons in an appropriate way (there are 1000s of ways to wire the neurons)

```python
# the code below builds all the neurons
for param in model.parameters():
    param.requires_grad = False

# Parameters of our deep learning model
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

The Neural Network goes back and forth many times util it learns the best associations (wiring) between features and rock types

<img src="..\train-test-predictive-ai-model\media\dl.gif" width="650" align="center">