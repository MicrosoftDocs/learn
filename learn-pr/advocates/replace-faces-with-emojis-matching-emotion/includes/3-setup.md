## Face API registration

Once you have your Azure sandbox subscription, you can add a Face API resource and obtain the Face API URL and key needed to connect to this API.

1. Go to the [Azure Cognitive Services Face Service](https://azure.microsoft.com/en-us/pricing/details/cognitive-services/face-api/) and click on **Try Face**. Click on the **Sign In** button in the **Existing Azure Account** box. This will take you to the Azure Portal and open the **Create Face** dialog box. Enter the following information:

    - a name for the Azure Face resource
    - `Concierge Subscription` for the subscription
    - leave the location at its default value
    - `F0` for pricing tier
    - **<rgn>Sandbox Resource Group</rgn>** for the Resource Group

1. Once the Azure resource has been deployed successfully, go to this resource and make a note of the API **Endpoint** and **keys**. You will need one of the keys to call the Face API. You can use either of the keys.

## Slack workspace

To create a Slack command, you need administrator privileges for a Slack workspace.

1. If you already have a Slack workspace where you have admin privileges, you can use that. You can also [create a brand new Slack workspace](https://slack.com/create?azure-portal=true).

## Local setup

You do most of the exercises in this module on your local machine, deploying to your Azure sandbox as the final step.

1. Install Visual Studio Code

    If you don't have it already, download and install [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)

1. Add Azure Extensions to Visual Studio Code

    If you don't have them already, install these Visual Studio Code extensions:
    - [Azure Account](https://marketplace.visualstudio.com/items?azure-portal=true&itemName=ms-vscode.azure-account)
    - [Azure Functions](https://marketplace.visualstudio.com/items?azure-portal=true&itemName=ms-azuretools.vscode-azurefunctions)

1. Install node and npm

   If you don't already have them installed locally on your machine, Install [node and npm](https://nodejs.org/en/download?azure-portal=true) for your operating system.

1. Clone the starter code

    Cloning the starter code will help you get the most out of this module. All of the code you need to complete the app, and some initial bootstrap code, is available for free to get you started.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-the-mojifier.git
    ```

    You should be able to complete the project using the code provided, but if you can't figure something out, then you can find the completed code in the `completed` branch.

1. Change into the directory containing the cloned source repository, then install the required packages:

    ```bash
    cd mslearn-the-mojifier
    npm install
    ```

1. Compile the TypeScript code into JavaScript

    You are going to write your app using TypeScript. TypeScript has support for type-checking and class definitions, which we will make use of in our Mojifier code. Node.js does not know how to run TypeScript, so as you develop, you'll need to convert your TypeScript code to JavaScript. The TypeScript compiler `tsc` is installed when you run the `npm install` command above, and the `package.json` is configured to run it in the build stage. Run the following command:

    ```bash
    npm run build
    ```

    Keep this command running in a terminal shell. This watches for any changes to the TypeScript files and converts them to JavaScript files. If you aren't seeing the behavior you expect in the exercises, check the console output in the terminal window as there may be errors in your TypeScript code.
