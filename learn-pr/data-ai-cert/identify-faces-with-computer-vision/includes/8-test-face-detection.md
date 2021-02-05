Now let’s use the Face API subscription you just created to detect faces in images from a website. We’re going to use the client SDK to keep our code simple and concise. The same functionality is available using the REST API directly.

## Environment setup

The environment for this exercise will make use of Visual Studio Code as the editor. Depending on the programming language you choose, the setup will differ. Follow the steps outlined here to configure your local computer for completion of the exercises.

1. Install [Visual Studio Code](https://code.visualstudio.com/) for your operating system.


### Python

1. If you will be completing your coding with Python, ensure you have a [Python environment](https://www.python.org/downloads/) installed locally.
1. Once you have Python installed, you will need to [install the extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) for VS Code.

### C#

1. If you will be using C# as your code language, start by installing the latest [.NET Core](https://docs.microsoft.com/dotnet/core/install/windows?tabs=netcore31) package for your platform. You can choose Windows, Linux, or macOS from the drop-down on this page.
1. Once you have .NET Core installed, you will need to add the C# Extension to VS Code. Select the **Extensions** option in the left nav pane, or press **CTRL+SHIFT+X** and enter C# in the search dialog.

With your environment setup, you are now ready to begin the coding exercise.



## Set environment variables

1. Set two environment variables, replacing <subscription_key> and <endpoint> with your own values. Your code will reference these values so make sure they are set within the same session you run the code.
1. Choose you environment from the below options of **bash**, **Windows shell**, or **PowerShell**.

    ```bash
    export COGNITIVE_SERVICE_KEY=<subscription_key>
    export COGNITIVE_SERVICE_ENDPOINT=<endpoint>
    ```

    ```dos
      set COGNITIVE_SERVICE_KEY=<subscription_key>
    set COGNITIVE_SERVICE_ENDPOINT=<endpoint>
    ```

    ```powershell
    $env:COGNITIVE_SERVICE_KEY = '<subscription_key>'
    $env:COGNITIVE_SERVICE_ENDPOINT = '<endpoint>'
    ```

## Detect Faces using FaceClient

:::zone pivot="python"

1. Create a new folder to hold your application called **Detect_Faces_Python**.
1. Open the folder in Visual Studio code.
1. Create a new Python file called **facedetect.py**.
1. Install the Cognitive Services FaceClient library by opening a terminal and entering this command.

    ```python
    pip install azure-cognitiveservices-vision-face
    ```

1. In your **facedetect.py** file, import required libraries.

    ```python
    import os
    from msrest.authentication import CognitiveServicesCredentials
    from azure.cognitiveservices.vision.face import FaceClient
    ```

1. Create method to get credential and setup client. This reads in the environment variables for **Subscription Key** and **Endpoint**.

    ```python
    def get_face_client():
        """Create an authenticated FaceClient."""
        SUBSCRIPTION_KEY = os.environ["COGNITIVE_SERVICE_KEY"]
        ENDPOINT = os.environ["COGNITIVE_SERVICE_ENDPOINT"]
        credential = CognitiveServicesCredentials(SUBSCRIPTION_KEY)
        return FaceClient(ENDPOINT, credential)
    ```

1. Call the face detect operation and print results as JSON. Set the url value to an image you choose or just use the value in this example.

    ```python
    face_client = get_face_client()

    url = "https://docs.microsoft.com/en-us/learn/data-ai-cert/identify-faces-with-computer-vision/media/clo19_ubisoft_azure_068.png"

    attributes = ["emotion", "glasses", "smile"]
    include_id = True
    include_landmarks = False

    detected_faces = face_client.face.detect_with_url(url, include_id, include_landmarks, attributes, raw=True)

    if not detected_faces:
        raise Exception('No face detected in image')

    print(detected_faces.response.json())
    ```

1. Select the **Run Python File in Terminal** (green arrow) or right-click in the Python file editor and select **Run Python File in Terminal**.
1. View the output. If your image has one face you will see one entry in the JSON array with elements faceId and faceRectangle. It also includes a few face attributes since we passed in the attributes array. If you were to change the third parameter from false to true it would also include face landmarks.

    ```json
    [
      {
        "faceId": "36c3e7f8-2194-4eed-88cb-15dc8924c8fe",
        "faceRectangle": {
          "width": 161,
          "height": 161,
          "left": 920,
          "top": 303
        },
        "faceLandmarks": null,
        "faceAttributes": {
          "smile": 0.978,
          "glasses": "readingGlasses",
          "emotion": {
            "happiness": 0.978,
            "neutral": 0.019,
            "sadness": 0.002
          }
        }
      }
    ]
    ```

:::zone-end

:::zone pivot="csharp"

1. Open Visual Studio code.
1. Create a new folder to hold your application called **Detect_Faces_Csharp**.
1. Right-click the folder name in Visual Studio Code and choose **Open in integrated terminal**.
1. You will use a .NET Core application for this exercise so enter the following command and pressing Enter.

    ```csharp
    dotnet new console
    ```

1. Install the Cognitive Services FaceClient library by using this command, in the terminal window.

    ```csharp
    dotnet add package Microsoft.Azure.CognitiveServices.Vision.Face --version 2.5.0-preview.1
    ```

1. Select **Program.cs** in the file list, in case it isn't already open in the editor window.
1. Import the required libraries

    ```csharp
    using System;
    using static System.Environment;
    using System.Threading.Tasks;
    using Newtonsoft.Json;

    using Microsoft.Azure.CognitiveServices.Vision.Face;
    using Microsoft.Azure.CognitiveServices.Vision.Face.Models;
    ```

1. Create a method to get credentials and setup the client. This reads in the environment variables for **Subscription Key** and **Endpoint**.

    ```csharp
    public static FaceClient GetFaceClient()
    {
        var serviceEndpoint = GetEnvironmentVariable("COGNITIVE_SERVICE_ENDPOINT");
        var subscriptionKey = GetEnvironmentVariable("COGNITIVE_SERVICE_KEY");
        var credential = new ApiKeyServiceClientCredentials(subscriptionKey);
        return new FaceClient(credential) { Endpoint = serviceEndpoint };
    }
    ```

1. Call the face detect operation and print results as JSON. Set the url value to an image you choose or just use the value in this example.

    ```csharp
    static async Task Main(string[] args)
    {
        var faceClient = GetFaceClient();

        var url = "https://docs.microsoft.com/en-us/learn/data-ai-cert/identify-faces-with-computer-vision/media/clo19_ubisoft_azure_068.png";

        var attributes = new FaceAttributeType[] {
            FaceAttributeType.Emotion,
            FaceAttributeType.Glasses,
            FaceAttributeType.Smile
        };
        bool includeId = true;
        bool includeLandmarks = false;

        var result = await faceClient.Face.DetectWithUrlAsync(url, includeId, includeLandmarks, attributes);
        Console.WriteLine(JsonConvert.SerializeObject(result, Formatting.Indented));

    }
    ```

1. In the terminal window, run the application with this line of code.

    ```csharp
    dotnet run
    ```

1. View the output. If your image has one face you will see one entry in the JSON array with elements faceId and faceRectangle. It also includes a few face attributes since we passed in the attributes array. If you were to change the third parameter from false to true it would also include face landmarks.

    ```json
    [
      {
        "faceId": "36c3e7f8-2194-4eed-88cb-15dc8924c8fe",
        "faceRectangle": {
          "width": 161,
          "height": 161,
          "left": 920,
          "top": 303
        },
        "faceLandmarks": null,
        "faceAttributes": {
          "smile": 0.978,
          "glasses": "readingGlasses",
          "emotion": {
            "happiness": 0.978,
            "neutral": 0.019,
            "sadness": 0.002
          }
        }
      }
    ]
    ```

:::zone-end
