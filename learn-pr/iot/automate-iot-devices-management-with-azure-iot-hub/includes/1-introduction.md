Azure IoT Hub is a cloud service designed to be your cloud gateway for IoT devices. It allows to establish a secure bidirectional communication between IoT devices and the cloud to not only collect data from sensors, but also allow for remote monitoring and management of the devices.

In this module, you'll learn how IoT Hub can be used to configure and manage IoT devices remotely at scale.

## Learning objectives

In this module you will:

- Create a custom Azure IoT Hub, using the Azure CLI
- Create IoT Hub device IDs, using the Azure CLI
- Create an app that will simulate a device implementing a firmware update in C#
- Test a simple firmware update setting it up and initiating it from the Azure Portal
- Use the Automatic device management feature of Azure IoT Hub to automate the firmware update on several groups of devices in sequence, using the Azure CLI

## Prerequisites

- An introductory knowledge of Azure IoT
- Ability to navigate the Azure IoT portal
- Ability to use the Azure CLI
- Ability to use C#, at the beginner level
- Experience using Visual Studio Code, at the beginner level

## Learn the scenario

Suppose you manage a company that offers a solution to maintain and monitor cheese caves' temperature and humidity at optimal levels. You have been working with gourmet cheese making companies for a long time and established long term trust with these customers who value the quality of your product.
Your solution consists in sensors and a climate system installed in the customer's cave that report in real time on the temperature and humidity and an online portal customers can use to monitor and remotely operate their devices to adapt the temperature and humidity to the type of cheese they stored in their cave or to fine tune the environment for perfectly aging their cheese.
Your company is always enhancing the software running on the devices to better adapt to your customers different cheeses and diverse types of rooms they use to store their cheese. In addition to the features updates, you also want to make sure the devices deployed at customers locations have the latest security patches to ensure privacy and prevent hackers from taking control of the system, considering IoT devices are physically accessible and more prone to being compromised. In order to do this, you need to keep the devices up to date by remotely updating their firmware.

## What you will do in this module

In the following units you will go through these steps:

- Setup an Azure IoT environment: an Azure IoT Hub instance and device Ids
- Write code for simulating the device that will implement the firmware update
- Test the firmware update process on a single device using Azure IoT Hub automatic device management in the Azure Portal
- Setup an automatic device management configuration to deploy the firmware update on a group of devices using the Azure CLI