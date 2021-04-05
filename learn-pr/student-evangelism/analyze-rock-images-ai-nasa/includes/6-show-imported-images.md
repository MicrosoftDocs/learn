Now we'll look at some of the images that we loaded into the computer. We'll give them labels to indicate what type of rock is in each photo.


## Add code to transform images

The following code reads images and assigns each one a rock type. The code is long, but it's not complex. It matches each rock image with a rock type, based on the image folder.

1. In Visual Studio Code, return to your Jupyter Notebook file.

1. Add the following code in a new cell. After you add the new code, run the cell.

   ```python
   # Transform an image into pixels and resize it
   test_transforms = transforms.Compose([transforms.RandomResizedCrop(224),
                                      transforms.Resize(224),
                                      transforms.ToTensor(),
                                    ])

   # Randomly select a set of images
   def get_random_images(num):
       data = datasets.ImageFolder(data_dir, transform=test_transforms)
       classes = data.classes
       indices = list(range(len(data)))
       np.random.shuffle(indices)
       idx = indices[:num]
       from torch.utils.data.sampler import SubsetRandomSampler
       sampler = SubsetRandomSampler(idx)
       loader = torch.utils.data.DataLoader(data, sampler=sampler, batch_size=num)
       dataiter = iter(loader)
       images, labels = dataiter.next()
       return images, labels
   ```

## Add code to show images

The following code actually shows you some images that you loaded into the program. We use the PIL library to manipulate the images, so they look appealing when we print them. We use the `plt.show` command to actually print the images.

- Add the following code in a new cell. After you add the new code, run the cell.

   ```python
   # Show five images - you can change this number
   images, labels = get_random_images(5)
   to_pil = transforms.ToPILImage()
   fig=plt.figure(figsize=(20,20))
   classes=trainloader.dataset.classes
   for ii in range(len(images)):
       image = to_pil(images[ii])
       sub = fig.add_subplot(1, len(images), ii+1)
       plt.axis('off')
       plt.imshow(image)
   plt.show()
   ```

After you run the cell, you should see five cleaned images in the output. The code is set to show five images, but you can change the number.
