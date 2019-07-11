Imagine you run a packaging business that ships products all over the world. Your company has invested heavily in automation to pack and optimize the size of each shipped box but has gotten some complaints around torn or damaged packaging. The product assurance team is evaluating how to inspect packaged products before shipping and wants to automate the inspection process and only involve a person if the packaging is determined to be defective.

The Microsoft Cognitive **Custom Vision Service** combines artificial intelligence and machine learning to provide a sophisticated image classification and detection service.

<!-- should we try to create an image that matches our scenario? -->

![Screenshot showing the process that the Custom Vision Service uses to take raw data, identify shapes, and then correlate to a specific classification.](../media/1-api-header.png)

These capabilities can be used directly through the Custom Vision Service web portal to create and train a model, test it for accuracy, and then use the model to evaluate and apply labels to images. However, this isn't sufficient for your use case, instead your development team wants to leverage the REST-based APIs that allow custom applications and scripts to take advantage of the same Custom Vision Service capabilities provided in the web portal. Using the Custom Vision Service APIs, your company can integrate this Cognitive Service directly into your existing automation process to quickly and accurately identify bad packages before they are shipped to customers.

In this module, you will:

- Evaluate the requirements for service authorization
- Examine the APIs involved in performing image prediction
- Examine the APIs involved in training predictive models

<!-- TODO: make sure our above objectives are matched in the YML -->