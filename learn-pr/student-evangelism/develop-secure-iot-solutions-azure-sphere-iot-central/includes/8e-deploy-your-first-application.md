In this unit you will learn how to configure and deploy you first application to your Azure Sphere

------

## Declaring IoT Central network endpoints

You will grant in the application rights to your Azure Sphere application so it can connect to your IoT Central application.  

------

## Hardware definitions

Azure Sphere hardware is available from multiple vendors, and each vendor may expose features of the underlying chip in different ways. Azure Sphere applications manage hardware dependencies by using hardware definition files. For further information, review the [Managing target hardware dependencies](https://docs.microsoft.com/azure-sphere/app-development/manage-hardware-dependencies) article.

The labs for this learning module have a set of hardware definition files for the AVNET and SEEED Studio Azure Sphere developer boards. The **azure_sphere_learning_path** hardware definition file is included in main.c for each lab.

```c
#include "hw/azure_sphere_learning_path.h"
```

You will learn how to select the hardware definition file that matches your Azure Sphere device in the following exercise.
