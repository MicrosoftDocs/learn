To use the Language Understanding service to develop a natural language understanding solution, you require two kinds of resource in your Azure subscription:

- An ***Authoring*** resource (which must be a **Language Understanding - Authoring** resource) that you can use to train your language understanding model.
- A ***Prediction*** resource (which can be a **Language Understanding  - Prediction** or **Cognitive Services** resource) to host your trained model and process requests from client applications.

Authoring resources can be created in one of three global geographic areas:

- ***Asia Pacific*** (the resource is created in the **Australia East** Azure region)
- ***Europe*** (the resource is created in the **West Europe** Azure region)
- ***US*** (the resource is created in the **West US** Azure region)

To deploy a model, your prediction resource must be in an Azure location within the geographical area served by the authoring resource:

* **Asia Pacific**:
    * Australia East
* **Europe**:
    * France Central
    * North Europe
    * West Europe
    * UK South
* **US**
    * All other locations
