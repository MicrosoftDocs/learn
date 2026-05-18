Training CNNs can take a substantial amount of time and a large quantity of data is required for that task. Much of the time is spent experimenting to find the best low-level filters that a network needs to extract patterns from the images. A natural question arises - can we use a neural network trained on one dataset and adapt it to classifying different images without full training process?

This approach is called **transfer learning**, because we transfer some knowledge from one neural network model to another. In transfer learning, we typically start with a pretrained model, which has been trained on some large image dataset, such as **ImageNet**. Those models already do a good job extracting different features from generic images, and in many cases just building a classifier on top of those extracted features can yield a good result.

```python
import tensorflow as tf
import keras
import matplotlib.pyplot as plt
import numpy as np
import os
import glob
from PIL import Image
```

## Cats vs. dogs dataset

In this unit, we'll solve a real-life problem of classifying images of cats and dogs. For this reason, we'll use [Kaggle Cats vs. Dogs Dataset](https://www.kaggle.com/c/dogs-vs-cats), which can also be downloaded [from Microsoft](https://www.microsoft.com/download/details.aspx?id=54765).

Let's download this dataset and extract it into the `data` directory:

```python
import urllib.request
import zipfile

dataset_url = 'https://download.microsoft.com/download/3/E/1/3E1C3F21-ECDB-4869-8368-6DEBA77B919F/kagglecatsanddogs_5340.zip'
data_dir = 'data'

os.makedirs(data_dir, exist_ok=True)
zip_path = os.path.join(data_dir, 'kagglecatsanddogs_5340.zip')
if not os.path.exists(zip_path):
    urllib.request.urlretrieve(dataset_url, zip_path)
if not os.path.exists(os.path.join(data_dir, 'PetImages')):
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(data_dir)
```

The dataset may contain a few corrupt image files. Let's define a helper function to check and remove them before loading:

```python
def check_image(fn):
    try:
        im = Image.open(fn)
        im.verify()
        return True
    except (IOError, SyntaxError):
        return False

def check_image_dir(dir_path):
    for fn in glob.glob(dir_path):
        if not check_image(fn):
            print(f"Corrupt image: {fn}")
            os.remove(fn)

# Remove any corrupt images from the dataset
check_image_dir('data/PetImages/Cat/*.jpg')
check_image_dir('data/PetImages/Dog/*.jpg')
```

## Loading the dataset

In the previous examples, we were loading datasets that are built into Keras. Now we'll use our own dataset, which we need to load from a directory of images. Keras includes a helper function `image_dataset_from_directory` that can create a `tf.data.Dataset` from a directory of images organized into subdirectories by class.

```python
data_dir = 'data/PetImages'
batch_size = 32

ds_train = keras.utils.image_dataset_from_directory(
    data_dir,
    validation_split=0.2,
    subset='training',
    seed=13,
    image_size=(224, 224),
    batch_size=batch_size
)

ds_test = keras.utils.image_dataset_from_directory(
    data_dir,
    validation_split=0.2,
    subset='validation',
    seed=13,
    image_size=(224, 224),
    batch_size=batch_size
)
```

> [!NOTE]
> We use the same `seed` value when creating the training and validation splits to ensure no overlap between the two subsets.

We can check the class names that were automatically inferred from the directory structure:

```python
# Expected output: ['Cat', 'Dog']
ds_train.class_names
```

Let's define a helper to visualize samples from our dataset (this is a new version of `display_dataset` tailored for batched data):

```python
def display_dataset(images, labels, classes=None, cols=8):
    n = len(images)
    rows = (n + cols - 1) // cols
    fig, axes = plt.subplots(rows, cols, figsize=(cols * 1.5, rows * 1.5))
    axes = axes.flatten() if n > 1 else [axes]
    for i, ax in enumerate(axes):
        if i < n:
            ax.imshow(images[i])
            label = int(labels[i][0]) if labels[i].ndim > 0 else int(labels[i])
            title = classes[label] if classes else str(label)
            ax.set_title(title, fontsize=8)
        ax.axis('off')
    plt.tight_layout()
    plt.show()
```

The dataset yields batches of images and labels. Each batch contains 32 images of size 224×224 with 3 color channels, and corresponding labels:

```python
for x, y in ds_train:
    print(f"Training batch shape: features={x.shape}, labels={y.shape}")
    x_sample, y_sample = x, y
    break

# Expected output: Training batch shape: features=(32, 224, 224, 3), labels=(32,)
display_dataset(x_sample.numpy().astype(np.uint8), np.expand_dims(y_sample, 1), classes=ds_train.class_names)
```

> [!NOTE]
> The image pixel values are in the 0-255 range. Some models require input to be scaled to 0-1 or preprocessed using a model-specific function. VGG-16 has its own `preprocess_input` function that we use later.

## Pretrained models

There are many pretrained neural networks for image classification that have been trained on the ImageNet dataset, which contains more than 14 million images across 1,000 categories. One of the most well-known architectures is **VGG-16**, which achieves good accuracy while being simple to understand. Let's load a VGG-16 model with pretrained weights:

```python
vgg = keras.applications.VGG16()
```

Let's try using this pretrained network to classify one of our images. The VGG-16 network was trained on ImageNet, which includes categories for various dog and cat breeds:

```python
inp = keras.applications.vgg16.preprocess_input(x_sample[:1])
res = vgg(inp)

# tf.argmax returns the index of the highest-probability class
print(f"Most probable class = {tf.argmax(res, 1)}")

# decode_predictions maps class indices to human-readable labels
keras.applications.vgg16.decode_predictions(res.numpy())
```

The `preprocess_input` function scales pixel values appropriately for the VGG-16 model. The `decode_predictions` function returns the top-5 most probable ImageNet classes along with their confidence scores.

Let's see the architecture of VGG-16:

```python
# Shows all layers including convolutional blocks and final Dense classifier
vgg.summary()
```

## GPU computations

Deep neural networks require quite substantive computational power for training. Using a GPU can significantly speed up the training process. Let's check whether a GPU is available:

```python
# Lists available GPU devices; an empty list means CPU-only
tf.config.list_physical_devices('GPU')
```

## Extracting VGG features

If we want to use VGG-16 to extract features from our images, we need the model without the final classification layers. We can do this by specifying `include_top=False`:

```python
vgg = keras.applications.VGG16(include_top=False)
inp = keras.applications.vgg16.preprocess_input(x_sample[:1])
res = vgg(inp)

# The output is a 7x7 grid of 512 feature maps
print(f"Shape after applying VGG-16: {res[0].shape}")
plt.figure(figsize=(15, 3))
plt.imshow(res[0].numpy().reshape(-1, 512))
```

The resulting feature vector has shape 7×7×512 = 25088 values. This represents the high-level features that VGG-16 has learned to extract from the image. We can manually precompute these features for our entire dataset and then train a classifier on top:

> [!WARNING]
> We use `.take(25)` and `.take(10)` below to limit the dataset size for faster training in this example. Each batch contains 32 images, so we're using only 800 training images and 320 test images. The ~90% accuracy reported here reflects this small subset and may not generalize to the full dataset. For production use, train on the complete dataset.

```python
def preprocess(x, y):
    return keras.applications.vgg16.preprocess_input(x), y

ds_features_train = ds_train.take(25).map(preprocess).map(lambda x, y: (vgg(x), y)).cache()
ds_features_test = ds_test.take(10).map(preprocess).map(lambda x, y: (vgg(x), y)).cache()

for x, y in ds_features_train:
    # Expected output: (32, 7, 7, 512) (32,)
    print(x.shape, y.shape)
    break
```

> [!NOTE]
> We call `.cache()` after extracting features so that the VGG-16 model only runs once per batch instead of every epoch.

Now we can build a simple classifier on the extracted features. Since the VGG features are already highly informative, even a single Dense layer can achieve good results:

```python
model = keras.Sequential([
    keras.layers.Input(shape=(7, 7, 512)),
    keras.layers.Flatten(),
    keras.layers.Dense(1, activation='sigmoid')
])

model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])
hist = model.fit(ds_features_train, validation_data=ds_features_test)

# Expected: validation accuracy around 90%
```

With around 90% accuracy, this demonstrates the power of pretrained features! However, manually precomputing features is cumbersome.

## Transfer learning using one VGG network

We can avoid manually precomputing features by combining the VGG-16 feature extractor and our classifier into a single network. The key is to **freeze** the pretrained layers so their weights aren't updated during training.

We move the `preprocess_input` step into the data pipeline rather than embedding it in the model as a `Lambda` layer. This keeps the model serializable so we can save and load it later:

```python
def preprocess(x, y):
    return keras.applications.vgg16.preprocess_input(x), y

ds_train_preprocessed = ds_train.map(preprocess)
ds_test_preprocessed = ds_test.map(preprocess)
```

> [!NOTE]
> Because preprocessing is now part of the data pipeline rather than the model, you must also apply `preprocess_input` to input data at inference time.

Now we build the model with the frozen VGG-16 base:

```python
vgg_base = keras.applications.VGG16(include_top=False, input_shape=(224, 224, 3))
vgg_base.trainable = False

model = keras.Sequential([
    keras.layers.Input(shape=(224, 224, 3)),
    vgg_base,
    keras.layers.Flatten(),
    keras.layers.Dense(1, activation='sigmoid')
])

# Notice: ~15 million params are non-trainable (VGG-16), only ~25k are trainable
model.summary()
```

By freezing the VGG-16 layers, we only need to train the final Dense layer, which has roughly 25,000 parameters instead of the full 15 million. This makes training faster:

> [!WARNING]
> As with the previous section, we use `.take(50)` and `.take(10)` to limit the dataset for faster training. This means we're training on approximately 1,600 images and validating on 320. Accuracy results may differ when training on the full dataset.

```python
model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])
hist = model.fit(ds_train_preprocessed.take(50), validation_data=ds_test_preprocessed.take(10))

# Expected: validation accuracy around 90% or higher
```

## Saving and loading the model

Once we have a trained model, we can save it to disk and reload it later without retraining:

```python
model.save('data/cats_dogs.keras')
```

> [!NOTE]
> The `.keras` extension uses the native Keras 3 format. If you're using an older version of TensorFlow/Keras, use `.h5` (HDF5 format) or the SavedModel directory format instead.

To load the saved model:

```python
model = keras.models.load_model('data/cats_dogs.keras')
```

## Other computer vision models

VGG-16 is one of the simplest deep CNN architectures to understand, due to its uniform structure of stacked 3×3 convolutions. Keras provides many more pretrained networks. The most frequently used ones among those are **ResNet** architectures, developed by Microsoft, and **Inception** by Google.

## Improving results with data augmentation

When working with limited training data, **data augmentation** can significantly improve generalization. By applying random transformations (such as horizontal flips, rotations, and zooms) to training images, we artificially increase the diversity of the dataset. Keras provides augmentation layers like `keras.layers.RandomFlip`, `keras.layers.RandomRotation`, and `keras.layers.RandomZoom` that can be added directly to your model or data pipeline.

## Takeaway

With transfer learning we were able to quickly put together a classifier for our custom object classification task and achieve high accuracy. This example wasn't completely fair because the original VGG-16 network was pretrained on ImageNet, which already includes categories for various cat and dog breeds, and thus we were just reusing most of the patterns that were already present in the network. You can expect lower accuracy for other domain-specific objects, such as details on a production line in a plant or different tree leaves. You can see that more complex tasks require higher computational power and often benefit from GPU acceleration for training.
