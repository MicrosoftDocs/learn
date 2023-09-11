
Now that you have the basic skeleton of your React application, let's customize it a bit, by adding a simple graphical user interface (GUI), enabling the user to interact with the computer vision models.

## Specification

In your App.js file, clean up the 'App' function of the template and replace it with the javascript code needed to create a simple GUI with the following elements:

- A title
- A text box to enter the URL of the image to be analyzed or the prompt of the image to generate
- A button to trigger the image analysis and one to trigger image generation

In this phase, you don't have yet the backend code handling Azure AI services calls, so the buttons will not trigger any action yet. You will add that in the next exercises.
If you wish, you can further customize your GUI by adding an App.css file and defining the style of the elements in your web page.

> [!TIP]
> You can use the [React State Hooks](https://react.dev/reference/react) to enable your application 'remember' the user input and the position of the cursor in the text box.

## Check your work

To validate the work done in this exercise, run your React app locally (using `npm start` command) and open the URL <http://localhost:3000> in a browser. You should see a web page with a title, a text box and two buttons, like the one below:
![Application GUI](../media/app_GUI.png)

> [!WARNING]
> You might get an *ERR_OSSL_EVP_UNSUPPORTED* error when running your app locally. This error message indicates that something within your web development stack isn’t compatible with the [OpenSSL](https://www.openssl.org/) files you’re running.
> To fix this, you need to upgrade your development tools (Node.js, React.js, etc.) to the latest version. You can find a complete guide [here](https://kinsta.com/knowledgebase/err_ossl_evp_unsupported/).
>If you don’t want to upgrade them for any reason, you can simply enable the [OpenSSL 3.0 legacy provider](https://nodejs.org/api/cli.html#--openssl-legacy-provider) as a workaround, with the command:
>`set NODE_OPTIONS=--openssl-legacy-provider`

> [!TIP]
> Would you like to have an AI pair programmer while you code? Install [GitHub Copilot visual studio extension](https://aka.ms/get-copilot?WT.mc_id=academic-105496-cacaste) to get inline suggestions.
