Azure IoT Hub is a cloud service designed to be your cloud gateway for IoT devices. It allows securely connect millions of devices and establish a bidirectional communication to not only collect data from sensors, but also allow for remote monitoring and management of the devices.

In this module, you'll learn how IoT Hub can be used to configure and manage IoT devices remotely at scale.

## Learning objectives

In this module you will:

- Create a custom Azure IoT Hub, using the Azure CLI
- Create IoT Hub device IDs, using the Azure CLI
- Create an app that will simulate a device implementing a firmware update in C#
- Test a simple firmware update setting it up and initiating it from the Azure Portal
- Use the Automatic device management feature of Azure IoT Hub to automate the firmware update on several groups of devices in sequence


## Prerequisites

- An introductory knowledge of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use the Azure CLI
- Ability to use C#, at the beginner level
- Experience using Visual Studio Code, at the beginner level

## Learn the scenario

Suppose you manage a gourmet cheese making company in a southern location. The company is proud of its cheese, and is careful to maintain the perfect temperature and humidity of a natural cave that is used to age the cheese. There are sensors in the cave that report on the temperature and humidity. A remote operator can set a fan to new settings if needed, to maintain the perfect environment for the aging cheese. The fan can heat and cool, and humidify and de-humidify.
Your company is always enhancing the software running on the devices to better adapt to different types of cheeses and customers diverse types of rooms they use to store their cheese. In addition to the software updates, you also want to make sure the devices deployed at customers locations have the latest security patches to ensure privacy and prevent hackers to take control of the system. In order to do this, you need to keep the devices up to date by remotely updating their firmware.