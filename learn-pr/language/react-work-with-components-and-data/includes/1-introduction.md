Components are reusable, self-contained units, and make up the core of any React application. Components can have their own properties (or *props*), which allow you to pass data into a component, making it reusable across different scenarios. You're also able to use complex data beyond strings and primitive types, giving your components even more power.

## Objectives

In this module, you learn how to:

- Display dynamic data.
- Display lists of data.
- Add properties (props) to components.
- Use objects and complex data types.

## Prerequisites

### Skills

- Knowledge of HTML, CSS, and JavaScript
- Basic knowledge of React and React components
- Knowledge of package management with Node.js and `npm`
- Knowledge of Git

### Locally installed software

- [Node.js](https://nodejs.org/?azure-portal=true)
- A code editor, such as [Visual Studio Code](https://code.visualstudio.com/?azure-portal=true)
- [Git](https://git-scm.com/?azure-portal=true)

## Clone the project and open the code in Visual Studio Code

This module uses a starter project.

1. To get the starter project, run the following in a command or terminal window to clone the repository and open the starter folder in Visual Studio Code:

    ````bash
    # Windows
    git clone https://github.com/MicrosoftDocs/mslearn-react
    cd learn-react\\code\\2-component-events\\starter
    code .

    # macOS or Linux
    git clone https://github.com/MicrosoftDocs/mslearn-react
    cd learn-react/code/2-component-events/starter
    code .
    ````

1. Open the integrated terminal inside Visual Studio Code by selecting **View** > **Terminal** (or **Ctl-\`** or **Cmd-\`** on a Mac).
1. Run the following code in the terminal to install the necessary packages and start the development server:

    ```bash
    npm install
    npm start
    ```

1. Your default browser automatically opens. If it doesn't, open your browser and go to `http://locahost:8080`. The starter page appears.
