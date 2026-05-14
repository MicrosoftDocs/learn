In this module, you design a small embedded edge image-classification application for Azure Sphere. The sample evaluates a single image compiled into the application rather than processing a stream or locating regions within a scene. You'll run local whole-image classification for one compile-time 32x32 RGB input image on one of the Azure Sphere MT3620 Cortex-M4F real-time cores by using Arm's CMSIS-NN kernels. A microcontroller is a compact integrated circuit embedded system designed to create a solution for a specific operation. Typically, microcontrollers include a processor, memory, and input/output (I/O) peripherals on a single chip.

Azure Sphere is a secured, high-level application platform with built-in communication and security features for internet-connected devices. It comprises a secured, connected, crossover microcontroller unit (MCU), a custom high-level Linux-based operating system (OS), and a cloud-based security service that provides continuous, renewable security.

The Azure Sphere MCU integrates real-time processing capabilities with the ability to run a high-level operating system. An Azure Sphere MCU, along with its operating system and application platform, enables the creation of secured, connected embedded devices that can be updated, controlled, monitored, and maintained remotely. A high-level application can use internet and cloud services, while an RTApp runs locally on a real-time core and can communicate only with a high-level application. For this sample, inference runs on the embedded device rather than in a cloud runtime.

In this module, we use the Azure Sphere MT3620 board. The application doesn't upload new images at run time. Instead, the sample includes one 32x32 RGB image as C data at build time. When the RTApp runs, it classifies that whole image into one of the CIFAR-10 classes.

The neural network used by the sample is a Caffe-trained model based on the CIFAR-10 dataset, which contains 60,000 32x32 color images across 10 classes. The model architecture has three convolution layers with ReLU and max-pooling stages, followed by a fully connected output layer for the class scores.

For a full machine-learning-to-microcontroller workflow, a trained floating-point model is often quantized and exported into source files that embedded C code can compile. Quantization reduces memory use and compute cost by representing tensors, such as weights and activations, with low-bit-width integer or fixed-point values. This module doesn't train, quantize, or export the model. Those steps are already complete, and you use pre-quantized Q7 model data and image data in C header files for CMSIS-NN inference.

The components you'll use are:

- **Azure Sphere MT3620 Board:** MT3620 is the first Azure Sphere certified MCU. Azure Sphere certified MCUs are a new class of secured, connected crossover microcontrollers.

- **CIFAR-10 dataset:** consists of 60,000 32x32 color images in 10 classes. Reference documentation is [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html).

- **Neural network:** We use a Caffe-trained CIFAR-10 convolutional neural network with three convolution layers, ReLU and max-pooling stages, and a fully connected output layer.

- **CMSIS-NN Library:** a collection of efficient neural network kernels developed to maximize the performance and minimize the memory footprint of neural networks on Cortex-M processor cores. Current CMSIS-NN documentation describes the library concepts and supported kernels. This sample uses legacy CMSIS_5 NN Q7 APIs and data types, such as functions named `arm_softmax_q7`, so use the CMSIS_5 NN documentation when checking those specific Q7 function signatures. Reference is [ARM](https://www.keil.com/pack/doc/CMSIS_Dev/NN/html/index.html).

- **Hello World Real-Time Application:** This is the sample application that you'll adapt. It shows how to build a sample application for the real-time capable cores on an Azure Sphere device using Visual Studio Code.  

To summarize, you'll modify the existing Hello World Real-Time Application project. In this module, you'll clone the sample repository, adjust configuration, and update the source code. You'll add the CMSIS-NN library and call the Q7 inference functions used by the project. During development, you'll build the RTApp, sideload it to the Azure Sphere device for local testing, and view the classification output in a terminal emulator. Cloud deployment through Azure Sphere catalog, product, and device-group workflows is a separate production update process, not the runtime path for this local inference sample.
