Now, let's build a neural network/deep learning network to learn the associations between features (for example, curves, edges, and texture) and each rock type.

The way a neural network works is very similar to how our brains work. The human brain consists of neurons or nerve cells that transmit and process information it receives from our senses. Many of the nerve cells are arranged together to form a network of nerves in our brain. The nerves pass electrical impulses from one neuron to next neuron.

Run the following code to tell your computer the most efficient way to create a neural network:

```python
# Determine whether you're using a CPU or a GPU to build the deep learning network.
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = models.resnet50(pretrained=True)
```

Neural networks have millions of neurons and nerves. To build a functional neural network, we wire them together in two steps:

1. Build all the neurons.
2. Wire the neurons in an appropriate way (there are thousands of ways to wire neurons).

```python
# Builds all the neurons.
for param in model.parameters():
    param.requires_grad = False

# The parameters of our deep learning model.
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
