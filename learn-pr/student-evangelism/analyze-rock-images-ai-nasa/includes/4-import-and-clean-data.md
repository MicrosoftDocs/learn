Now that we know about cleaning and separating the data, we can apply these principles to our rock classification project.


## Prepare the data

We need to create two datasets from the NASA photos for our classification project. One dataset is for training and the other is for testing. The images need to be cleaned and separated before we load them into datasets for processing. The data should be processed in a random manner, and not in the exact order it was provided by NASA.

We'll use code to accomplish these four steps to prepare our data:

- Step 1. **Get the data**: Tell the computer where to get the image data.
- Step 2. **Clean the data**: Crop the images to the same size.
- Step 3. **Separate the data**: Separate the data by shuffling and random selection.
- Step 4. **Load random datasets**: Prepare random samples for training and testing datasets.


### Step 1. Get the data

We need to let the computer know where it can find the data. In our example, we use the rock images provided by NASA. We already downloaded and stored the photos into the *Data* folder that's in the same project folder as our Jupyter Notebook file. We'll tell the computer to load the image data from the *Data* folder.


### Step 2. Clean the data

The rock photos from NASA come in different sizes: small, medium, and large. We'll crop the images so they're the same size (224 &times; 224 pixels). We resize the images because computers expect images to be the same size. If images vary in size, they're not as easy for the computer to process. We use the torchvision `transforms.Compose` class to resize the images to our preferred dimensions and store the modified images in local variables.


### Step 3. Separate the data

20% of the cleaned images are for training and the other 80% is for testing. The computer should pick images by random, and not use them in the exact order they were provided by NASA. We use two techniques to do the separation: shuffling and random selection.

We create an index list that corresponds to the number of images. We use this list to find the index of the image that represents 20% of the data. We store this location in a variable named `split`. We shuffle the index list, and by using the image location at `split`, we create our two datasets for training and testing. The resulting sets consist of images that are cleaned and are selected at random.

We use the `load_split_train_test` function to get the shuffled data for training and testing. 


### Step 4. Load random datasets

To load random images from our two datasets, we call the `SubsetRandomSampler` function from the torch.utils.data.sampler library. We'll load random samples of 16 images each.


## Add code to clean and separate the data

We're ready to add the code to clean and separate the data. 

1. In Visual Studio Code, return to your Jupyter Notebook file.

1. Add the following code in a new cell to import the **Python Imaging Library** (PIL). We'll use this library to visualize the images. After you add the new code, run the cell.

    ```python
    # Tell the machine what folder contains the image data
    data_dir = './Data'
    
    # Read the data, crop and resize the images, split data into two groups: test and train
    def load_split_train_test(data_dir, valid_size = .2):

        # Transform the images to train the model
        train_transforms = transforms.Compose([
                                           transforms.RandomResizedCrop(224),
                                           transforms.Resize(224),
                                           transforms.ToTensor(),
                                           ])
    
        # Transform the images to test the model
        test_transforms = transforms.Compose([transforms.RandomResizedCrop(224),
                                              transforms.Resize(224),
                                              transforms.ToTensor(),
                                          ])
    
        # Create two variables for the folders with the training and testing images
        train_data = datasets.ImageFolder(data_dir, transform=train_transforms)
        test_data = datasets.ImageFolder(data_dir, transform=test_transforms)
    
        # Get the number of images in the training folder
        num_train = len(train_data)
           
        # Create a list of numbers from 0 to the number of training images - 1
        # Example: For 10 images, the variable is the list [0,1,2,3,4,5,6,7,8,9]
        indices = list(range(num_train))
       
        # If valid_size is .2, find the index of the image that represents 20% of the data
        # If there are 10 images, a split would result in 2
        # split = int(np.floor(.2 * 10)) -> int(np.floor(2)) -> int(2) -> 2
        split = int(np.floor(valid_size * num_train))
           
        # Randomly shuffle the indices
        # For 10 images, an example would be that indices is now the list [2,5,4,6,7,1,3,0,9,8]
        np.random.shuffle(indices)
           
        from torch.utils.data.sampler import SubsetRandomSampler
           
        # With the indices randomly shuffled, 
        # grab the first 20% of the shuffled indices, and store them in the training index list
        # grab the remainder of the shuffled indices, and store them in the testing index list
        # Given our example so far, this would result is:
        # train_idx is the list [1,5] 
        # test_idx is the list [4,6,7,1,3,0,9,8]
        train_idx, test_idx = indices[split:], indices[:split]
       
        # Create samplers to randomly grab items from the training and testing indices lists
        train_sampler = SubsetRandomSampler(train_idx)
        test_sampler = SubsetRandomSampler(test_idx)
           
        # Create loaders to load 16 images from the train and test data folders
        # Images are chosen based on the shuffled index lists and by using the samplers
        trainloader = torch.utils.data.DataLoader(train_data, sampler=train_sampler, batch_size=16)
        testloader = torch.utils.data.DataLoader(test_data, sampler=test_sampler, batch_size=16)
           
        # Return the loaders so you can grab images randomly from the training and testing data folders
        return trainloader, testloader

    # Using the function that shuffles images,
    # create a trainloader to load 20% of the images
    # create a testloader to load 80% of the images
    trainloader, testloader = load_split_train_test(data_dir, .2)
    
    # Print the type of rocks that are included in the trainloader
    print(trainloader.dataset.classes)
    ```

After you run the cell, you should see the two rock classification types in the output: `['Basalt', 'Highland']`.

The space rock data is now imported, cleaned, and separated. We're ready to train our model with 80% of the data and run tests with the remaining 20%.
