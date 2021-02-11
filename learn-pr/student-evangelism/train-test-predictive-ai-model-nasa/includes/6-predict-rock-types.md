Let's predict rock types. To predict the type of rock that's shown in a new image, we need to complete the following steps:

1. Convert the new image to numbers.
2. Transform the image: crop and resize it to 224 &times; 224 pixels.
3. Extract the features and characteristics of the image.
4. Predict the type of rock that's shown in the image by using the associations we learned in step 2.

The following code loads our neural network:

```python
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model=torch.load('aerialmodel.pth')
```

This code creates a function that predicts the new image type:

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
