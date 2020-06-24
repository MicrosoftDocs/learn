So far, you've updated your project with required data, libraries and adjusted settings, you can start deploying your real-time image classification application to Azure Sphere.

In this module, you don't use a camera to capture images, process, and classify them on Azure Sphere. You'll take any custom image and converting the image to the pixel values and you'll be feeding the pixel values as an input image into your network model. You'll evaluate the model based on the pre-defined input data.

The component in this unit is:

**cifar-10-IMG_DATA.ipynb:** It's a Jupyter notebook available in [GitHub repository](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/scripts). It generates pixel values of custom image.

Steps you follow are:

1. Define your input image in your image classification application
2. Start deploying application to Azure Sphere
3. Display output in your terminal emulator

Now you're building and running the neural network with purely pre-defined input data on the Azure Sphere. The source code will be proceeded by taking input image and will show the output on the terminal emulator.

By the end of the module, you'll learn how to run an image classification model on ARM microcontroller like Azure Sphere and the basics of the CMSIS-NN framework.

There are also more possibilities when this neural network framework is leveraged to process those data and extract useful information. 
