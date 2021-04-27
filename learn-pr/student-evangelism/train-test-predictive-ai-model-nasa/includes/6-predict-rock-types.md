Let's use our model to predict rock types. To predict the type of rock in a new image, we need to complete these steps:

- Step 1: Convert the new image to numbers using the `test_transforms` function you created to transform the images to the model
- Step 2: Transform the image. Crop and resize the image to 224 &times; 224 pixels using the `unsqueeze` and `Variables` functions
- Step 3: Extract the features and characteristics of the image by passing the image into the model
- Step 4: Predict the type of rock that's shown in the image by using the associations we learned in Step 2 by finding the highest probability prediction from the model's results



## Use the model to make predictions

Follow these steps to make predictions with the neural network in your AI model.

1. First, we load the neural network. Add the following code in a new cell in your Jupyter Notebook file, and then run the cell:

   ```python
   device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
   model=torch.load('aerialmodel.pth')
   ```

1. Next, we create a function to predict the type of rock in a new image by comparing it against our model's matrix pattern. Add the following code in a new cell in your Jupyter Notebook file, and then run the cell:


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

Now that you have defined the image prediction function, you can move onto the final exercise where you will call this function to make a prediction of what type of rock is shown in an image.
