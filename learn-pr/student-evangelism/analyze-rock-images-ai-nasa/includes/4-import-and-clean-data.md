Now that we know about cleaning and separating the data, we can apply these principles to our rock classification project.

We'll start by downloading all the data we have about rock images. We'll put the data in the same folder as our Jupyter Notebook file.

The rock photos in our data set come in different sizes: small, medium, and large. We'll crop the images so they're the same size (224 &times; 224 pixels). We resize the images because computers expect images to be the same size. If images vary in size, they're not as easy for the computer to process.

## Add code to clean and separate the data

We're ready to add the code to clean and separate the data. First, we'll resize the images. Then, we'll separate the data into two variables for training and testing: `trainloader` and `testloader`.

1. Go to [this Azure Blob storage][AzureBlob] and download the *Data.zip* folder.

1. Unzip the *Data* folder and put it in the same folder as your Jupyter Notebook file.

1. In Visual Studio Code, return to your Jupyter Notebook file.

1. Add the following code in a new cell to import the **Python Imaging Library** (PIL). We'll use this library to visualize the images. After you add the new code, run the cell.

   ```python
   # Tell the machine what folder contains the image data
   data_dir = './Data'

   # Read the data, crop and resize the images, split data into two groups: test and train
   def load_split_train_test(datadir, valid_size = .2):

       # Transform the images you will use to train the model
       train_transforms = transforms.Compose([
                                       transforms.RandomResizedCrop(224),
                                       transforms.Resize(224),
                                       transforms.ToTensor(),
                                       ])

       # Transform the images you will use to test the model
       test_transforms = transforms.Compose([transforms.RandomResizedCrop(224),
                                          transforms.Resize(224),
                                          transforms.ToTensor(),
                                      ])

       # Create two variables that point to the folders where the training and testing images are located
       train_data = datasets.ImageFolder(datadir, transform=train_transforms)
       test_data = datasets.ImageFolder(datadir, transform=test_transforms)

       # Get the number of images in the training folder
       num_train = len(train_data)
       
       # Create a list of numbers from 0 to the number of training images-1. 
       # So if there are 10 images, this variable would be a list [0,1,2,3,4,5,6,7,8,9]
       indices = list(range(num_train))
       
       # If valid_size is .2, then find the index of the image that would represent 20% of the data
       # If there are 10 images, split would result in 2
       # split = int(np.floor(.2 * 10)) -> int(np.floor(2)) -> int(2) -> 2
       split = int(np.floor(valid_size * num_train))
       
       # Randomly shuffle the indices
       # If there were 10 images, and example would be that 
       # indices is now a list [2,5,4,6,7,1,3,0,9,8]
       np.random.shuffle(indices)
       
       from torch.utils.data.sampler import SubsetRandomSampler
       
       # With the indices randomly shuffled, 
       # grab the first 20% of the shuffled indices and store them in the training index list
       # grab the remainder of the shuffled indices and store them in the testing index list
       # Given our example so far, this would result in train_idx being the list [1,5] 
       # and test_idx being the list [4,6,7,1,3,0,9,8]
       train_idx, test_idx = indices[split:], indices[:split]
       
       # Create samplers, which will randomly grab items from the trainign and testing indices lists
       train_sampler = SubsetRandomSampler(train_idx)
       test_sampler = SubsetRandomSampler(test_idx)
       
       # Create loaders that will actually load 16 images from the train and test data folder.
       # Images are chosen based on the shuffled index lists and using the samplers
       trainloader = torch.utils.data.DataLoader(train_data, sampler=train_sampler, batch_size=16)
       testloader = torch.utils.data.DataLoader(test_data, sampler=test_sampler, batch_size=16)
       
       # Return the loaders so that you can grab images randomly within the training and testing data folders
       return trainloader, testloader

   # Using the function written above that shuffles the images,
   # Create a trainloader that will load in 20% of the images
   # Create a testloader that will load in 80% of the images
   trainloader, testloader = load_split_train_test(data_dir, .2)
   # Print the type of rocks that are included in the trainloader
   print(trainloader.dataset.classes)
   ```

After you run the cell, you should see the two rock classification types in the output: `['Basalt', 'Highland']`.

The space rock data is now imported, cleaned, and separated. We're ready to train our model with 80% of the data and run tests with the remaining 20%.

<!-- Links -->
[AzureBlob]: https://nasadata.blob.core.windows.net/nasarocks/Data.zip?azure-portal=true
