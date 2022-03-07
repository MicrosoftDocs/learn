You're finally ready to test your complete AI model! Let's see how well your model can predict the correct rock type.

We start by telling the computer to select five images by random for the first test. You can choose any number of images to test. After the first test, we'll run the code again with more images.

We use the data from the `trainloader` variable again, and pass each image to our functions to extract rock features from the photo. The computer compares the features to the patterns recognized by the model. With that information, the model predicts the type of rock in the photo. The last step is to use the `plt` function to plot a graph of our prediction results.


## Predict rock types in random images

Follow these steps to test the prediction accuracy of the neural network in your AI model.

1. Add the following code in a new cell in your Jupyter Notebook file, and then run the cell:

   ```python
   # Get five random images and display them in a figure with their labels
   to_pil = transforms.ToPILImage()
   images, labels = get_random_images(5)
   fig=plt.figure(figsize=(20,10))

   # Load all of the classes from the training loader
   classes=trainloader.dataset.classes

   # Loop through the 5 randomly selected images
   for ii in range(len(images)):

       # Predict the class of each image
       image = to_pil(images[ii])
       index = predict_image(image)
       
       # Add the class to the plot graph to display beneath the image
       sub = fig.add_subplot(1, len(images), ii+1)
       res = int(labels[ii]) == index
       sub.set_title(str(classes[index]) + ":" + str(res))
       plt.axis('off')
       plt.imshow(image)

   # Reshow the plot with the predicted labels beneath the images
   plt.show()
   ```

   This code creates a visual of the images with labels to show the actual type of rock and the model prediction: True or False. The prediction shows whether your AI system correctly classified the type of rock.

   :::image type="content" source="../media/test-model-prediction-accuracy.png" alt-text="Screenshot of the Jupyter Notebook file code and cell run output in Visual Studio Code."  loc-scope="Azure":::


1. Try another test. In the cell that you added in the previous step, change the number of images to test to **10**, and then run the cell again:

   ```python
   ...
   images, labels = get_random_images(10)
   ...
   ```

   Do you notice any improvement in the accuracy?

1. Enter Ctrl + S to save the changes to your Jupyter Notebook file.


Congratulations! You've successfully built a working neural network to predict the type of an object in an image. You have an AI model that classifies types of Moon rocks collected by NASA. 

Artificial intelligence combines large amounts of data with creative ways of understanding, classifying, and contextualizing. Scientists use AI to help improve their analysis and reach correct conclusions. If you have the opportunity to become an expert on space rocks, you can learn how to classify images of rocks, eventually. When you use AI in your research, you gain from the expertise of scientists who have already been to the Moon, and back!
