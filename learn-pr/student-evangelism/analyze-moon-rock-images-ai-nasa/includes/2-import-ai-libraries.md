Now that we have all of the libraries downloaded, we can begin importing them into a Jupyter Notebooks file. Start by opening or creating a Jupyter Notebooks file.

First, we will import matplotlib to help us plot our data

```python
import matplotlib.pyplot as plt
```

Next, we will import numPy which we will use to process large numerical matrixes (images)

```python
import numpy as np
```

Import pyTorch to train and process deep learning and AI models

```python
import torch
from torch import nn, optim
from torch.autograd import Variable
import torch.nn.functional as F
```

Import torch vision (part of pyTorch) to process images and manipulate them (crop, change size, ect.)

```python
import torchvision
from torchvision import datasets, transforms, models
```

Import PIL to visualize images

```python
from PIL import Image
```

These two will ensure that the plots are shown inline and in high resolution.

```python
%matplotlib inline
%config InlineBackend.figure_format = 'retina'
```
