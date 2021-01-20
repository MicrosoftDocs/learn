The Azure Databases extension enables you to create and manage Azure databases, containers, and documents from within Visual Studio Code.

In the sample scenario, you want to work within Visual Studio Code Application, both as a development environment for building applications and as a tool for managing your Azure databases.

In this exercise, you'll install the Azure Databases extension for Visual Studio Code. Then you'll use the extension to connect to your Azure account and create an Azure account. You'll add a database and container for holding students' course grade information to the Azure Databases extension account. Finally, you'll create some test documents in the container, then view and update them.

This exercise runs on your desktop computer and uses an Azure sandbox for your resources.

> [!NOTE]
> This exercise assumes that you've already installed **Visual Studio Code** on your desktop computer.

## Install the Azure Databases extension for Visual Studio Code

1. Start Visual Studio Code. Select **Continue without code**.

1. On the **Extensions** menu at the top, select **Manage Extensions** to open the extensions pane.

1. In the **Search** box, enter **Azure Databases**, and press <kbd>Enter</kbd>.

1. In the list of extensions, select the **Azure Databases** extension published by Microsoft, and then select **Download**. Install the package when the download is completed.

    :::image type="content" source="../media/3-install-cosmosdb-extension.png" alt-text="Screenshot of Visual Studio Code. The user has selected the Azure Databases extension." loc-scope="vs-code":::

    Wait while the extension is installed.

## Create an Azure Databases extension account

1. On the **View** menu, select **Command Palette**.

1. In the command palette, enter **Azure**, and then select **Azure: Focus on Database View**.

    :::image type="content" source="../media/3-command-palette-cosmosdb.png" alt-text="Screenshot of the command palette in Visual Studio Code. The user has selected the Focus on Azure Databases extension View command." loc-scope="vs-code":::

    The Databases pane appears (if not already visible).

    :::image type="content" source="../media/3-cosmosdb-pane.png" alt-text="Screenshot of the Azure Databases extension pane in Visual Studio Code." loc-scope="vs-code":::

1. On the **View** menu, select **Command Palette**, and then select **Azure: Sign in**.

1. Sign in with the same credentials you used to set up the sandbox, and then close the browser page.

1. In the toolbar above the Azure Databases extension pane, select **Create Account** (the **+** sign).

    :::image type="content" source="../media/3-add-comsosdb-account.png" alt-text="Screenshot of the Azure Databases extension pane in Visual Studio Code. The user has selected the **Create Account** command." loc-scope="vs-code":::

    A wizard starts and prompts you for the details of the new account.

1. Select **Core (SQL)** from the "Select subscription" menu.

1. In the **Account name** box, enter an account name. The name must be globally unique; we suggest using something like **\<*your name or initials*\>school**.

1. In the **Select a resource group for new resources** list, select **<rgn>[sandbox resource group]</rgn>** for the resource group created for you by the Learn sandbox.

1. In the **Select a location for new resources** list, select a location near you.

1. Wait while the Azure Databases extension account is created. This will take a few minutes.

1. When the account has been created, in the Azure Databases extension pane, expand the Concierge Subscription. Verify that the new Azure DB account appears.

    :::image type="content" source="../media/3-new-comsosdb-account.png" alt-text="Screenshot of the Azure Databases extension pane in Visual Studio Code. The new Azure Databases extension account is listed under the user's Azure account." loc-scope="vs-code":::

## Create a database and container

1. In the Database pane, right-click the Database account you created, and then select **Create Database**.

    :::image type="content" source="../media/3-cosmosdb-create-database.png" alt-text="Screenshot of the Azure Databases extension pane in Visual Studio Code. The user has selected the Create Database command for the Azure Databases extension account." loc-scope="vs-code":::

1. In the **Database Name** box, enter **SchoolDB**, and then press <kbd>Enter</kbd>.

1. In the **Enter an id for your collection** box, enter **StudentCourseGrades**, and then press <kbd>Enter</kbd>.

    This container will hold `StudentCourseGrades` documents. Course grades will be held as an array of subdocuments with each student. The data will be partitioned by student ID.

1. In the **Partition key** leave blank, and press <kbd>Enter</kbd>.

1. In the **Initial throughput capacity** box, accept the default value of **1000**, and then press <kbd>Enter</kbd>.

1. Verify that the **SchoolDB** database, containing the **StudentCourseGrades** container, appears.

    :::image type="content" source="../media/3-database-and-container.png" alt-text="Screenshot of the Azure Databases extension pane in Visual Studio Code, showing the SchoolDB database and the StudentCourseGrades container." loc-scope="vs-code":::

## Create and view documents

1. In the Azure Databases extension pane, expand the **StudentCourseGrades** container. Two subfolders should appear, named **Documents** and **Stored Procedures**.

1. Right-click the **Documents** folder, and then select **Create Document**.

    :::image type="content" source="../media/3-create-document.png" alt-text="Screenshot of the Azure Databases extension pane in Visual Studio Code. The user has selected the Create Document command in the StudentCourseGrades container." loc-scope="vs-code":::

1. In the **Enter a document ID** box, enter **S101**, and then press <kbd>Enter</kbd>. This will be the ID of a student document.

    The document will be created and displayed in Visual Studio Code, in JSON format. The **id** and **StudentNumber** fields will be populated with the values you specified. The document will also contain other fields that are added automatically by Azure Databases extension for its internal use.

    :::image type="content" source="../media/3-new-document.png" alt-text="Screenshot of Visual Studio Code showing the newly created document." loc-scope="vs-code":::

1. In the Azure Databases extension pane, right-click the **Documents** folder again, and select **Create Document**.

1. In the **Enter a document ID** box, enter **S102**, and then press <kbd>Enter</kbd>. This will be the ID of another student.

    The new document appears.

## Edit documents

1. In the **Documents** list, select the **S101** document.

1. In the JSON document that appears, move to the end of the **StudentNumber** line, and press <kbd>Enter</kbd>.

1. Add the following fields to the document. Don't forget to add a comma at the end of the first line, and remove it from the last line.

    ```JSON
    "Forename": "AAA",
    "Lastname": "BBB",
    ```

1. Right-click anywhere in the document pane, and select **Update to Cloud**.

    :::image type="content" source="../media/3-save-changes.png" alt-text="Screenshot of Visual Studio Code showing the edited document. The student has selected the Update to Cloud command to save the changes back to Azure Databases extension." loc-scope="vs-code":::

    The document will be written back to Azure Databases extension. The Visual Studio Code log window will appear. The final message in the log should be similar to the following example.

    ```text
    10:51:56: Updated entity "csschool (SQL)/SchoolDB/StudentCourseGrades/Documents/S101"
    ```

1. In the **Documents** list, select the **S102** document.

1. Add the following fields to the document after the **StudentNumber** field, and then save the updated document to the cloud.

    ```JSON
    "Forename": "CCC",
    "Lastname": "DDD",
    ```

1. In the **Documents** list, select the **S101** document again.

1. Add the following field to the document after the **Lastname** field.

    ```JSON
    "CourseGrades": [
        {
            "Course": "Computer Science",
            "Grade": "A"
        },
        {
            "Course": "Applied Mathematics",
            "Grade": "B"
        }
    ],
    ```

    This is an array field that contains the grades for each course that the student has taken. Each pair of **Course**/**Grade** fields is a subdocument. Using an array makes it possible to record the details of a variable number of courses for each student.

1. Save the updated document to the cloud.

1. Edit the **S102** document, add the following fields, and save the updated document to the cloud.

    ```JSON
    "CourseGrades": [
        {
            "Course": "Computer Science",
            "Grade": "C"
        }
    ],
    ```

    This student has only taken the Computer Science course.

You've now used the Azure DB extension in Visual Studio Code to create an Azure DB database and container. You've added and viewed documents, and you've edited these documents.
