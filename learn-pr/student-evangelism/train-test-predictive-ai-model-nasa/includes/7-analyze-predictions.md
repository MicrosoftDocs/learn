Let's pick five random images and see whether our model can tell what type of rock it is.

The following code gets five random images and stores their data in variables. We use five images to test our AI system, but you can choose any number. After you run the following code, change the number to 10, and then run the code again.

```python
images, labels = get_random_images(5)
```

This code visualizes the new images and adds captions that indicate what type of rock the model determines the photo contains.

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

The example images are labeled *Actual Rock Type: True / False*.

*True* and *False* indicate whether our AI system correctly classified the rock in an image.
