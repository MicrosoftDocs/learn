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

1. In Visual Studio Code, on the **File** menu, click **New File**.

2. On the **File** menu, click **Save As**. Save the new file with the name **studentgrades.js**

3. In the editor window, add the following lines to the top of the **studentgrades.js** file:

  ```javascript
  //@ts-check
  import { question } from 'readline-sync';
  ```

  The **@ts-check** directive enables advanced type checking, using the **@types/mode** module that you added to the application in the previous task. The **import** statement imports the **question** function from the **readline-sync** module. You'll use the **question** function to prompt the user for input later in this application.

4. After the **import** statement, add the following **class** definition to the file:

  ```javascript
  class Course {
    constructor(coursecode, coursename, academicyear) {
      this.coursecode = coursecode;
      this.coursename = coursename;
      this.academicyear = academicyear;
      this.toString = function () {
          return `${this.coursecode}: ${this.coursename}, ${this.academicyear}\n`;
      };
    }
  }
  ```

  The **Course** class contains the details of a course. A **Course** object has three properties; **coursecode**, **coursename**, and **academicyear**. These properties correspond to the fields in a **Course** document in Cosmos DB. The class also contains a function named **toString** that you can use to convert the contents of a Course object into a formatted string, suitable for display.

5. Add the following **Student** class to the file, after the **Course** class:
  
  ```javascript
  class Student {
    constructor(studentid, forename, lastname, academicyear) {
      this.studentid = studentid;
      this.academicyear = academicyear;
      this.name = new function Name() {
        this.forename = forename;
        this.lastname = lastname;
      };
      this.coursegrades = {};
      this.addGrade = function (course, grade) {
        this.coursegrades[course.coursecode] = grade;
      };
      this.toString = function () {
        return `${this.studentid}: ${this.name.forename}, ${this.name.lastname}, ${this.academicyear}\n`;
      };
      this.getGrades = function () {
        var grades = "";
        for (var coursecode in this.coursegrades) {
          grades = `${grades}${coursecode}: ${this.coursegrades[coursecode]}\n`;
        }
        return grades;
      };
    }
  }
  ```

  The **Student** class represents a student. It has the properties **studentid**, **academicyear**, **name**, and **coursegrades**. The **name** property is a composite type containing the **forename** and **lastname** properties. The **coursegrades** property is an object. This object will contain course code/course grade key/value pairs for the student. The **addGrade** method enables a user to add a course code/course grade pair to this property, and the **getGrades** function returns a formmatted string listing the course codes and grades for the student. The **toString** function returns a string containing the other details of the student.

6. Add the **getCourseData** function shown below to the **studentgrades.js** file.

  ```javascript
  function getCourseData () {
    var coursecode = question("Course code: ");
    var coursename = question("Course name: ");
    var academicyear = question("Academic year: ");
    var course = new Course(coursecode, coursename, academicyear);
    return course;
  };
  ```

  This function prompts the user for the code, name, and academic year of a course using the **question** function from the **readline-sync** module imported earlier. The values read are used to create a new **Course** object. The object is passed back as the return value of the function.

7. Add the **getStudentData** function shown below to the **studentgrades.js** file.

  ```javascript
  function getStudentData () {
    var studentid = question("Student id: ");
    var forename = question("Forename: ");
    var lastname = question("Lastname: ");
    var academicyear = question("Academic year: ");
    var student = new Student(studentid, forename, lastname, academicyear);
    return student;
  };
  ```

  This function prompts the user for the details of a student, and creates a new **Student** object.

8. Add the following function to the **studentgrades.js** file:

  ```javascript
  function test () {
    var course1 = getCourseData();
    process.stdout.write(course1.toString());

    var course2 = getCourseData();
    process.stdout.write(course2.toString());

    var student1 = getStudentData();

    var student2 = getStudentData();

    student1.addGrade(course1, "A");
    student1.addGrade(course2, "C");
    student2.addGrade(course2, "A");

    process.stdout.write(student1.toString());
    process.stdout.write(student1.getGrades());

    process.stdout.write(student2.toString());
    process.stdout.write(student2.getGrades());
  }
  ```

  This function is a test harness that creates two courses and two students. The function that adds grades foreach student, and displays the results.

9. Add the following statement at the end of the file:

  ```javascript
  test();
  ```

  This statement runs the test harness.

## Test the studentgrades app

1. In the **Terminal** window, start the **studentgrades** app using **node**:

  ```bash
  node -r esm studentgrades.js
  ```

  > [!NOTE]
  > The **-r esm** flag loads the **esm** module to run the app. This module contains the ECMAScript 6 support code, and is required by the **studentgrades.js** app. Features such as **import** are only available in ECMAScript 6 and later.

2. At the prompts, enter the values shown in the following table:

  | Prompt  | Value  |
  |---|---|
  | Course code: | C101 |
  | Course name: | Computer Science |
  | Academic year: | 2019 |

  The message **C101: Computer Science, 2019** should appear after you have entered the academic year. This is the output from the statement `process.stdout.write(course1.toString());` in the `test` function.

3. At the next set of prompts, enter the following values:

  | Prompt  | Value  |
  |---|---|
  | Course code: | C102 |
  | Course name: | Statistics |
  | Academic year: | 2019 |

  The message **C102: Statistics, 2019** should be displayed, output by the statement `process.stdout.write(course2.toString());` in the `test` function.

4. Enter the following values when prompted:

  | Prompt  | Value  |
  |---|---|
  | Student id: | 1 |
  | Forename: | Aaaaaa |
  | Lastname: | Bbbbbb |
  | Academic year: | 2019 |
  | Student id: | 2 |
  | Forename: | Cccccc |
  | Lastname: | Dddddd |
  | Academic year: | 2019 |

  The following messages will appear:

  ```text
  1: Aaaaaa, Bbbbbb, 2019
  C101: A
  C102: C
  2: Cccccc, Dddddd, 2019
  C102: A
  ```

  The first line contains the details of the first student, printed by the statement `process.stdout.write(student1.toString());` 
  
  The next two lines are the grades that were assigned to the student by the `addGrades` function. The grade information was printed using the statement `process.stdout.write(student1.getGrades());`

  The remaining two lines are the details of the second student, and the grade for the only course that the student took.

## Step through the studentgrades.js app using the debugger

TBD
- Configure the debugger
- Set a breakpoint
- Step through
- Examine the course1 and student1 objects after they have been created
- Examine the student1 object after grades have been assigned
