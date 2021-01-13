Azure Digital Twins enables an organization to track the past and predict the future, with regard to that organization's industrial or commercial environment. The key to this knowledge is creating working digital models that represent, to any degree of detail, physical devices and structures. The devices can range from focused IoT sensors to complex pieces of equipment. The structures can be production lines, whole factories, buildings, railway networks, shipping lines, or other environments relevant to the organization.

For example, by digitally modeling a production line, managers can predict the future based on past performance. You can also ask "what if" questions. You can digitally add new pieces of equipment, new production lines, and new transport to an existing system, and test for its effectiveness. These insights are available to you long before committing to purchasing and installing any physical equipment. The realism of the digital model is greatly enhanced by the use of IoT data to supply real-world sensor data to the digital simulation.

These objectives are the ultimate goals for digital twins. In this module, the goals are to explain by example the creation and purpose of digital models, and their representation and visualization in a connected graph. For this scenario, you're going to use the production line in a chocolate factory.

## Learning objectives

To summarize, in this module, you will:

- Create an instance of Azure Digital Twins by using the Azure portal
- Create digital models for the production line of a chocolate factory
- Validate the digital models by using a validator sample
- Create a graph of the models by using an explorer sample
- Query the graph by using SQL-like queries

## Prerequisites

- Introductory knowledge of the purpose of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use the command prompt and command-line windows
- Ability to download and install software tools
- Ability to use Visual Studio at the beginner level
- A basic understanding of the Azure CLI
  - You should install the Azure CLI locally.
  - You shouldn't use Azure Cloud Shell, as it will time out due to the length of the lab.
- Access to an Azure subscription where you have the administrator role for your account, as well as Azure Active Directory tenant to complete the exercise units

## The scenario

A chocolate manufacturing company, Contoso Chocolate, has one factory and one production line. Sales are going well, and you expect the company to grow. The company wants to determine the best course of action for growing operations while minimizing costs.

For this scenario, the production of chocolate has been simplified into three steps: *Roasting*, *Grinding*, and *Molding*. The following image shows the production line:

:::image type="content" source="../media/chocolate-production-line.png" alt-text="Diagram of a chocolate production line." lightbox="../media/chocolate-production-line.png":::

Cocoa beans are the input to this production line, and chocolate bars are the output!

1. **Roasting**: The roasting process cooks fermented cocoa beans. The temperature and time of cooking depends on the type of beans. Typically, though, roasting (sometimes called *fanning* in the chocolate trade) might take 35 minutes at 120 degrees to 150 degrees Celsius. Roasting aids the removal of unwanted stuff, such as acetic acid, and the formation of the sweet taste of cocoa.

1. **Grinding**: The grinding process takes the cocoa nibs that result from the roasting and crushes them to pieces, typically between steel plates, to create a liquid cocoa butter.

1. **Molding**: The molding process cools the cocoa butter in molds, giving the desired shape: chocolate bars, egg shells, and figures. The following image shows roasted cocoa nibs:

:::image type="content" source="../media/chocolate-nibs.png" alt-text="Photograph of roasted chocolate nibs." lightbox="../media/chocolate-nibs.png":::

You've been asked to advise on the correct growth path for the company. You have decided to use Azure Digital Twins to build a software solution flexible enough that no matter what questions the company owners might ask, you'll have a scientific and robust answer.

The first task is to build a digital model of the existing production line. This task is the objective of this module. Further Learn modules take the scenario further, exploring real-world data input, IoT sensors, time series insights, and, ultimately, simulation and advanced analysis.

The first step is to create an instance of an Azure Digital Twins resource.
