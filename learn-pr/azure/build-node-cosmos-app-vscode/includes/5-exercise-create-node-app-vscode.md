Visual Studio Code provides a customizable IDE that enables you to build, test, and run Node.js applications.

In the sample scenario, you want to use Visual Studio Code as the development environment for creating and testing your Node.js applications.

In this exercise, you'll install node packages that enable you to configure Node.js for use in Visual Studio Code. You'll use this environment to write an application that prompts the user for details of courses, students, and grades, and creates JavaScript objects that capture this information (in the next exercise, you'll see how to save these objects to a collection in Cosmos DB). You'll learn how to use the debugger provided with Visual Studio Code to step through the code and verify that it is working correctly.

This exercises runs on your desktop computer.

> [!NOTE]
> This exercise assumes that you've already installed **Node.js** and **npm** on your desktop computer.

## Configure Node.js

1. Start Start Visual Studio Code if it isn't already running.

2. On the **Terminal** menu, click **New Terminal**.

3. In the **Terminal** window, run the following command to create a new folder named **greds** for the Node application.
  
  ```bash
  mkdir grades
  ```

4. Type the following commands to move to the **grades** folder, and initializes a new Node application:

  ```bash
  cd grades
  npm init -y
  ```

  The **npm init** command creates a **package.json** file and displays its contents. This file contains the initial metadata for the application, containing a default name, description, and entry point.

5. On the **File** menu in Visual Studio Code, select **Open Folder**, and open the **grades** folder.

6. In the **Explorer** window, click the **package.json** file.

    ![Screenshot of Visual Studio Code. The user is editing the **package.json** file](../media/5-edit-package.png)

7. In the editor pane, change the **description** property to **Student and course grades maintenance**, and change the **main** property to **studentgrades.js**. The file should look like this:

  ```text
  {
    "name": "grades",
    "version": "1.0.0",
    "description": "Student and course grades maintenance",
    "main": "studentgrades.js",
    "scripts": {
      "test": "echo \"Error: no test specified\" && exit 1"
    },
    "keywords": [],
    "author": "",
    "license": "ISC"
  }
  ```

8. On the **File** menu, click **Save**.

9. In the **Terminal** window, run the following commands to install the **esm**, **readline-sync**, and **@types/node** packages:

  ```bash
  npm install esm
  npm install readline-sync
  npm install @types/node
  ```

  The **esm** package provides support for ECMAScript 6 and later. The **readline-sync** package contains functions that enable you to gather user input from the command line. The **@types/node** package provides support for type checking and error reporting in the IDE.

  > [!NOTE]
  > You can ignore the **No repository field** warning, and the **extraneous** messages that appear.

## Create the studentgrades app



