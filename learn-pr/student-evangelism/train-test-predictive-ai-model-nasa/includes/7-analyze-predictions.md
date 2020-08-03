Lets pick 5 random images and see if our model can tell what type of rock it is:

The code below will get 5 random images and store their data in variables. We choose 5 for this example, but you could have any number in there. It just says how many images we are going to test. After you run the code, try to switch the number to 10.

```python
images, labels = get_random_images(5)
```

This code will visualize the new images and add captions for what type of rock the model thinks the picture is.

```python
to_pil = transforms.ToPILImage()
images, labels = get_random_images(5)
fig=plt.figure(figsize=(20,10))

classes=trainloader.dataset.classes
for ii in range(len(images)):
    image = to_pil(images[ii])
    index = predict_image(image)
    sub = fig.add_subplot(1, len(images), ii+1)
    res = int(labels[ii]) == index
    sub.set_title(str(classes[index]) + ":" + str(res))
    plt.axis('off')
    plt.imshow(image)
plt.show()
```

The example images above are labeled as
Actual Rock Type : True / False

Where True and False show if our AI system correctly classified it or not.
