Now that we have all of the libraries downloaded, we can begin importing them into a Jupyter Notebooks file. We'll begin by opening or creating a Jupyter Notebooks file.

Next, we import Matplotlib to help us plot our data:

```python
import matplotlib.pyplot as plt
```

Then, we import NumPy, which we will use to process large numerical matrixes (images):

```python
import numpy as np
```

Import PyTorch to train and process deep learning and AI models:

```python
import torch
from torch import nn, optim
from torch.autograd import Variable
import torch.nn.functional as F
```

Import torchvision (part of pyTorch) to process images and manipulate them (crop, resize):

```python
import torchvision
from torchvision import datasets, transforms, models
```

Import Python Imaging Library (PIL) to visualize images:

```python
from PIL import Image
```

Finally, we add two libraries that ensure that the plots are shown inline and in high resolution:

```python
%matplotlib inline
%config InlineBackend.figure_format = 'retina'
```
