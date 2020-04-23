Load the dataset
The first step is to import facial images from the dataset. LFW contains more than 13,000 facial images collected from the Web. Of the more than 5,000 people represented in the dataset, 1,680 have two or more facial images, while only five have 100 or more. We'll set the minimum number of faces per person to 100, which means that five sets of faces corresponding to five famous people will be imported. Each facial image is labeled with the name of the person that the face belongs to.

In [1]:
import numpy as np
import pandas as pd
from sklearn.datasets import fetch_lfw_people

faces = fetch_lfw_people(min_faces_per_person=100)
print(faces.target_names)
print(faces.images.shape)
['Colin Powell' 'Donald Rumsfeld' 'George W Bush' 'Gerhard Schroeder'
 'Tony Blair']
(1140, 62, 47)
In total, 1,140 facial images were loaded. Each image measures 62 by 47 pixels for a total of 2,914 pixels per image. That basically means we're working with a model with 2,914 feature columns. That's a lot of columns! Let's check the balance in our dataset by generating a histogram showing how many facial images were imported for each of the five persons.

In [2]:
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
Out[2]:
<matplotlib.axes._subplots.AxesSubplot at 0x7f0ed8e65f60>
The dataset is not very well balanced, but that's not terribly concerning because the net effect will probably be that the model is better at recognizing certain people than others. Let's plot some of the facial images so we can see what they look like.

In [3]:
fig, ax = plt.subplots(3, 8, figsize=(18, 10))
for i, axi in enumerate(ax.flat):
    axi.imshow(faces.images[i], cmap='gist_gray')
    axi.set(xticks=[], yticks=[], xlabel=faces.target_names[faces.target[i]])

