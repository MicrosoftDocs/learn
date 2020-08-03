Lets predict the rock types
To predict the type of a new rock image, we need to the following:

1. Convert the new image into numbers
2. Transform it (Crop and resize to 224*224)
3. Extract features and characteristics of the image
4. Predict its type using the associations we have learned in step 2.

The code below will load in the neural network that we built in the previous step:

```python
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model=torch.load('aerialmodel.pth')
```

Next, this code will make a function that predicts the new image type:

```python
def predict_image(image):
    image_tensor = test_transforms(image).float()
    image_tensor = image_tensor.unsqueeze_(0)
    input = Variable(image_tensor)
    input = input.to(device)
    output = model(input)
    index = output.data.cpu().numpy().argmax()
    return index
```
