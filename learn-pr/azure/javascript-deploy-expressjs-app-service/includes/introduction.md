Deploy an Express.js (Node.js) app to Azure App Service from Visual Studio Code.

## Example scenario

Suppose you're a web developer or devops engineer who needs to deploy a web app to Azure. As an experienced developer, new to Azure, you'll learn how to deploy and configure the Azure resources needed to securely deploy the web app. The web app is a rental property app used by a company to help their employees relocate when needs. The app displays properties, an image about the properties, and some property information.

:::image type="content" source="../media/rental-app-website-browser.png" alt-text="Web browser showing main listing of rental app.":::

The rental property web app is built with Express.js. The user interface is created with simple JavaScript and served from the Express.js server. The web app uses fake data stored in a JSON file. The data is read in at runtime and kept in memory. The images are randomly generated. 

The entire source code is provided as part of this module. You won't be required to change the code.

## What will we be doing?

Here, you'll deploy a simple Express.js app to Azure App Service:

- **Use** the free Learn sandbox subscription and resource group
- **Create and configure** the Azure App Service for an Express.js app
- **Deploy** the web app from your local computer
- **View** the cloud-based files from your local computer
- **Analyze** web logs 

## What is the main goal?

By the end of this session, you'll be able to deploy and Express.js app on your own App Service resource and know that it is running as expected.