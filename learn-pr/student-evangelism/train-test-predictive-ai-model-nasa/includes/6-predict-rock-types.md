Let's use our model to predict rock types. To predict the type of rock in a new image, we need to complete these steps:

- Step 1: Convert the new image to numbers.
- Step 2: Transform the image. Crop and resize the image to 224 &times; 224 pixels.
- Step 3: Extract the features and characteristics of the image.
- Step 4: Predict the type of rock that's shown in the image by using the associations we learned in Step 2.


> [!Note]
> **Sarah ToDo**
> - Describe the APIs used in this unit


## Use the model to make predictions

Follow these steps to make predictions with the neural network in your AI model.

1. First, we load the neural network. Add the following code in a new cell in your Jupyter Notebook file, and then run the cell:

   ```python
   device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
   model=torch.load('aerialmodel.pth')
   ```

1. Next, we create a function to predict the type of rock in a new image by comparing it against our model's matrix pattern. Add the following code in a new cell in your Jupyter Notebook file, and then run the cell:

   > [!Note]
   > **Sarah - ToDo**
   > - Add comments to the code.
   > 

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

   > [!Note]
   > **Sarah ToDo**
   > - These commands produce no output, so there's no indication that anything happened or is happening.
   > Could we add more detail here?

