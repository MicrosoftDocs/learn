Congratulations. You took the first step to incorporate a machine learning model into your UWP app. Now you should have a better understanding of why you might want to run model evaluations locally on your Windows 10 device instead of in the cloud. 

We reviewed these basics:
* Find or create a machine learning model.
* Export the model to the correct format. Or use WinMLTools to convert it if necessary. 
* Load the model in Visual Studio.
* Bind the inputs and outputs in your UWP app.
* Use the model to evaluate your input, a Windows InkCanvas drawing in our example. 

## Related courses

We encourage you to keep learning. More courses are coming soon. Meanwhile, consider these related courses on how to build your own machine learning models:

- [Classify images with the Microsoft Custom Vision Service](https://docs.microsoft.com/learn/modules/classify-images-with-custom-vision-service/)
- [Process images with the Computer Vision Service](https://docs.microsoft.com/learn/modules/create-computer-vision-service-to-classify-images/index)

## Additional resources

**Windows Machine Learning**
- [Windows Machine Learning API reference](https://docs.microsoft.com/windows/ai/api-reference)
- [Windows Machine Learning Docs]( https://docs.microsoft.com/windows/ai/)
- [WinMLTools](https://docs.microsoft.com/windows/ai/convert-model-winmltools): Convert models trained in other ML frameworks into ONNX format for use with the Windows ML API.

### APIs referenced in this course
- [`StorageFile`](https://docs.microsoft.com/uwp/api/windows.storage.storagefile.getfilefromapplicationuriasync#remarks)
- [`ImageFeatureValue`](https://docs.microsoft.com/uwp/api/windows.ai.machinelearning.imagefeaturevalue)
- [`VideoFrame`](https://docs.microsoft.com/uwp/api/windows.media.videoframe)
- [`GetAsVectorView`](https://docs.microsoft.com/uwp/api/windows.ai.machinelearning.tensorfloat.getasvectorview)
- [`InkPresenter`](https://docs.microsoft.com/uwp/api/windows.ui.input.inking.inkpresenter)
- [`CoreInputDeviceTypes`](https://docs.microsoft.com/uwp/api/windows.ui.core.coreinputdevicetypes)

**Other Machine Learning Resources at Microsoft** 
- [Compare ML products at Microsoft](https://docs.microsoft.com/azure/machine-learning/service/overview-more-machine-learning)
- [Azure Cognitive Services](https://azure.microsoft.com/services/cognitive-services/): Find pre-built models to train with Vision, Speech, Knowledge, Search, or Language AI.
- [Azure Custom Vision Service](https://docs.microsoft.com/azure/cognitive-services/custom-vision-service/getting-started-build-a-classifier): Customize your own computer vision models for your unique use case by simply uploading and labeling images. 
- [Azure Machine Learning](https://azure.microsoft.com/overview/machine-learning/): Build, train, deploy, and manage your own models.
- [Visual Studio Tools for AI](https://visualstudio.microsoft.com/downloads/ai-tools-vs/): An extension that supports deep learning frameworks including Microsoft Cognitive Toolkit (CNTK), Google TensorFlow, Theano, Keras, Caffe2 and more. 

### ONNX Model Resources
- [ONNX Model Zoo](https://github.com/onnx/models). Download pretrained ONNX models like the MNIST model we used for this course.
- [ONNX tutorials](https://github.com/onnx/tutorials). How to import and export ONNX models between other ML frameworks. 
