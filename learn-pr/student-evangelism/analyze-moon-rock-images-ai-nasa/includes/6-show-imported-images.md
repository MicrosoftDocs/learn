Now that we have read the images into the computer, let's check out a few of them and give them labels as to what type of rock they are.

This code block will read the images and then assign each image with its corresponding rock type. The code looks long, but this is just because it needs to match each rock picture with what type of rock it is from which folder it comes from.

```python
#transform the new image into numbers and resize it
test_transforms = transforms.Compose([transforms.RandomResizedCrop(224),
                                      transforms.Resize(224),
                                      transforms.ToTensor(),
                                    ])

#function to randomly select a number of images
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

This bit of code will actually show you some images that you have loaded into the program:

```python
# how many images you want to see? set to 5 but can be changed
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

We are using the PIL library here to manipulate the images so they look pretty when we print them out. We use the `plt.show` to actually output the images.
