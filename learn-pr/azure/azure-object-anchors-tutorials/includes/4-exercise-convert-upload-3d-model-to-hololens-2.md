In this tutorial you will learn how to use the sample project to create an Azure Object Anchors model from a 3D model using [Azure Object Anchors Conversion SDK for .NET.](/dotnet/api/overview/azure/mixedreality.objectanchors.conversion-readme-pre). This package allows you to convert an existing 3D asset into a format that the Object Anchors runtime can use to recognize physical objects.

## Get the sample project

For this tutorial you will use the sample project to convert your 3D model into an Azure Object Anchors model, clone the sample project from this [repository](https://github.com/Azure/azure-object-anchors).

You can also clone the repository by running the following commands:

```console
git clone https://github.com/Azure/azure-object-anchors.git

cd ./azure-object-anchors
```

## Convert your 3D model to Object Anchors Model

1) From the downloaded sample project open the **quickstarts/conversion/Conversion.sln** in Visual Studio. This contains a C# console project to convert the 3D model.

    :::image type="content" source="../media/open-solution-file.png" alt-text="Screenshot of sample project solution file." lightbox="../media/open-solution-file.png":::

2) In the **Solution Explorer** expand the **ConversionQuickstart** and double-click on **Configuration.cs** to open the file.

    :::image type="content" source="../media/open-configuration-file.png" alt-text="Screenshot of configuration file." lightbox="../media/open-configuration-file.png":::

3) Replace the **set-me** values with the credentials from the Azure Object Anchors account created in the previous section of this series.

    * In the **AccountId** field, paste the **Account ID** from your Azure Object Anchors account
    * In the **AccountKey** field, paste the primary **Key** from your Azure Object Anchors account
    * In the **AccountDomain** field, paste the **Account Domain** from your Azure Object Anchors account

    You need to define the path to the 3D model, the Supported file formats are **fbx**, **ply**, **obj**, **glb**, and **gltf**.

    At the **InputAssetPath** add the absolute path to a 3D model on your local machine.

    In addition, you must include **Gravity**, which is the direction of the 3D model's gravity vector. The down vector pointing to the earth is the gravity direction. The gravity direction in CAD models is usually the inverse of the up direction. For example, in many cases +Z represents up, in which case -Z or Vector3(0.0, 0.0, -1.0) would represent the gravity direction. When determining gravity, you should also consider the orientation in which the model will be seen during runtime. If you're trying to detect a chair in the real world on a flat surface, gravity might be Vector3(0.0, 0.0, -1.0). However, if the chair is on a 45-degree slope, gravity might be Vector3(0.0, -Sqrt(2)/2, -Sqrt(2)/2).

    :::image type="content" source="../media/credentials-image.png" alt-text="Screenshot of configuration file configured with Account info." lightbox="../media/credentials-image.png":::

     > [!NOTE]
      > The gravity direction can be determined with a 3D rendering tool, like [MeshLab](http://www.meshlab.net/).

4) Once all the required fields are filled select **Debug** > **StartDebugging** to build and run the project to upload your 3D model. Register a new conversion job with the service, and wait for it to be completed. Once the job is completed, the Object Anchors model will be downloaded next to the file specified in the **InputAssetPath** you specified earlier.

    :::image type="content" source="../media/start-debug.png" alt-text="Screenshot of Building a project." lightbox="../media/start-debug.png":::

5) Once the process is completed, you should see a file with the format **Model-Filename-Without-Extension_JobID.ou** in the specified output location. For example, if your 3D model filename is **chair.fbx** and your job ID is **00000000-0000-0000-0000-000000000000** then the filename will be **chair_00000000-0000-0000-0000-000000000000.ou**.

## Upload your model

You must first make your models available to the app before running it. Follow these instructions to upload a model to your HoloLens2's **3D Objects folder** while your HoloLens2 is turned on and connected to the development device (PC).

1) In the left pane of File Explorer, you should find your HoloLens displayed with other drives and folders. To see the storage on the HoloLens device, tap on the HoloLens link.

    :::image type="content" source="../media/hololens-explorer.png" alt-text="Screenshot of explorer window of HoloLens." lightbox="../media/hololens-explorer.png":::

2) Next go to **Internal Storage** > **3D Objects**, copy and paste your converted Objects Anchors 3D model hear.

    :::image type="content" source="../media/hololens-explorer-3d-objects.png" alt-text="Screenshot of converted 3 D model added to HoloLens folder." lightbox="../media/hololens-explorer-3d-objects.png":::
