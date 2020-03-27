## Title

Create and publish an Express.js web application with Azure App Service and VS Code

## Role(s)

- Developer

## Level

- Beginner

## Product(s)

- Azure App Service
- VS Code

## Prerequisites

- Familiarity with web app concepts
- Beginner-level programming knowledge

## Summary

Create a JavaScript web application with Express.js and VS Code and publish it to Azure App Service.

## Learning objectives

1. Create an Express.js web application in VS Code
1. Publish the app to Azure App Service
1. Update the app in VS Code and publish the updates

## Chunk your content into subtasks

| Subtask                                           | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet?  | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ------------------------------------------------- | ------------------------------------------------------------ | -------------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------------------ |
| Create an Express.js web application in VS Code   | Create an Express.js web application in VS Code              | Exercise                                                 | Create an Express.js web application in VS Code   | Yes                                                          |
| Publish the app to Azure App Service              | Publish the app to Azure App Service                         | Exercise                                                 | Publish the app to Azure App Service              | Yes                                                          |
| Update the app in VS Code and publish the updates | Update the app in VS Code and publish the updates            | Exercise                                                 | Update the app in VS Code and publish the updates | Yes                                                      |

## Outline the units

1. **Introduction**

    You work as a web developer for a video game studio. Your organization is launching a brand new video game they have been developing in secret. This year's biggest video game expo is happening in just a few weeks. The studio wants a brand new website to be ready for the launch as soon as possible to maximize exposure. The site must have a live countdown to the date of the studio's on-stage announcement where they'll finally reveal their new video game. The studio isn't sure about the exact details they want to put up on the website, but they'll know closer to the day of their announcement. You must be able to easily and rapidly update the site with the details when the time comes.

2. **Create an Express.js web application with Visual Studio Code**
    - What is Node.js (brief overview only)?
    - Considerations for installing Node.js
        - How to install Node.js
    - Considerations for installing Express.js
        - How to install Express.JS
        - What does the Express Generator do?
    - Creating an Express.js application using Visual Studio Code
        - Structure of an Express.js application
        - Deploy your Express.js application to test locally

3. **Exercise - Create an Express.js web application with Visual Studio Code**
    - Set up the integrated terminal in Visual Studio Code
    - Install Node.js
    - Install the Express Generator
    - Scaffold an Express.js application
    - Set up a template engine for Express.js
    - Use a route with a template to render a countdown
    - Test your application

4. **Publish your application to Azure App Service with Visual Studio Code**
    - What is Azure App Service?
        - What is an Azure App Service plan?
        - Options for creating an Azure App Service plan
    - Why use Azure App Service for your application?
    - Describe the deployment process through Visual Studio Code
    - Describe the debugging process through Visual Studio Code

5. **Exercise - Publish your application to Azure App Service with Visual Studio Code**
    - Install the Azure App Service extension
    - Sign in to your Azure account through the Azure Explorer
    - Deploy a new Azure App Service Web App using the Azure App Service extension
    - Browse your web app
    - Debug your web app

6. **Update the app in Visual Studio Code and publish the updates**
    - What are a production and test environments?
    - Deployment slots
        - Make changes for the appropriate slot (production or testing)
        - Swap and rollback deployment slots
        - Auto swap for continuous development
    - Push updates with Visual Studio Code

7. **Exercise - Update the app in Visual Studio Code and publish the updates**
    - Make changes to your web app using Visual Studio Code
    - Push your changes to Azure App Service

8. **Summary**

    Your organization needed you to rapidly create a website for their upcoming video game event. You needed to be able to easily and rapidly make changes to the site whenever changes were required.  You decided to create an Express.js application using Visual Studio Code and publish your application to Azure App Service for hosting. Azure App Service also made it possible for you to easily publish any updates to your website.

## Notes

This is effectively the JavaScript/VS Code/Linux App Service version of https://docs.microsoft.com/en-us/learn/modules/publish-azure-web-app-with-visual-studio/