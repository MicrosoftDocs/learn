In this unit, you download the DTDL validator sample. This is a command-line sample application that parses and validates a DTDL hierarchy of models, given a root folder. You'll also deliberately add errors to a copy of a model file to demonstrate the benefits of using the validation sample application.

## Download the DTDL validator sample application

1. Download the [DTDL validator](https://docs.microsoft.com/samples/azure-samples/dtdl-validator/dtdl-validator/).

1. Extract the zip file to an appropriate location. The default location is to your **Downloads** folder.

1. Make sure you have the [C# Visual Studio Code extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csharp) and [.NET Core 3.1](https://dotnet.microsoft.com/download) installed.

1. In Visual Studio Code, open the project folder by going to **File** > **Open Folder...** (`Ctrl`+`K` `Ctrl`+`O`), and selecting the folder where you extracted the DTDL validator sample application.

    > [!NOTE]
    > If you receive messages about missing assets and unresolved dependencies, click "Yes" and "Restore" respectively:
    > :::image type="content" source="../media/visual-studio-code-messages.png" alt-text="Screenshot showing the messages that can be disregarded with the DTDL Validator sample open in Visual Studio Code":::

1. Open the terminal (if it's not already open) by going to **View** > **Terminal**.

1. From the "DTDL_Validator" root directory of the project, navigate to the application by entering the following command in the terminal:

    ```powershell
    cd .\DTDLValidator-Sample\DTDLValidator\
    ```

1. Leave Visual Studio Code and its terminal open.

## Run the validation app on the chocolate factory models

First, check that the models you've been given are valid.

1. Go to the folder containing your production line models and copy the full path for a later step in this section. For example: "C:\\Users\\{username}\\Documents\\factory-models".

1. To use the DTDL validator sample application, run the following command in the Visual Studio Code terminal with the full path to your models folder:

    ```powershell
    dotnet run -d <your folder>
    ```

1. You should get the message that your models are valid:

    ```powershell
    **********************************************
    ** Validated all files - Your DTDL is valid **
    **********************************************
    ```

If your models aren't valid, you'll need to edit them. The next section examines what might go wrong.

## Run the validation app on a faulty model

In this section, you'll deliberately add errors to a DTDL model to test the validator app.

1. In your models folder, create a copy of the **ProductionStepGrinding.json** file. Leave the name as **ProductionStepGrinding - Copy.json**.

1. Open the **ProductionStepGrinding - Copy.json** file. Double-check that you've opened the copy, and not the original.

1. Edit the file by making the following changes:
    - Locate the field <b>@type</b> on line 3, and change it to <b>@typo</b>.
    - Locate the field **name** on line 29, and delete the line.
    - Locate the field **schema** on line 18, and add a line before it:

        ```json
        "glitch" : "nonsense",
        ```

1. Save the edited **ProductionStepGrinding - Copy.json**, but leave it open in your text editor.

1. Back in the Visual Studio Code terminal, use the up arrow to locate the `dotnet run -d <your folder>` command, and hit return.

1. You'll get one red error message in the output. Correct the `missing required @type` error in file by changing "typo" back to "type" on line 3.

1. In the command window, use the up arrow to run the app again.

1. Next you'll receive two errors: one that mentions that `glitch` is an improper property, and another that requires a `name` property for items within the `contents` array.

1. Fix the errors and save off **ProductionStepGrinding - Copy.json**, leaving it open for editing.

1. In the command prompt window, use the up arrow to run the app again.

1. You should notice that you get an error that there are multiple definitions of a model.

1. Correct the duplicate error by changing the ID. Change "grinding" to "crunching", on line 2.

1. Save off **ProductionStepGrinding - Copy.json** and run the command again. You shouldn't receive any more errors.

1. To clean up your models folder, delete the **ProductionStepGrinding - Copy.json** file. There's no further use for it.

1. Close Visual Studio Code.

Next, you'll look at how your models make up a digital twin graph.
