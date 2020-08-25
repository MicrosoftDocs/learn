A microcontroller like Azure Sphere is a resource-constrained device. You need to adapt the model to run on a microcontroller, in this case Azure Sphere. The size of the model needs to be very small, and the model needs to be pre-trained and optimized for your input data.

When you train a model, you get trained weights and parameters for a deep learning model. To run this deep learning model on Azure Sphere, you'll need to quantize weights and parameters to convert from 32-bit floating data to 8-bit or 16-bit fixed data. **Quantization** is a key step for deploying a model on Azure Sphere (on a microcontroller). Quantization for deep learning is the process of approximating a neural network that uses floating-point numbers by a neural network of low-bit-width numbers. This dramatically reduces both the memory requirement and the computational cost of using neural networks.

In this module, you work with the CIFAR10 image classification model. Your model is trained with the Caffe framework. The weights and parameter are quantized to 8-bit floating data (integers). You'll take quantized weights and parameters of the CIFAR10 model and add them into your sample project. You'll also need to add the CMSIS-NN library into your sample project to take advantage of the microcontroller's capabilities. CMSIS-NN is optimized for CNNs. 

The components for this unit:

- **Microsoft sample image classification repository:** It contains a real-time sample image classification application running on Azure Sphere.

- **CMSIS-NN:** is a software library, a collection of optimized neural network functions for Cortex-M core microcontrollers. It's developed to maximize the performance and minimize the memory footprint of neural networks on Cortex-M processor cores. It enables neural networks and machine learning being pushed into the end node of IoT applications. It's available in the [project folder](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/CMSISNN-Cifar10).

  It has implemented popular neural network layer types, such as convolution, depth separable convolution, fully connected, polling, and activation. With its utility functions, it's also possible to construct more complex NN modules, such as LSTM and GRU.

- **arm_nn_examplescifar10_weights.h:** Quantized weights and bias. It's available in the [project folder](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/CMSISNN-Cifar10).

- **arm_nn_examplescifar10_parameter.h:** Quantized bias, out shift values. It's available in the [project folder](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/CMSISNN-Cifar10).

The steps you'll follow for this unit:

1. Clone a [Microsoft sample image classification repository](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere) to take quantized weights, parameters, and the CMSIS-NN library.
2. Modify and update the source code of your image classification application that you newly created.

In the end of the unit, your model will be configured with required settings so that you'll be able to deploy the application to the microcontroller for inferencing.