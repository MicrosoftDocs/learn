[NVIDIA Triton Inference Server](https://developer.nvidia.com/nvidia-triton-inference-server) is a multi-framework, open-source software that is optimized for inference. It supports popular machine learning frameworks like [TensorFlow](https://www.tensorflow.org/), [ONNX Runtime](https://onnxruntime.ai/), [PyTorch](https://pytorch.org/), [NVIDIA TensorRT](https://developer.nvidia.com/tensorrt), and more. NVIDIA Triton can be used to process inference for CPU or GPU workloads. In this module, you deploy your production model to NVIDIA Triton server to perform inference on a cloud-hosted virtual machine.

### Prerequisites

- [Azure Free Trial Account](https://azure.microsoft.com/free/)

## Scenario: Deploy a production model to NVIDIA Triton Server for inference processing

You're a data scientist who is assigned the task of improving automation in a manufacturing facility using computer vision. Your team developed an Open Neural Network Exchange (ONNX) based object detection model using [Azure Machine Learning studio](https://ml.azure.com/) and is ready to put that model into production. [NVIDIA Triton Inference Server](https://developer.nvidia.com/nvidia-triton-inference-server) is chosen as the inference processor due to it's ability to run the ONNX format on CPU or GPU based hardware. Your team plans to target a cloud-hosted virtual machine to run the model, which allows you to perform inference on image frames that are received from the production environment.

## What do you learn?

After you finish this module, you're able to:

- Create an NVIDIA GPU Accelerated Virtual Machine.
- Configure NVIDIA Triton Inference Server and related prerequisites.
- Execute an inference workload on NVIDIA Triton Inference Server.

## What is the main goal?

This module shows you how to deploy a production model to NVIDIA Triton Inference Server for inference processing.