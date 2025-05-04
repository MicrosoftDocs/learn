To use the Azure AI Vision Face API, you must provision a resource for the service in an Azure subscription. You can provision **Face** as a single-service resource, or you can use the Face API in a multi-service **Azure AI Services** resource; which can be provisioned as a standalone resource or as part of an Azure AI Foundry hub.

To use your resource from a client application you must connect to its *endpoint* using either *key-based authentication* or *Microsoft Entra AI authentication*. When using the REST interface you can provide the authentication key or token in the request header. When using a language-specific SDK (for example, the Python **azure-ai-vision-face** package or the Microsoft .NET **Azure.AI.Vision.Face** package), you use a **FaceClient** object to connect to the service.

::: zone pivot="python"

```python
from azure.ai.vision.face import FaceClient
from azure.ai.vision.face.models import *
from azure.core.credentials import AzureKeyCredential

face_client = FaceClient(
    endpoint="<YOUR_RESOURCE_ENDPOINT">,
    credential=AzureKeyCredential("<YOUR_RESOURCE_KEY>"))
```

::: zone-end

::: zone pivot="csharp"

```C#
using Azure;
using Azure.AI.Vision.Face;

FaceClient faceClient = new FaceClient(
    new Uri("<YOUR_RESOURCE_ENDPOINT">),
    new AzureKeyCredential("<YOUR_RESOURCE_KEY>"));
```

::: zone-end

To detect and analyze faces in an image, you must specify the model-specific features you want the service to return, and then use the client to call the **Detect** method.

::: zone pivot="python"

```python
# Specify facial features to be retrieved
features = [FaceAttributeTypeDetection01.HEAD_POSE,
            FaceAttributeTypeDetection01.OCCLUSION,
            FaceAttributeTypeDetection01.ACCESSORIES]

# Use client to detect faces in an image
with open("<IMAGE_FILE_PATH>", mode="rb") as image_data:
    detected_faces = face_client.detect(
        image_content=image_data.read(),
        detection_model=FaceDetectionModel.DETECTION01,
        recognition_model=FaceRecognitionModel.RECOGNITION01,
        return_face_id=True,
        return_face_attributes=features,
    )
```

::: zone-end

::: zone pivot="csharp"

```C#
// Specify facial features to be retrieved
FaceAttributeType[] features = new FaceAttributeType[]
{
    FaceAttributeType.Detection01.HeadPose,
    FaceAttributeType.Detection01.Occlusion,
    FaceAttributeType.Detection01.Accessories
};

// Use client to detect faces in an image
using (var imageData = File.OpenRead(imageFile))
{    
    var response = await faceClient.DetectAsync(
        BinaryData.FromStream(imageData),
        FaceDetectionModel.Detection01,
        FaceRecognitionModel.Recognition01,
        returnFaceId: false,
        returnFaceAttributes: features);
    IReadOnlyList<FaceDetectionResult> detected_faces = response.Value;
}
```

::: zone-end

The response from the service depends on:

- The model-specific features requested.
- The number of faces detected in the image.

A response for an image containing a single face might look similar to the following example:

```json
[
    {
        'faceRectangle': {'top': 174, 'left': 247, 'width': 246, 'height': 246}
        'faceAttributes':
        {
            'headPose':{'pitch': 3.7, 'roll': -7.7, 'yaw': -20.9},
            'accessories':
                [
                    {'type': 'glasses', 'confidence': 1.0}
                ],
            'occlusion':{'foreheadOccluded': False, 'eyeOccluded': False, 'mouthOccluded': False}
        }
    }
]
```
