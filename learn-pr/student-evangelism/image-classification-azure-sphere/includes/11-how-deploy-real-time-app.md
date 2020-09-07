So far, you've updated your project with required data and libraries and adjusted settings, so you can start deploying your real-time image classification application to Azure Sphere.

In this module, you don't use a camera to capture images, process them, and classify them on Azure Sphere. You'll take any custom image and convert the image to pixel values, and you'll feed the pixel values as an input image into your network model. You'll evaluate the model based on the pre-defined input data.

The component in this unit is:

**cifar-10-IMG_DATA.ipynb:** It's a Jupyter notebook available in the [GitHub repository](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/scripts). It generates pixel values of a custom image.

Steps you follow are:

1. Define your input image in your image classification application
2. Start deploying the application to Azure Sphere
3. Display output in your terminal emulator

Now you're building and running the neural network with purely pre-defined input data on Azure Sphere. The source code will be processed by taking an input image and will show the resulting output on the terminal emulator.

By the end of the module, you'll learn how to run an image classification model on an ARM microcontroller like Azure Sphere. You'll also learn about the basics of the CMSIS-NN framework.

There are also more possibilities when this neural network framework is leveraged to process those data and extract useful information. 
