In your educational institution, you want to choose the most appropriate cloud lab environment for two different purposes: running classes for students and providing learning environments for new teachers. Both these environments will enable users to study class-related software while you control costs. However, you have different requirements for these solutions.

Here, you'll examine these scenarios in detail before choosing a hosting environment for each.

## Run classes

Your training classes will run on virtual machines that are based on the **Ubuntu Server** image in the Azure Marketplace. You have a shell script that installs the required software and configures it to a consistent starting point for the labs. Teachers sometimes choose to make minor modifications to this script for a class they're running.

During the training classes, up to 15 students complete the exercises simultaneously. Some students may need extra time to complete their work after the class has finished.

## Provide learning environments

For the cybersecurity classes, your virtual machine image includes an installation of software with regular updated builds provided through Azure DevOps build pipelines. This allows new teachers to get up to speed with the latest version of the software.