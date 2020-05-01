## Load the dataset

The first step is to import facial images from the dataset. LFW contains more than 13,000 facial images collected from the web. Of the more than 5,000 people represented in the dataset, 1,680 have two or more facial images, while only five have 100 or more. We'll set the minimum number of faces per person to 100, which means that five sets of faces corresponding to five famous people will be imported. Each facial image is labeled with the name of the person that the face belongs to.

```python
import numpy as np
import pandas as pd
from sklearn.datasets import fetch_lfw_people

faces = fetch_lfw_people(min_faces_per_person=100)
print(faces.target_names)
print(faces.images.shape)
```

The output is:

```Output
['Colin Powell' 'Donald Rumsfeld' 'George W Bush' 'Gerhard Schroeder'
 'Tony Blair']
(1140, 62, 47)
```

In total, 1,140 facial images were loaded. Each image measures 62 &times; 47 pixels, for a total of 2,914 pixels per image. That basically means we're working with a model with 2,914 feature columns. That's a lot of columns! Let's check the balance in our dataset by generating a histogram that shows how many facial images were imported for each of the five persons:

```python
%matplotlib inline
import matplotlib.pyplot as plt
from collections import Counter
import seaborn as sns
sns.set()

counts = Counter(faces.target)
names = {}

for key in counts.keys():
    names[faces.target_names[key]] = counts[key]

df = pd.DataFrame.from_dict(names, orient='index')
df.plot(kind='bar')
```

The output is:

```Output
<matplotlib.axes._subplots.AxesSubplot at 0x7f0ed8e65f60>
```

:::image type="content" alt-text="Two diagrams that show 2-D and 3-D data planes" source="../media/lfw.png" loc-scope="Azure":::


The dataset is not very well balanced, but that's not terribly concerning because the net effect will probably be that the model is better at recognizing certain people than others. Let's plot some of the facial images so we can see what they look like:

```python
fig, ax = plt.subplots(3, 8, figsize=(18, 10))
for i, axi in enumerate(ax.flat):
    axi.imshow(faces.images[i], cmap='gist_gray')
    axi.set(xticks=[], yticks=[], xlabel=faces.target_names[faces.target[i]])
```

Here's the output:

:::image type="content" alt-text="A panel of 24 greyscale photos of five famous political leaders" source="../media/faces.png" loc-scope="Azure":::

## Train an SVM model

The next task is to train an SVM model to do image classification using the faces in the dataset. Let's start by splitting the dataset so that 80% can be used for training and 20% can be used for testing.

```python
from sklearn.model_selection import train_test_split

x_train, x_test, y_train, y_test = train_test_split(faces.data, faces.target, train_size=0.8, random_state=42)
```

Now let's create an SVM classifier and train it using the 80% of the dataset reserved for training.

```python
from sklearn.svm import SVC

model = SVC(class_weight='balanced', gamma='auto')
model.fit(x_train, y_train)
```

```Output
SVC(C=1.0, cache_size=200, class_weight='balanced', coef0=0.0,
  decision_function_shape='ovr', degree=3, gamma='auto', kernel='rbf',
  max_iter=-1, probability=False, random_state=None, shrinking=True,
  tol=0.001, verbose=False)
```

Next, let's use the 20% of the dataset set aside for testing to assess the accuracy of the model.

```python
model.score(x_test, y_test)
```

The output is `0.4649122807017544`.
```

That's not very encouraging, but we're far from done.

SVM can use several types of kernels to fit a mathematical model to a dataset. The default kernel type is one called the [radial-basis function (RBF)](https://wikipedia.org/wiki/Radial_basis_function?azure-portal=true), which scikit-learn abbreviates _rbf_. You can specify the kernel type with the SVC function's `kernel` parameter. Other common values include _linear_, _poly_, and _sigmoid_. It could be that another kernel type would fit the data better. But there's something else that might help, too. That "something else" is [principal component analysis (PCA)](https://wikipedia.org/wiki/Principal_component_analysis?azure-portal=true).


