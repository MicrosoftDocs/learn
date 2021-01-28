Now that we know about cleaning and separating the data, we can actually apply these principles to our rock classification project.

Let's start by downloading all the data we have about rock images. Then, we'll put it in the same folder as your Jupyter Notebook file. Go to [this Azure Blob storage](https://nasadata.blob.core.windows.net/nasarocks/Data.zip?azure-portal=true) and download the *Data.zip* folder. Unzip it and put it in the same folder as your Jupyter Notebook file.

Because our photos of rocks come in different sizes (small, medium, and large), we crop the images so that they are the same size (224 &times; 224 pixels). We resize the images because computers expect images to be same size. If images vary in size, they're not as easy for the computer to process.

We resize the images in the first part of the code. At the bottom of the code, you can see that we separate the data into a training variable and a testing variable.

```python
# Tells the machine what folder contains the image data.
data_dir = './data'

# Function to read the data; crop and resize the images; and then split it into test and train chunks.
def load_split_train_test(datadir, valid_size = .2):
    # This line of code transforms the images.
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

# We're using 20% of data for testing.
trainloader, testloader = load_split_train_test(data_dir, .2)
print(trainloader.dataset.classes)
```
