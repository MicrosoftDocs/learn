In this unit, you download and install the DTDL Validator tool. This is a command line tool that parses and validates a DTDL hierarchy of models, given a root folder. We also corrupt a copy of a model file, to give the validation tool a short workout.

## Download and install the DTDL Validator tool

1. Download the tool from [DTDL Validator](https://docs.microsoft.com/samples/azure-samples/dtdl-validator/dtdl-validator/).

1. Extract the zip file to an appropriate location. The default location will be in your **Downloads** folder.

1. Using Visual Studio, locate the **DTDLValidator.sln** file, and open it.

1. Build the project.

1. Close Visual Studio.

1. Open a Command Prompt window. You can do this by typing "Command" into the search box, lower left of your screen, then clicking the **Command Prompt** icon, when it appears.

1. Navigate to the folder containing the DTDLValidator app. If you extracted the file to the default location, this location will be:

```
C:\Users\<your alias>\Downloads\DTDL_Validator\DTDLValidator-Sample\DTDLValidator\bin\Debug\netcoreapp3.1
```

1. In the Command Prompt window, validate the tool is installed correctly, by entering:

    ```
    DTDLValidator --help
    ```

    :::image type="content" source="../media/adt-dtdl-validator-help.png" alt-text="Command prompt help output for the DTDLValidator tool" lightbox="../media/adt-dtdl-validator-help.png":::

1. Leave the Command Prompt window open.

## Run the validation tool on the chocolate factory models

First, let's check the models we've given you are valid!

1. Navigate to the folder containing your production line models.

1. Using Windows Explorer, or another tool, copy the path to your models to your text file. In the text file, create the string `DTDLValidator -d <your folder>`, replacing `<your folder>` with the path.

1. In the Command Prompt, paste in the `DTDLValidator -d <your folder>` command.

1. You should get the message that your models are valid.

    ```json
    **********************************************
    ** Validated all files - Your DTDL is valid **
    **********************************************
    ```

1. If your models are invalid, you'll need to edit them. Let's look at what might go wrong.

## Run the validation tool on a faulty model

In this section, we'll deliberately create a corrupted model, to test the validator tool.

1. Using Windows Explorer, create a copy of the **ProductionStepGrinding.json** file. Leave the name as **ProductionStepGrinding - Copy.json**.

1. Open the **ProductionStepGrinding - Copy.json** file. Double check you've opened the copy, and not the original!

1. Edit the file by making the following changes.
    - Locate the field **@type** on line 4, and change it to **@typo**.
    - Locate the field **name** on line 30, and delete the line.
    - Locate the field **schema** on line 19, and add a line before it:

    ```
    "glitch" : "nonsense",
    ```

1. Save the edited **ProductionStepGrinding - Copy.json**, but leave it open in your text editor.

1. Back in the Command Prompt window, use the up arrow to locate the `DTDLValidator -d <your folder>` entry, and hit return.

1. You should notice that you get an error that there's multiple definitions of a model. You will also notice that you only get one error message before the tool exits.

1. Correct the duplicate error, by changing the ID. Change "grinding" to "crunching", on line 3.

    :::image type="content" source="../media/adt-chocolate-nibs-v.png" alt-text="Photoraph of roasted chocolate nibs" lightbox="../media/adt-chocolate-nibs-v.png":::

1. Save off **ProductionStepGrinding - Copy.json**, leaving it open for editing.

1. In the command window, use the up arrow to run the tool again.

1. Again, you'll get one red error message in the output. Correct the `missing required @type` error in the corrupted file, by changing "typo" back to "type", on line 4.

1. Save off **ProductionStepGrinding - Copy.json**, leaving it open for editing.

1. Repeat this process, until all the errors in the corrupt version of the file are corrected. Refer back to the hacks you made in the file, if necessary!

1. Good work, a decent test of the tool. Now delete the **ProductionStepGrinding - Copy.json** file, we've no further use for it.

1. Close the command window for the validator tool.

Now we change tack, and look at how our models make up a digital twin graph.