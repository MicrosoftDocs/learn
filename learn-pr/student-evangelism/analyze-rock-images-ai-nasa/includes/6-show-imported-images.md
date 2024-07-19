Now we'll look at some of the images that we loaded into the computer. We'll give them labels to indicate what type of rock is in each photo.


## Transform and display the images

In this section, we'll add code to match each rock image with a rock type, based on the image folder. We call the `transforms.Compose` class again to transform each image into pixels and resize it to our preferred dimensions.

We select a set of images by random in a manner similar to how we used the `load_split_train_test` and `SubsetRandomSampler` functions in the last exercise. The code iterates over the shuffled images in the testing dataset.

The last section of code displays the images that are loaded into the program. We use functions from the PIL library to manipulate the images, and the `plt.show` command to print them.


## Add code to transform and select random images

We're ready to add the code to transform the images. 

1. In Visual Studio Code, return to your Jupyter Notebook file.

1. Add the following code in a new cell. After you add the new code, run the cell.

   ```python
   # Transform an image into pixels and resize it
   test_transforms = transforms.Compose([transforms.RandomResizedCrop(224),
                                      transforms.Resize(224),
                                      transforms.ToTensor(),
                                    ])

   # Randomly select a set of images by using a similar approach as the load_split_train_test function
   def get_random_images(num):
       data = datasets.ImageFolder(data_dir, transform=test_transforms)
       classes = data.classes
       indices = list(range(len(data)))
       np.random.shuffle(indices)
       idx = indices[:num]
       from torch.utils.data.sampler import SubsetRandomSampler
       sampler = SubsetRandomSampler(idx)
       loader = torch.utils.data.DataLoader(data, sampler=sampler, batch_size=num)

       # Create an iterator to iterate over the shuffled images in the test image dataset
       dataiter = iter(loader)

       # Get and return the images and labels from the iterator
       images, labels = next(dataiter)
       return images, labels
   ```


## Add code to show randomly selected images

Follow these steps to add the code to display the images. 

1. Add the following code in a new cell. After you add the new code, run the cell.

   ```python
   # Show five images - you can change this number
   images, labels = get_random_images(5)

   # Convert the array of pixels to an image
   to_pil = transforms.ToPILImage()
   fig=plt.figure(figsize=(20,20))

   # Get a list of all classes in the training data
   classes=trainloader.dataset.classes

   # Draw the images in a plot to display in the notebook
   for ii in range(len(images)):
       image = to_pil(images[ii])
       sub = fig.add_subplot(1, len(images), ii+1)
       plt.axis('off')
       plt.imshow(image)

   # Display all of the images 
   plt.show()
   ```

1. Enter Ctrl + S to save the changes to your Jupyter Notebook file.

After you run this new code, you should see five cleaned images in the output. The code is set to show five images, but you can change the number.


&nbsp;
***

### Next steps

Continue to the next module in this Learning path and discover how to [classify types of space rocks in random photos with AI][ClassifyImages].


> [!Important]
> If you plan to continue to the next module in this Learning path, leave your Anacoda prompt open and your Jupyter Notebook file open in Visual Studio Code.
> If you close these applications, or plan to work on the module exercises across multiple sessions, you'll have to reopen the tools and reconfigure your working environment to continue your model development.
>


<!-- Links -->

[ClassifyImages]: /training/modules/train-test-predictive-ai-model-nasa/?azure-portal=true
