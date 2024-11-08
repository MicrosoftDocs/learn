In this exercise, you'll create an interface that defines which behaviors an Ant can perform. You'll also implement the interface in a new class as well as the existing Ant class.

> [!IMPORTANT]
> You need to have completed the Setup instructions in the previous unit, Prepare, before you begin this Exercise.

## Create an interface

1. In the Explorer, right click on the **Game** folder.

1. In the context menu, select "New File"

1. In textbox, enter "IAnt.cs"

1. Open the new file and type the following code:

    ```c#
    namespace LangtonsAnt
    {
        public interface IAnt
        {

        }
    }
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

1. In the Explorer, open the **Ant.cs** file under the **Game** folder.

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

In this task, you verify that your code is working correctly.

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

1. Save your work.

1. Right-click the "M04-Guided-Project" folder in the Explorer and click "Open in Integrated Terminal"

1. In the terminal command prompt, enter **dotnet run**

    A console window should open and display the output of the code.

1. In the console window, press Enter a few times to view the generated ant pattern.

If your code produces unexpected errors, you'll need to review your code to find your error and make updates. Run the code again to see if you've fixed the problem. Continue updating and running your code until your code produces the expected results.