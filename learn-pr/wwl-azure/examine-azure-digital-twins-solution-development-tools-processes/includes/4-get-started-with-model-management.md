Module management operations include validation, upload, retrieval, update, and deletion.

You can manage the models within your Azure Digital Twins instance using the DigitalTwinModels APIs, the .NET (C\#) SDK, or the Azure Digital Twins CLI extension. Other Microsoft and third-party applications, such as Visual Studio Code, can also be used to perform model management tasks.

## Validating and uploading models

After creating a model, it's recommended that you validate your models offline before uploading them to your Azure Digital Twins instance.

### Model validation tools

Microsoft provides the following tools that can be used to validate Azure Digital Twins models:

 -  DTDL Validator: The DTDL Validator is a language-agnostic sample app available for validating model documents to make sure the DTDL is correct before uploading it to your instance. It's located here: [DTDL Validator sample](https://github.com/Azure-Samples/DTDL-Validator). The DTDL validator sample is built on a .NET DTDL parser library, which is available on NuGet as a client-side library: Microsoft.Azure.DigitalTwins.Parser. You can also use the library directly to design your own validation solution. When using the parser library, make sure to use a version that is compatible with the version that Azure Digital Twins is running. The current version is 4.0.8.
 -  DTDL Editor for Visual Studio Code: The DTDL extension for Visual Studio Code supports both model authoring and validation. The tool uses Intellisense to help you with the language syntax (including autocompletion) and syntax validation. The full documentation for the DTDL Editor for Visual Studio Code can be found here: DTDL - Visual Studio Marketplace.

### Uploading models to Azure Digital Twins

Once you're finished creating, extending, or selecting your models, you're ready to upload them to your Azure Digital Twins instance for use in your solution.

You can upload models using the following techniques:

 -  Azure Digital Twins REST APIs.
 -  Azure CLI commands.
 -  Azure Digital Twins SDKs and custom applications.

Microsoft also provides sample applications (based on the SDKs) that can be used to upload your models:

 -  Azure Digital Twins-Explorer: The Azure Digital Twins-Explorer is a sample application for the Azure Digital Twins service. It lets you connect to an Azure Digital Twins instance and, among other things, can help you to upload and explore your models. The Azure Digital Twins-explorer can be found here: [Azure Digital Twins explorer](/samples/azure-samples/digital-twins-explorer/digital-twins-explorer/)
 -  Azure Digital Twins tools - UploadModels: If you have a large number of models to upload, or if the models have interdependencies that would make ordering individual uploads complicated, you may want to use the UploadModels tool. The tool accepts a list of models (including wildcard and glob support), validates the models using the digital twins parser, orders the models so that "root" models are uploaded first, and then uploads models in batches for fast uploading. The Azure Digital Twins UploadModels tool can be found here: [https://github.com/Azure/opendigitaltwins-tools/tree/main/ADTTools#uploadmodels](https://github.com/Azure/opendigitaltwins-tools/tree/main/ADTTools#uploadmodels). You can follow the instructions provided with the sample to configure and use this tool to upload models into your own instance.

## Update and version models

Once a model is uploaded to your Azure Digital Twins instance, the entire model interface is immutable, which means there's no traditional "editing" of models. Azure Digital Twins also doesn't allow reupload of the same model.

Instead, if you want to make changes to a model - such as updating displayName or description - the way to change the model is to upload a newer version of the model.

### Model versioning

To create a new version of an existing model, start with the DTDL of the original model. Update, add, or remove the fields you would like to change.

Next, mark the file as a newer version of the model by updating the ID field of the model. The last section of the model ID, after the ";" character, represents the model number. To indicate that the model version has been updated, increment the number at the end of the ID value. The ID value can be any number greater than the current version number.

For example, if your previous model ID looked like this:

```json
"@id": "dtmi:com:contoso:PatientRoom;1",

```

version 2 of this model might look like this:

```json
"@id": "dtmi:com:contoso:PatientRoom;2",

```

Then, upload the new version of the model to your instance.

This version of the model will then be available in your instance to use for digital twins. It does not overwrite earlier versions of the model, so multiple versions of the model will coexist in your instance until you remove them.

### Impact on twins

When you create a new twin, since the new model version and the old model version coexist, the new twin can use either the new version of the model or the older version.

Having an older version also means that uploading a new version of a model doesn't automatically affect existing twins. The existing twins will remain instances of the old model version.

You can update these existing twins to the new model version by patching them.

> [!NOTE]
> If you aren't familiar with JSON Patch, you can read more here: [JsonPatch in ASP.NET Core web API](/aspnet/core/web-api/jsonpatch)

## Remove models

Models can also be removed from the service in one of two ways:

 -  Decommissioning: Once a model is decommissioned, you can no longer use it to create new digital twins. Existing digital twins that already use this model aren't affected, so you can still update them with things like property changes and adding or deleting relationships.
 -  Deletion: This will completely remove the model from the solution. Any twins that were using this model are no longer associated with any valid model, so they're treated as though they don't have a model at all. You can still read these twins, but won't be able to make any updates on them until they're reassigned to a different model.

Decommissioning and deletion are separate features and they don't impact each other, although they may be used together to remove a model gradually.

### Decommissioning

Here's the C\# code to decommission a model:

```csharp
// 'client' is a valid DigitalTwinsClient
await client.DecommissionModelAsync(dtmiOfPlanetInterface);
// Write some code that deletes or transitions digital twins
//...

```

A model's decommissioning status is included in the ModelData records returned by the model retrieval APIs.

### Deletion

You can delete all models in your instance at once, or you can do it on an individual basis.

#### Before deletion: Deletion requirements

Generally, models can be deleted at any time.

The exception is models that other models depend on, either with an extends relationship or as a component. For example, if a ConferenceRoom model extends a Room model, and has a ACUnit model as a component, you can't delete Room or ACUnit until ConferenceRoom removes those respective references.

You can solve the dependency issue by updating the dependent model to remove the dependencies, or by deleting the dependent model completely.

#### During deletion: Deletion process

Even if a model meets the requirements to delete it immediately, you may want to take steps to avoid unintended consequences (for the twins left behind). Here are some steps that can help you manage the process:

1.  First, decommission the model.
2.  Wait a few minutes, to make sure the service has processed any last-minute twin creation requests sent before the decommission.
3.  Query twins by model to see all twins that are using the now-decommissioned model.
4.  Delete the twins if you no longer need them, or patch them to a new model if needed. You can also choose to leave them alone, in which case they'll become twins without models once the model is deleted. See the next section for the implications of this state.
5.  Wait for another few minutes to make sure the changes have percolated through.
6.  Delete the model.

To delete a model, use this call:

```csharp
// 'client' is a valid DigitalTwinsClient
await client.DeleteModelAsync(IDToDelete);

```

#### After deletion: Twins without models

Once a model is deleted, any digital twins that were using the model are now considered to be without a model. Queries aren't able to give you a list of the twins in this state—although you can still query the twins by the deleted model to know what twins are affected.

Here's an overview of what you can and can't do with twins that don't have a model.

Things you can do:

 -  Query the twin.
 -  Read properties.
 -  Read outgoing relationships.
 -  Add and delete incoming relationships (as in, other twins can still form relationships to this twin).
     -  The target in the relationship definition can still reflect the DTMI of the deleted model. A relationship with no defined target can also work here.
 -  Delete relationships.
 -  Delete the twin.

Things you can't do:

 -  Edit outgoing relationships (as in, relationships from this twin to other twins).
 -  Edit properties.

#### After deletion: Reuploading a model

After a model has been deleted, you may decide later to upload a new model with the same ID as the one you deleted. Here's what happens in that case.

 -  From the solution store's perspective, this is the same as uploading a new model. The service doesn't remember the old one was ever uploaded.
 -  If there are any remaining twins in the graph referencing the deleted model, they're no longer orphaned. The reused model ID is valid again with the new definition. However, if the new definition for the model is different than the model definition that was deleted, these twins may have properties and relationships that match the deleted definition and aren't valid with the new one.

Azure Digital Twins doesn't prevent this state, so be careful to patch twins appropriately in order to make sure they remain valid through the model definition switch.