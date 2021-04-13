Now that you have the libraries downloaded, you can begin to import them into a Jupyter Notebook file.

> [!Note]
> Make sure you have the artificial intelligence libraries installed. Follow the steps in [Download Python AI libraries](https://docs.microsoft.com/learn/modules/introduction-artificial-intelligence-nasa/7-install-ai-libraries?azure-portal=true).
>

Open Visual Studio Code, and then open or create a Jupyter Notebook file.

The first library to import is the **Matplotlib** library. You use this library to plot your data.
Add the following code to your Jupyter Notebook file:

```python
import matplotlib.pyplot as plt
```

Next, add code to import the **NumPy** library to process large numerical matrixes (images):

```python
import numpy as np
```

Now add code to import the **PyTorch** library to train and process deep learning and AI models:

```python
import torch
from torch import nn, optim
from torch.autograd import Variable
import torch.nn.functional as F
```

The next library to import is **torchvision**, which is part of **PyTorch**. You use this library to process images and do manipulations like cropping and resizing. Add the following code to your Jupyter Notebook file:

```python
import torchvision
from torchvision import datasets, transforms, models
```

Now add code to import the **Python Imaging Library** (PIL) so you can visualize the images:

```python
from PIL import Image
```

Finally, add code to import two libraries that ensure the plots are shown inline and with high resolution:

```python
%matplotlib inline
%config InlineBackend.figure_format = 'retina'
```
