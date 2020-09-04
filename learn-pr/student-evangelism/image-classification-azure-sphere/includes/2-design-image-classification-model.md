In the scenario, you were tasked with designing a system that can detect the presence of deer in images. The solution must work offline in hostile environments. To fulfill the requirement, you'll implement a neural network model performing real-time image classification on Azure Sphere (MT3620 Cortex-M4 core), using Arm’s CMSIS-NN library. A microcontroller is a compact integrated circuit embedded system designed to create a solution for a specific operation. Typically, microcontrollers include a processor, memory, and input/output (I/O) peripherals on a single chip.

Azure Sphere is a secured, high-level application platform with built-in communication and security features for internet-connected devices. It comprises a secured, connected, crossover microcontroller unit (MCU), a custom high-level Linux-based operating system (OS), and a cloud-based security service that provides continuous, renewable security.

The Azure Sphere MCU integrates real-time processing capabilities with the ability to run a high-level operating system. An Azure Sphere MCU, along with its operating system and application platform, enables the creation of secured, internet-connected devices that can be updated, controlled, monitored, and maintained remotely. The use of a device like Azure Sphere means that you don’t need a high-spec machine or cloud compute to do real-time ML tasks on Azure IoT Edge devices. You can do them fast and efficiently on embedded devices.

In this module, we use the Azure Sphere MT3620 board. Note that here, you aren't using a camera to detect the images. Instead, you'll upload custom images into the project and will run the project to detect the image (in this case, an image of a deer).

You use the CIFAR-10 dataset, which has been trained with Caffe. In this unit, we explain how to fit the model to run on a resource-constrained device like a microcontroller. You need the additional step of quantization because the model needs to be small to deploy on a constrained device. The model needs to be trained and quantized from 32-bit to 8-bit. Quantization is a crucial step for being able to deploy a model on Azure Sphere. The purpose of quantization is not to improve the accuracy of the model. Quantization mainly reduces the size of the model by converting a 32-bit floating-point model to an 8-bit fixed-point model. This step has a minimal impact on the accuracy but allows the model to fit into the microcontroller. As the weights are fixed after the training, you know their min/max range. They are quantized or discretized to 256 levels using their ranges. Also, quantization improves overall compute performance. When the quantization is completed, you need to transform the model format to a C format. Hence your model will be able to deploy on Azure Sphere.

The description above explains the overall structure. In this module, you'll use data that have been already quantized and transformed. You'll add these data to your project sample and deploy a real-time application on Azure.

The components you'll use are:

- **Azure Sphere MT3620 Board:** MT3620 is the first Azure Sphere certified MCU. Azure Sphere certified MCUs are a new class of secured, connected crossover microcontrollers.

- **CIFAR-10 dataset:** consists of 60,000, 32x32 color images in the 10 classes. Reference documentation is [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html).

- **Neural network:** We use a 3-layer trained convolutional neural network.

- **CMSIS-NN Library:** a collection of efficient neural network kernels developed to maximize the performance and minimize the memory footprint of neural networks on Cortex-M processor cores. Reference is [ARM](https://www.keil.com/pack/doc/CMSIS_Dev/NN/html/index.html).

- **Hello World Real-Time Application:** This is the sample application that you'll adapt. It shows how to build a sample application for the real-time capable cores on an Azure Sphere device using Visual Studio Code.  

To summarize, you'll modify the existing Hello World Real-Time Application project. In this module, you'll clone the sample repository, adjust configuration and update the source code. You'll also add the CMSIS-NN library into the sample project and call the library functions to be used in your project. When you run the project, the code will be deployed by taking the input image and will show the output on the terminal emulator.
