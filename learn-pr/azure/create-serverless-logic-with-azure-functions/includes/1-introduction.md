Imagine you work for an escalator company that has invested in IoT technology to monitor its product in the field. You oversee the processing of temperature sensor data from the drive gears of the escalators. You monitor the temperature data and add a data flag to indicate when the gears are too hot. In downstream systems, this data helps determine when maintenance is required.

Your company receives sensor data from several locations and from different escalator models. The data arrives in different formats, including batch file uploads, scheduled database pulls, messages on a queue, and incoming data from an event hub. You want to develop a reusable service that can process your temperature data from all these sources.

When designing a service such as this with traditional enterprise architecture strategies, you would need to consider server infrastructure and maintenance up front: scope out necessary hardware, plan to install it, coordinate with IT to manage it, and so on. An alternative to all that work is **serverless computing**. With serverless computing, your cloud provider manages the provisioning and maintenance of the infrastructure letting you focus completely on building the app logic. Azure Functions is a key component of the serverless computing offering from Azure and enables you to run pieces of code or *functions*, written in the programming language of your choice, in the cloud.

## Learning objectives

In this module, you will:

- Decide if serverless computing is right for your business need.
- Create an Azure function app in the Azure portal.
- Execute a function using triggers.
- Monitor and test your Azure function from the Azure portal.
