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
   data_dir = './data'

   # Read the data, crop and resize the images, split data into two groups: test and train
   def load_split_train_test(datadir, valid_size = .2):

       # Transform the images
       train_transforms = transforms.Compose([
                                       transforms.RandomResizedCrop(224),
                                       transforms.Resize(224),
                                       transforms.ToTensor(),
                                       ])

       test_transforms = transforms.Compose([transforms.RandomResizedCrop(224),
                                          transforms.Resize(224),
                                          transforms.ToTensor(),
                                      ])

       train_data = datasets.ImageFolder(datadir, transform=train_transforms)
       test_data = datasets.ImageFolder(datadir, transform=test_transforms)

       num_train = len(train_data)
       indices = list(range(num_train))
       split = int(np.floor(valid_size * num_train))
       np.random.shuffle(indices)
       from torch.utils.data.sampler import SubsetRandomSampler
       train_idx, test_idx = indices[split:], indices[:split]
       train_sampler = SubsetRandomSampler(train_idx)
       test_sampler = SubsetRandomSampler(test_idx)
       trainloader = torch.utils.data.DataLoader(train_data, sampler=train_sampler, batch_size=16)
       testloader = torch.utils.data.DataLoader(test_data, sampler=test_sampler, batch_size=16)
       return trainloader, testloader

   # Use 20% of the data for testing
   trainloader, testloader = load_split_train_test(data_dir, .2)
   print(trainloader.dataset.classes)
   ```

After you run the cell, you should see the two rock classification types in the output: `['Basalt', 'Highland']`.

The space rock data is now imported, cleaned, and separated. We're ready to train our model with 80% of the data and run tests with the remaining 20%.

<!-- Links -->
[AzureBlob]: https://nasadata.blob.core.windows.net/nasarocks/Data.zip?azure-portal=true
