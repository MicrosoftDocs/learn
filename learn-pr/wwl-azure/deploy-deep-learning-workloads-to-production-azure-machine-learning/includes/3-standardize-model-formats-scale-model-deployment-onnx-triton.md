Convert your model to the standard ONNX format to make inference optimization easier.

To identify objects in real time from images, you are using either DeepSpeed or Triton to deploy the deep-learning model you trained. To help either of these frameworks to optimize the model performance during inferencing, you want to convert the model to ONNX so that the ONNX Runtime is used.

You'll learn how to convert a model to ONNX.

## Convert to ONNX

The **Open Neural Network Exchange** (**ONNX**) is an open and standardized format for machine and deep learning models. You can convert models from frameworks like TensorFlow, PyTorch, SciKit-Learn, Keras, and SparkML. 

The main benefit of working with ONNX, is that the standard is accepted by different platforms and frameworks, to more easily optimize the model's performance. 

For example, imagine you deploy your model to a managed online endpoint and you want to use the Triton Inference Server to find the optimal configuration. As the model will be used both on the cloud and edge, you want to make sure you only have to train a model once. You don't want to have to worry about where you want to deploy when training the model.

By training an ONNX model in Azure Machine Learning, or converting your model to ONNX format, you can use the ONNX Runtime when inferencing to get a better performance.

> [!TIP] 
> Learn more about [ONNX and Azure Machine Learning](/azure/machine-learning/concept-onnx#get-onnx-models).
