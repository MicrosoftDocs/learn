Visual Studio Code provides a customizable IDE that enables you to build, test, and run Node.js applications.

In the sample scenario, you want to use Visual Studio Code as the development environment for creating and testing your Node.js applications.

In this exercise, you'll install node packages that enable you to configure Node.js for use in Visual Studio Code. You'll use this environment to write an application that prompts the user for details of students. The application then creates JavaScript objects that capture this information.

In the next exercise, you'll see how to save these objects to a container in Azure Databases extension.

This exercise runs on your desktop computer and uses an Azure sandbox for your resources.

> [!NOTE]
> This exercise assumes that you've already installed **Node.js** and **npm** on your desktop computer.

## Configure Node.js

1. Start Visual Studio Code if it isn't already running.

2. On the **Terminal** menu, select **New Terminal**.

3. In the **Terminal** window, run the following command to create a new folder named **grades** for the Node application.
  
    ```bash
    mkdir grades
    ```

4. Enter the following commands to move to the **grades** folder, and initialize a new Node application.

    ```bash
    cd grades
    npm init -y
    ```

    The **npm init** command creates a **package.json** file and displays its contents. This file contains the initial metadata for the application, containing a default name, description, and entry point.

5. On the **File** menu in Visual Studio Code, select **Open Folder**, and then open the **grades** folder.

6. In the **Explorer** window, select the **package.json** file.

    :::image type="content" source="../media/5-edit-package.png" alt-text="Screenshot of Visual Studio Code. The user is editing the package.json file." loc-scope="vs-code":::

7. In the editor pane, change the **description** property to **Student and course grades maintenance**, and change the **main** property to **studentgrades.js**. The file should look like this.

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

8. On the **File** menu, select **Save**.

9. In the **Terminal** window, run the following commands to install the **readline-sync**, and **\@types/node** packages.

    ```bash
    npm install readline-sync
    npm install @types/node
    ```

    The **readline-sync** package contains functions that enable you to gather user input from the command line. The **\@types/node** package contains additional type definitions for Node.js.

    > [!NOTE]
    > You can ignore any **No repository field** warnings that appear for now.

## Create the studentgrades app

1. In Visual Studio Code, on the **File** menu, select **New File**.

2. On the **File** menu, select **Save As**. Save the new file with the name **studentgrades.js**.

3. In the editor window, add the following lines to the top of the **studentgrades.js** file.

    ```javascript
    //@ts-check
    var question = require('readline-sync').question;
    ```

    The **\@ts-check** directive enables advanced type checking, using the **\@types/node** module that you added to the application in the previous task. The **require** statement imports the **question** function from the **readline-sync** module. You'll use the **question** function to prompt the user for input later in this application.

4. After the **require** statement, add the following **class** definition to the file.

    ```javascript
    class Student {
        constructor(ID, studentNumber, forename, lastname) {
            this.id = ID;
            this.StudentNumber = studentNumber;
            this.Forename = forename;
            this.Lastname = lastname;
            this.CourseGrades = [];
            this.addGrade = function (coursename, grade) {
                this.CourseGrades.push({Course: coursename, Grade: grade});
            };
            this.toString = function () {
                return `${this.StudentNumber}: ${this.Forename}, ${this.Lastname}\n`;
            };
            this.getGrades = function () {
                let grades = "";
                this.CourseGrades.forEach (function(coursegrade) {
                    grades = `${grades}${coursegrade.Course}:${coursegrade.Grade}\n`;
                });
                return grades;
            };
        }
    }
    ```

    The **Student** class represents a student. It has the properties **id**, **StudentNumber**, **Forename**, **Lastname**, and **CourseGrades**. The **CourseGrades** property is an object. This object will contain course code/course grade key/value pairs for the student. The **addGrade** method enables a user to add a course code/course grade pair to this property. The **getGrades** function returns a formatted string listing the course codes and grades for the student. The **toString** function returns a string containing the other details of the student.

    > [!NOTE]
    > It's important to distinguish between the **id** field, which is used by Azure Databases extension to identify the document, and the **StudentNumber** field, which is used to reference a student. The data in the **id** field is immutable, whereas the **StudentNumber** field may change over time.

5. Add the **getStudentData** function shown below to the **studentgrades.js** file, after the **Student** class.

    ```javascript
    function getStudentData () {
        let ID = question("Please enter the student's document ID: ");
        let studentNumber = question("Enter the student's number: ");
        let forename = question("Enter the student's forename: ");
        let lastname = question("Enter the student's last name: ");
        let student = new Student(ID, studentNumber, forename, lastname);
        return student;
    };
    ```

    This function prompts the user for the details of a student and creates a new **Student** object.

6. Add the following function to the **studentgrades.js** file.

    ```javascript
    function test () {
        let student1 = getStudentData();
        student1.addGrade("Computer Science", "A");
        student1.addGrade("Applied Mathematics", "C");

        process.stdout.write(student1.toString());
        process.stdout.write(student1.getGrades());

        let student2 = getStudentData();
        student2.addGrade("Computer Science", "A");

        process.stdout.write(student2.toString());
        process.stdout.write(student2.getGrades());
    }
    ```

    This function is a test harness that asks the user to input information for two students. The function adds grades for each student and displays the results.

7. Add the following statement at the end of the file.

    ```javascript
    test();
    ```

    This statement runs the test harness.

## Test the studentgrades app

You'll now run the app and verify that the **Student** class creates student objects and can assign grades correctly. You'll use the test harness to prompt the user for the details of two students. The details of the students and the course grades assigned by the test harness will be displayed.

The application doesn't store student information in the Azure Databases extension. You'll see how to do that in the next exercise.

1. In the **Terminal** window, start the **studentgrades** app using **node**.

    ```bash
    node studentgrades.js
    ```

2. At the prompts, enter the values shown in the following table.

    | Prompt  | Value  |
    |---|---|
    | Please enter the student's document ID: | S001 |
    | Enter the student's number: | 001 |
    | Enter the student's forename: | EEE |
    | Enter the student's lastname: | FFF |

    The following messages should be displayed, output by the statements `process.stdout.write(student1.toString());` and `process.stdout.write(student1.getGrades());` in the `test` function.

    ```text
    001: EEE, FFF
    Computer Science:A
    Applied Mathematics:C
    ```

3. At the next set of prompts, enter the following values.

    | Prompt  | Value  |
    |---|---|
    | Please enter the student's document ID: | S002 |
    | Enter the student's number: | 002 |
    | Enter the student's forename: | GGG |
    | Enter the student's lastname: | HHH |

    The following messages should appear.

    ```text
    002: GGG, HHH
    Computer Science:A
    ```

    These are the details of the second student, and the grade for the only course that the student took.

You've now seen how to use Visual Studio Code to create, edit, and run a Node.js application.
