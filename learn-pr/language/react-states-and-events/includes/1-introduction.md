Creating an interactive application requires the ability to modify data and respond to user requests. In React, this is managed through state and events. State is data which can be updated and shared between various components throughout your application as needed. Events allow you to handle all the different ways a user can interact with your application - the clicks, typing, and taps.

## Objectives

- Add state to an application
- Add event handlers
- Use the Effect Hook to respond to state changes

## Prerequisites

- Knowledge of JavaScript, HTML and CSS
- Basic understanding of React components
- A code editor, such as [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true)
- [Node.js](https://nodejs.org/?azure-portal=true) installed locally
- [Git](https://git-scm.com/downloads/?azure-portal=true) installed locally
- The [starter project](#clone-the-project)

## Clone the project

This module uses a starter project. Clone the starter and open it in Visual Studio Code.

1. To obtain the starter project, execute the following steps in a command or terminal window to clone the repository and open the starter folder in Visual Studio Code:

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

1. Open the integrated terminal inside Visual Studio Code by selecting **View** > **Terminal** (or **Ctl-\`** or **Cmd-\`** on a Mac)
1. Execute the following code in the newly opened terminal inside Visual Studio Code to install the necessary packages and start the development server:

    ```bash
    npm install
    npm start
    ```

1. Your default browser should automatically open. If it doesn't, open your browser and navigate to `http://locahost:8080`. The starter page will be displayed.
