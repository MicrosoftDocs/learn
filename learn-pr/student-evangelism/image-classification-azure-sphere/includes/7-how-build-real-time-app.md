A microcontroller like Azure Sphere is a resource-constrained device. You need to adapt the model to run on a microcontroller, in this case Azure Sphere. The size of the model needs to be very small, and the model needs to be pre-trained and optimized for your input data.

In a production project, you would train a model on data that matches your target scenario, validate it, and quantize it for the target device. In this module, you use a pre-trained, pre-quantized CIFAR-10 example model so you can focus on the Azure Sphere RTApp build. Later, you'll replace only the compile-time input image data used by the sample.

When you train a model, you get trained weights and model parameters for a deep learning model. To run this deep learning model on Azure Sphere, you'll typically quantize weights and activations to convert from 32-bit floating-point values to 8-bit or 16-bit fixed-point integer values. **Quantization** is a key step for deploying a model on Azure Sphere on a microcontroller. Quantization for deep learning is the process of approximating a neural network that uses floating-point numbers with a neural network of low-bit-width numbers. This dramatically reduces both the memory requirement and the computational cost of using neural networks.

In this module, you work with the CIFAR-10 image classification model. The example model was trained with the Caffe framework and uses legacy CMSIS_5 v5.5.1 Q7 APIs, where Q7 values are 8-bit fixed-point/integer quantized weights and activations. You'll take the pre-quantized CIFAR-10 model headers and add them to your sample project. You'll also add the CMSIS-NN source files required by the model to take advantage of optimized neural network kernels for Cortex-M microcontrollers.

The components for this unit:

- **Microsoft sample image classification repository:** It contains a real-time sample image classification application running on Azure Sphere.

- **CMSIS-NN:** is a software library, a collection of optimized neural network functions for Cortex-M core microcontrollers. It's developed to maximize the performance and minimize the memory footprint of neural networks on Cortex-M processor cores. It enables neural networks and machine learning to be pushed into the end node of IoT applications. The modern standalone [CMSIS-NN documentation](https://arm-software.github.io/CMSIS-NN/latest/) is useful for concepts such as convolution, fully connected, pooling, softmax, and activation kernels. This module's sample, however, uses legacy CMSIS_5 v5.5.1 Q7 functions such as `arm_convolve_HWC_q7_RGB`, `arm_convolve_HWC_q7_fast`, `arm_relu_q7`, `arm_maxpool_q7_HWC`, `arm_fully_connected_q7`, and `arm_softmax_q7`. Use the [CMSIS_5 documentation](https://arm-software.github.io/CMSIS_5/NN/html/index.html) when looking up those legacy `arm_*_q7` APIs.

  The sample's CMSIS files are available in the [CMSISNN-Cifar10 project folder](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/CMSISNN-Cifar10). Preserve the folder casing and nested layout when you copy them into your RTApp project.

  CMSIS-NN implements popular neural network layer types, such as convolution, depthwise separable convolution, fully connected, pooling, softmax, and activation. With its utility functions, it's also possible to construct more complex NN modules, such as LSTM and GRU.

- **arm_nnexamples_cifar10_weights.h:** Contains the pre-quantized CIFAR-10 weights, biases, and Q7 shift constants used by the legacy CMSIS-NN kernels. It's available in the [project folder](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/CMSISNN-Cifar10/include).

- **arm_nnexamples_cifar10_parameter.h:** Contains the model layer shape and configuration constants, such as image dimensions, channel counts, kernel dimensions, padding, stride, pooling dimensions, and fully connected layer sizes. It's available in the [project folder](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/CMSISNN-Cifar10/include).

- **arm_nnexamples_cifar10_inputs.h:** Contains `IMG_DATA`, a flat `uint8_t` 32-by-32 RGB input image in HWC order, plus `INPUT_MEAN_SHIFT` and `INPUT_RIGHT_SHIFT` constants used by the sample's input preprocessing. It's available in the [project folder](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/CMSISNN-Cifar10/include).

The steps you'll follow for this unit:

1. Clone a [Microsoft sample image classification repository](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere) to take quantized weights, parameters, and the CMSIS-NN library.
2. Copy `main.c` from `CMSISNN-Cifar10` into your copied ImageClassification RTApp project, replacing the HelloWorld `main.c`.
3. Copy the sample `include` folder and the required legacy CMSIS source tree into your copied RTApp project.
4. Update the current HelloWorld RTApp `CMakeLists.txt` to add only the CMSIS-NN sources and include directories that the sample uses. Keep the current `CMakePresets.json` structure and keep `azsphere_target_add_image_package(${PROJECT_NAME})` as the final Azure Sphere image-package step.

At the end of the unit, your model will be configured with the required settings so that you'll be able to deploy the application to the microcontroller for inferencing.
