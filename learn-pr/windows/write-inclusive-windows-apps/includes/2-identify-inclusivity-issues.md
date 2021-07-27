## Building the non-inclusive scientific calculator

This unit covers building and testing of a scientific calculator. The code for this is already complete and available from GitHub.

In this unit you will learn:
- How to build a sample app for use with this module.
- How to identify some common inclusivity issues.

### Create the project

1. Open up Visual Studio and create a new **Windows Universal** project using the **Blank App** template, called **InclusiveScientificCalculator**. Make sure to use this name exactly, to match the code we'll get from GitHub.

2. When asked about the versions of Windows that the app should support, change the minimum version from the default to the one shown in the image below. There are some newer features of Windows that we would like to include.

![Setting the Minimum version.](../media/windows-minimum.png)

3. Navigate to [this GitHub repo](https://github.com/MicrosoftDocs/mslearn-write-inclusive-Windows-apps) and open up the `MainPage.xaml` file. Select all the contents of the file and copy and paste it over the entire contents of the MainPage.xaml file in your project.

4. At the same location on GitHub, open the `MainPage.xaml.cs` file. Again, replace all the contents of your file with the contents of the file on GitHub. It's quite a lot of code, over 1000 lines of C#.

5. Select **Start without debugging** from the **Debug** menu of Visual Studio. You should see something like the following image. If not, double-check that everything was copied correctly.

![Showing the default light calculator.](../media/non-light.png)

### Test the features of the calculator

The concept behind this calculator is that entire simple or complex equations can be entered, then the calculation parsed and the result shown. However, there are some accessibility issues in the app. Walk through these steps to see how it works, and note how the user experience might be improved.

1. You might remember that a triangle with sides of length 3, 4 and 5 is a right triangle, and the length of the hypotenuse of a right triangle is equal to the square root of the sums of the squares of the other two sides. To enter this formula, press these buttons in the app: **Sqrt ( 3 ^ 2 + 4 ^ 2 )**. Select the **=** button to perform the calculation. You should get a result of **5**.

2. The calculator can also store constants. Use the buttons to enter your weight in kilograms or pounds. Select **Show constants**, then scroll down to find the conversion constant (**Kg to Lbs** or **Lbs to Kg** - whichever is appropriate). Select the constant to add it to the calculation. Select the multiply button, then **=**. You now have your weight in the other unit.

3. Select **Show constants** again and scroll down to examine the list. Pay close attention to the wording here - some of it, such as "**Oz to gms**," is a little sloppy. Using this shorthand is common and saves time when putting together your app, but can be an accessibility issue.

4. Now enter an improper or nonsensical calculation, such as **Sqrt ( 6 +**. Select **=**. A red **Error** message appears on a green background, which could be a significant issue for color-blind users. Now select **Clr** to clear that message.

5. Now enter **Sin 30**. The result should be **0.5**. Change the angles to radians in the radio box and try again. The result should be **-0.988031624092862**. While this works as we might expect, radio buttons can be difficult to interact with when navigating an app through keyboard input.

6. As you wrap up this investigation, notice how much you're using mouse/pointer impact, and that there's no audio feedback for your actions. You've been reliant on only visual cues.

## Unit summary

We encourage you to play with the calculator a bit more, and imagine would be like to use with impaired vision or motor skills. Next, we'll see how we can improve this experience.
