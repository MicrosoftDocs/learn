To create an interactive application, you need to be able to modify data and respond to user requests. In React, this functionality is managed through state and events. 

*State* is data that can be updated and shared between components throughout your application. *Events* allow you to handle all the ways a user can interact with your application: the clicks, typing, and taps.

## Objectives

In this module, you'll:
- Add state to an application.
- Add event handlers.
- Use the Effect Hook to respond to state changes.

## Prerequisites

- Knowledge of JavaScript, HTML, and CSS
- Basic understanding of React components
- A code editor, such as [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true)
- [Node.js](https://nodejs.org/?azure-portal=true) installed locally
- [Git](https://git-scm.com/downloads/?azure-portal=true) installed locally
- The starter project described in the following section

### Clone the project

This module uses a starter project. Clone the project and open it in Visual Studio Code.

1. To get the starter project, run the following steps in a command window or a terminal window. This step clones the repository and opens the starter folder in Visual Studio Code.

    ````bash
    # Windows
    git clone https://github.com/MicrosoftDocs/mslearn-react
    cd mslearn-react\\code\\3-state-events\\starter
    code .

    # macOS or Linux
    git clone https://github.com/MicrosoftDocs/mslearn-react
    cd mslearn-react/code/3-state-events/starter
    code .
    ````

1. In Visual Studio Code, open the integrated terminal by selecting **View** > **Terminal**. Or select **Ctrl+\`**. (On a Mac, select **Cmd+\`**.)
1. In the terminal, run the following code to install the necessary packages and start the development server.

    ```bash
    npm install
    npm start
    ```

1. Your default browser should automatically open. If it doesn't, open your browser and go to http://locahost:8080. The starter page opens.
