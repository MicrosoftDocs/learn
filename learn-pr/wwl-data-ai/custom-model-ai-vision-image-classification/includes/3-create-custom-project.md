To create a custom Azure AI Vision model, you first need an Azure AI Services resource (or an Azure AI Vision resource). Once that resource is deployed to your subscription, you need to create a custom project.

## Components of a custom Vision project

The first component of a custom project is the *dataset*. The dataset is your collection of images to use while training your model, along with the *COCO file* that defines the label information about those images. Your dataset is stored in an Azure blob storage container, and we cover more about the COCO file further in this unit.

Once you have your images and class labels defined, you can train your custom model. When training your model, you specify the type of model to train, which dataset to use, and your training budget (in amount of time). When the model training is complete, you can view the performance and use the model for predictions.

In most cases, the steps you follow are:

1. Create your blob storage container and upload just the training images.
1. Create the dataset for your project, and connect it to your blob storage container. When creating your dataset, you define what type of project it is (image classification, object detection, or product recognition).
1. Label your data in your Azure Machine Learning Data Labeling Project, which creates the COCO file in your blob storage container.
1. Connect your completed COCO file for the labeled images to your dataset.
1. Train your custom model on the dataset and labels created.
1. Verify performance and iterate if the trained performance isn't meeting expectations.

Once you're happy with the performance, the model can be used in Vision Studio or in your own application.

### COCO files

A COCO file is a JSON file with a specific format that defines:

- **images**: Defines the image location in blob storage, name, width, height, and ID.
- **annotations**: Defines the classifications (or objects), including which category the image is classified as, the area, and the bounding box (if labeling for object detection).
- **categories**: Defines the ID for the named label class.

In most cases, COCO files are created by labeling your training images in an Azure Machine Learning Data Labeling Project. If you're migrating from an old Custom Vision project, you can use the [migration script](/azure/ai-services/computer-vision/how-to/migrate-from-custom-vision?azure-portal=true) to create your COCO file.

A sample COCO file looks like this:

```json
{
  "images": [
    {
      "id": 1,
      "width": 1024,
      "height": 768,
      "file_name": "abc.jpg",
      "coco_url": "AmlDatastore://fruit/abc.jpg",
      "absolute_url": "https://myBlobStorage.blob.core.windows.net/fruit/abc.jpg",
      "date_captured": "<date>"
    },
    {
      "id": 2,
      "width": 1024,
      "height": 768,
      "file_name": "xyz.jpg",
      "coco_url": "AmlDatastore://fruit/xyz.jpg",
      "absolute_url": "https://myBlobStorage.blob.core.windows.net/fruit/xyz.jpg",
      "date_captured": "<date>"
    },
    <...>
  ],
  "annotations": [
    {
      "id": 1,
      "category_id": 1,
      "image_id": 1,
      "area": 0.0
    },
    {
      "id": 2,
      "category_id": 1,
      "image_id": 2,
      "area": 0.0
    },
    <...>
  ],
  "categories": [
    {
      "id": 1,
      "name": "apple"
    },
    {
      "id": 2,
      "name": "orange"
    },
    {
      "id": 3,
      "name": "banana"
    }
  ]
}
```

If you're labeling an object detection dataset, each annotation in the COCO file also contains a bounding box array with the values in the array being *Left*, *Top*, *Width*, and *Height*.

```json
"bbox": [
    0.11803319477782331,
    0.41586723392402375,
    0.7765206955096307,
    0.3483334397217212
]
```

## Creating your dataset

Once you have images in your blob storage container, you can create your dataset for training using either the REST API, or by using the Vision Studio. The REST request would be similar to the following REST call:

```rest
curl -X PUT https://<endpoint>/computervision/datasets/<dataset-name>?api-version=<version>\
  -H "Content-Type: application/json" \
  -H "Ocp-Apim-Subscription-Key: <subscription-key>" \
  --data-ascii "
  {
    'annotationKind':'imageClassification',
    'annotationFileUris':['<URI>']
  }"
```

If using [Vision Studio](https://portal.vision.cognitive.azure.com/?azure-portal=true), you would navigate to the custom model tile, select your resource, and create your dataset. From there, you can open or create an Azure Machine Learning Data Labeling Project, or upload an existing COCO file. The exercise in this module walks through how to create your dataset in this way.

Using Vision Studio enables you to connect to your labeling project in Azure Machine Learning instead of specifying the COCO file in the REST request. The rest of the examples in this module use Vision Studio, but if REST is your preferred method examples are available on the documentation pages.
