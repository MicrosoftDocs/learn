In this step, you'll create an interface that will define which behaviors an Ant can perform. You'll also implement the interface in a new class as well as the existing Ant class.

> [!IMPORTANT]
> You need to have completed the Setup instructions in the previous unit, Prepare, before you begin this Exercise.

## Create an interface

1. In the Solution Explorer, right click on the **Game** folder.

1. In the context menu, select "Add" > "New Item"

1. In the "Add New Item" dialog box, select "Interface" from the list of available templates.

1. In the "Name" textbox, enter "IAnt.cs" and click "Add"

    The new interface file should appear in the code editor with a basic template applied. Now you can define which methods and properties the interface should contain.

1. Change the visibility of the interface by updating the interface definition to the following:

    ```c#
    public interface IAnt
    ```

1. In the interface definition, add the following properties:

    ```c#
    public int I { get; set; }
    public int J { get; set; }
    public AntDirection Direction { get; set; }
    ```

1. In the interface definition, add the following method declarations:

    ```c#
    public byte Act(byte oldValue);
    public void RotateCW();
    public void RotateCCW();
    ```

1. In the Solution Explorer, open the **Ant.cs** file under the **Game** folder.

1. Add the following code to make the `Ant` class extend `IAnt`:

    ```c#
    public class Ant : IAnt
    ```

    The `Ant` class already contains the properties and methods you included in the `IAnt` interface.

1. Copy the **Ant.cs** file and paste it into the **Game** directory.

1. Rename the copied file to **MirrorAnt.cs**

1. Open the file and change the class name from `Ant` to `MirrorAnt`:

    ```c#
    public class MirrorAnt : IAnt
    ```

1. Change the constructor name from `Ant` to `MirrorAnt`:

    ```c#
    public MirrorAnt(int i, int j, AntDirection direction)
    ```

1. Locate the `Act` method and swap the `RotateCW` and `RotateCCW` method calls as follows:

    ```c#
    public virtual byte Act(byte oldValue)
    {
        byte ret;
        if (oldValue == 0)
        {
            ret = 1;
            RotateCCW();
        }
        else
        {
            ret = 0;
            RotateCW();
        }
        Move();
        return ret;
    }
    ```

## Check your work

In this task, you'll verify your code is working correctly.

1. Compare your code in the `IAnt` class to the following to ensure it's correct:

    ```c#
    public interface IAnt
    {
        public int I { get; set; }
        public int J { get; set; }
        public AntDirection Direction { get; set; }
        public byte Act(byte oldValue);
        public void RotateCW();
        public void RotateCCW();
    }
    ```

1. Build your solution using <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd> or by selecting **Build Solution** from the **Build** menu.

1. Verify that the code builds successfully and there are no errors.

    If your code produces unexpected errors, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.

1. Run the Guided Project solution and press Enter a few times to view the generated ant pattern.