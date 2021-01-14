At this point, you download and install the Digital Twins Definition Language (DTDL) validator sample. This is a command line sample application that parses and validates a DTDL hierarchy of models, given a root folder. You'll also deliberately add errors to a copy of a model file to demonstrate the benefits of using the validation sample application.

## Download and install the DTDL validator app

1. Download the [DTDL validator](https://docs.microsoft.com/samples/azure-samples/dtdl-validator/dtdl-validator/).

1. Extract the zip file to an appropriate location. The default location is to your **Downloads** folder.

1. Using Visual Studio, locate the **DTDLValidator.sln** file and open it.

1. Build the project (Ctrl+Shift+B).

1. Close Visual Studio.

1. Open a command prompt window. You can do this by opening Windows Start, typing *command*, and selecting the **Command Prompt** icon when it appears.

1. Go to the folder containing the DTDLValidator sample app. If you extracted the file to the default location, this location will be:

    ```cmd
    C:\Users\<your alias>\Downloads\DTDL_Validator\DTDLValidator-Sample\DTDLValidator\bin\Debug\netcoreapp3.1
    ```

1. In the command prompt window, validate the app is installed correctly by entering:

    ```cmd
    DTDLValidator --help
    ```

    :::image type="content" source="../media/validator-help.png" alt-text="Screenshot of the command prompt help output for the DTDLValidator application." lightbox="../media/validator-help.png":::

1. Leave the command prompt window open.

## Run the validation app on the chocolate factory models

First, check that the models you've been given are valid.

1. Go to the folder containing your production line models.

1. At the command prompt, paste in the `DTDLValidator -d <your folder>` command, replacing `<your folder>` with the full path to your models.

1. You should get the message that your models are valid:

    ```cmd
    **********************************************
    ** Validated all files - Your DTDL is valid **
    **********************************************
    ```

1. If your models aren't valid, you'll need to edit them. The next section examines what might go wrong.

## Run the validation app on a faulty model

In this section, you'll deliberately add errors to a DTDL model to test the validator app.

1. In your models folder, create a copy of the **ProductionStepGrinding.json** file. Leave the name as **ProductionStepGrinding - Copy.json**.

1. Open the **ProductionStepGrinding - Copy.json** file. Double-check that you've opened the copy, and not the original.

1. Edit the file by making the following changes:
    - Locate the field `@type` on line 4, and change it to `@typo`.
    - Locate the field `name` on line 30, and delete the line.
    - Locate the field `schema` on line 19, and add a line before it:

        ```json
        "glitch" : "nonsense",
        ```

1. Save the edited **ProductionStepGrinding - Copy.json**, but leave it open in your text editor.

1. Go to the command prompt window. Use the up arrow to locate the `DTDLValidator -d <your folder>` entry, and hit return.

1. You should notice that you get an error that there are multiple definitions of a model. You'll also notice that you only get one error message before the app exits.

1. Correct the duplicate error by changing the ID. Change `grinding` to `crunching`, on line 3.

1. Save off **ProductionStepGrinding - Copy.json**, leaving it open for editing.

1. In the command prompt window, use the up arrow to run the app again.

1. You'll get one error message (in red) in the output. Correct the `missing required @type` error in file by changing "typo" back to "type" on line 4.

1. Save off **ProductionStepGrinding - Copy.json**, leaving it open for editing.

1. Repeat this process, until all the errors in the copied version of the model file are corrected.

To clean up your models folder, delete the **ProductionStepGrinding - Copy.json** file. There's no further use for it. Finally, you can close the command window for the validator app.

Next, you'll look at how your models make up a digital twin graph.
