With Windows Machine Learning (Windows ML), developers can download and use pretrained machine learning models in Universal Windows Platform (UWP) apps across the Windows 10 device family. These devices include laptops, PCs, Internet of Things (IoT) devices, servers, datacenters, and the HoloLens headset. 

The Windows ML API offers access to an inference engine that performs local client-side evaluation by using machine learning models. These models were built and trained in the cloud. The models perform these tasks and many more:
* Convert spoken audio into text.
* Voice verification.
* Identify and caption objects in photographs.
* Extract key information from a data set and enrich it to quickly find valuable insights. 

In this lesson, we take the following steps:

- Compare using a machine learning model locally with Windows ML to a cloud-based system.
- Set up a simple UWP app with C#.
- Add a pretrained machine learning model to your app.
- Load the model, bind the inputs and outputs, and use it to evaluate input.
- Test the model by drawing digits into a Windows InkCanvas. Then we'll see whether the model recognizes what number we've drawn.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2Msj5]

### Machine learning in the cloud versus on a local device, offline

The typical approach to machine learning is as follows:

- Gather data.
- Use that data to train a model.
- Use the model to make predictions.

The training of a model typically involves huge amounts of complex data, a ton of processing power, and a data science degree. [Azure AI services](https://azure.microsoft.com/services/cognitive-services/) makes that training process much simpler. It offers APIs, SDKs, and services to help developers build machine learning models that power intelligent applications. You don't need direct AI or data science skills or knowledge. 

One type of machine learning model is an image classifier. You gather images and use those images to train the model to recognize objects like a numerical digit. Then you use the model to evaluate a new image and make a prediction, or infer, what number appears in the new image. 

Training a model can be a difficult and expensive process without the help of a service. But after the model is trained, the process of evaluation, or inference, is relatively simple.

There are two ways to use a trained machine learning model to perform evaluations:

- From the cloud by calling the model's prediction endpoint over HTTP. See the [Classify images with the Microsoft Custom Vision Service](/training/modules/classify-images-with-custom-vision-service/5-call-the-prediction-endpoint-curl) course for direction on using this method.
- Locally by downloading the model, in ONNX format. Include it in your app code to be installed and used with the Windows ML API on a Windows 10 device.

Whether or not you use a machine learning model locally or in the cloud depends on your use-case scenario. The following comparisons might help you determine the best choice for your needs. 


| Cloud evaluation | Local evaluation |
| :---- | :---- |
|:::image type="content" source="../media/evaluating-cloud3.png" alt-text="Diagram depicting client computer sending image to the machine learning in the cloud with prediction results returned":::|:::image type="content" source="../media/evaluating-locally3.png" alt-text="Diagram depicting client computer sending image to the machine learning on a local server with prediction results returned":::|
| Complex processing of large amounts of data. Services like Azure AI services offer a simple, user-friendly way to both train and evaluate models. | Windows ML is built into all Windows 10 devices. It offers APIs to evaluate models offline. And it's available to both Win32 and UWP apps: C#, C++, and JS. |
| Backup and restore can be initiated from anywhere by using any device. There's no risk of data loss from a damaged machine. | Increased flexibility by removing concerns of connectivity, bandwidth, and data privacy. |
| Might require waiting for large amounts of data to make a roundtrip to the cloud and back. | Able to respond quickly, processing an evaluation directly on the device in real time. A DirectX 12 GPU can be used for hardware acceleration, making evaluation even faster. |
| Continuous training of models, growing smarter over time. | Reduced operational costs. Not paying for internet bandwidth and cloud storage. |
| Might be blocked by privacy or regulatory concerns. Examples are healthcare data and HIPAA. | Private and secure. Sensitive patient data can be kept on the local device. |  

:::image type="complex" source="../media/winml-flow.png" alt-text="Diagram depicting the machine learning flow diagram":::

The diagram depicts the workflow where the model is downloaded, in ONNX format. The model reference is added to your application code and then included in your app that is to be installed and used with the Windows ML API on a Windows 10 device.
:::image-end:::
