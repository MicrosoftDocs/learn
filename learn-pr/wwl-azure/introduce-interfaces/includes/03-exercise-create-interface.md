Suppose you're writing code to manage inventory in a video game. The player is able to collect and store items, such as weapons, armor, potions, and more. Each type of item comes with its own capabilities. In this exercise, you'll create functionality to make Armor and Weapons equipable.

:::image type="content" source="../media/m-01-03-demo.png" alt-text="Screenshot of the inventory program for this module. The inventory contains different items.":::

## Prepare your coding environment

This module includes hands-on activities that guide you through the process of building and running demonstration code. You're encouraged to complete these activities using Visual Studio Code as your development environment. Using Visual Studio Code for these activities can help you to become more comfortable writing and running code in a developer environment that's used by professionals worldwide.

> [!IMPORTANT]
> You must have .NET Framework 8.0 installed and a Github account to complete these steps.

1. Open Visual Studio Code.

    You can use the Windows Start menu (or equivalent resource for another OS) to open Visual Studio Code.

1. Under the Visual Studio Code **Start** section, select **Clone Git Repository**.

1. In the URL bar, enter `https://github.com/MicrosoftLearning/MSLearn-Implement-interfaces-in-CSharp`

1. In the File Explorer, create a new folder in a location that is easy to find and remember, such as a folder in your Desktop.

1. Click the **Select as Repository Destination** button.

    You need to be signed in to GitHub to successfully clone the project.

1. Open the project in Visual Studio Code.

1. In Explorer, right-click the **M01-Implement-Interfaces** folder and click **Open in Integrated Terminal**

1. Expand the **M01-Implement-Interfaces** folder.

    You should see a list of folders and files, including an Items folder and a Model.cs file.

## Exercise - Create an interface

In this exercise, you'll create an IEquipable interface to be used by the Armor and Weapons classes. The player should be able to equip and unequip an item, and check whether or not an item is equipped.

1. In the Explorer, right click on the **Items** folder.

1. In the context menu, select "New File"

1. In the textbox, enter "IEquipable.cs"

1. Open the new file and type the following code:

    ```c#
    namespace M01_Implement_Interfaces.Items
    {
        internal interface IEquipable
        {
            public void Equip();
            public void Unequip();
        }
    }
    ```

    Notice that you only define the method signatures, not the implementations. Next we need to add an `equipped` property to indicate whether or not the item is equipped.

1. Enter the following code:

    ```c#
    public bool Equipped;
    ```

    Notice that this line of code contains the error: "Interfaces cannot contain instance fields." 
    :::image type="content" source="../media/m-01-03-interface-field-error.png" alt-text="Screenshot of an error in Visual Studio that occurs when adding an instance field to an interface.":::
    Recall that interfaces act as blueprints; they don't define implementations. A field represents data implementation, so you need to change this instance field to a property.

1. Update the previous line of code as follows:

    ```c#
    public bool Equipped { get; set; }
    ```

    Next, save your changes.

Now you have successfully created your first interface! In the next module, you'll implement this interface and see your functionality in action.

> [!IMPORTANT]
> Be sure not to delete any of the code you wrote. You'll build on this code throughout this training module.