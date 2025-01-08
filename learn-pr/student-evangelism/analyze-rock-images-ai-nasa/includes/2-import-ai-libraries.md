Now that you have the libraries downloaded, you can begin to import them into a Jupyter Notebook file.

## Prerequisites

- The AI libraries are installed as described in Download Python AI libraries.

- The [Python extension for Visual Studio Code][VSCodePython] is installed, so Jupyter Notebook files run in the interactive Python environment.

## Add import statements for the libraries

Follow these steps to add code to import the AI libraries. Insert each new section of code into an empty cell in your Jupyter Notebook file. Select the green arrow at the top of the cell to run the new code.

1. Open Visual Studio Code, and then open the Jupyter Notebook file that you created in the previous module.

   In the previous module, we named our Jupyter Notebook file *ClassifySpaceRockProgram.ipynb*.

1. Make sure you're running the correct Jupyter kernel. At the upper-right and lower-left corners of Visual Studio Code, change to the Anaconda environment `('myenv')` that you created in the last module.

1. The first library to import is **Matplotlib**. You use this library to plot your data. Add the following code in new cell in your Jupyter Notebook file, and then run the code.

   ```python
   import matplotlib.pyplot as plt
   ```

1. Next, add the following code to import the **NumPy** library to process large numerical matrixes (images), and run the new cell.

   ```python
   import numpy as np
   ```

1. Now add code in a new cell to import the **PyTorch** library to train and process deep learning and AI models. After you add the new code, run the cell.

   ```python
   import torch
   from torch import nn, optim
   from torch.autograd import Variable
   import torch.nn.functional as F
   ```

1. The next library to import is **torchvision**, which is part of **PyTorch**. You use this library to process images and do manipulations like cropping and resizing. Add this code in a new cell to import the library, and then run the cell.

   ```python
   import torchvision
   from torchvision import datasets, transforms, models
   ```

1. Now add code in a new cell to import the **Python Imaging Library** (PIL) so you can visualize the images. After you add the new code, run the cell.

   ```python
   from PIL import Image
   ```

1. Finally, add the following code in a new cell to import two libraries that ensure the plots are shown inline and with high resolution. After you add the new code, run the cell.

   ```python
   %matplotlib inline
   %config InlineBackend.figure_format = 'retina'
   ```

Great job! You've added code to import all the libraries you'll need for your AI program.

<!-- Links -->

[VSCodePython]: https://marketplace.visualstudio.com/items?itemName=ms-python.python
