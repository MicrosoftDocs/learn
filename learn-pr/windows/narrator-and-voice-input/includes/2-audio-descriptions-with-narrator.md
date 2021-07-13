Speech synthesis has come a long way since the days of robotic voices and stilted pronunciations. The Narrator provides a built-in screen reader on Windows, which can be a great assistance to users with visual impairment. But we'll need to configure our app to use it well.

In this unit you will learn:
- How to turn on the Narrator and test it on an app with no special narration attributes.
- How to add special attributes to an app to improve the fluency of narration.
- How to clean up some sloppiness in our strings and messages so they sound right.
- That gaps in narration can be filled with a custom instance of a speech synthesizer.

## The Narrator

Ensure the scientific calculator app is up and running. We'll need to change the XAML and the code-behind to ensure that it provides the best experience for users using the Narrator.

### Turning on and testing the Narrator

1. Type "narrator settings" into the Windows search bar, then select **Ease of Access Narrator settings**. This will bring up the following screen.

![Turning on the narrator.](../media/narrator-settings.png)

2. Turn on the **Use Narrator** switch, then minimize this window. Narration can be more troublesome when switching between apps and developing software, so you'll want to keep this window open. That way, you'll be able to switch it off when making changes to your code, and then re-enable it for testing.

3. Highlight the **Show constants** button of the calculator, and notice how Narrator handles the description: **Show constants (pause) button**. We want to assist the Narrator in making its descriptions as helpful as possible, which means working with its built it features. One of those features is to announce the type of UI element (clearly, "button" in this case).

4. Now select the **Sqrt** button, and notice the pronunciation. "Sqrt" is a common shorthand form of writing square root in mathematics, but Narrator doesn't know this. Similarly, it won't recognize **Sin**, **Asin**, **Acos**, and so on, especially when specialized terms can also be pronounced as common English words. We'll need to assist Narrator in getting these pronunciations correct.

5. Select various other buttons (operations, numbers) and note how well the narration is handled. There are areas where it does well, and areas where it needs improvement.

6. Go back to the **Show constants** button, select it, and then select the various constants themselves and note the narration. Select several of the constants and evaluate the usefulness of the pronunciation. Where we have been a bit lazy and put in shorthand (such as "Gms", "Ozs", "Cms" etc.) the pronunciation is not useful. Shorthand terms aren't useful if your users can't understand them.

8. Finally, enter the following calculation: **Sqrt** **Atan** **0.5**. Without selecting **=**, select the text display of the calculation and note how Narrator handles it. Now press **=** and select the text display again. Thankfully for us, Narrator can handle long numbers quite well.

9. Open the Narrator setting window and turn off narration for now.

Given our test of the Narrator with the calculator, clearly we have a few issues to work on: the pronunciation of mathematical functions, of mathematical operations, and the clarity of the list of constants.

### Making the text strings natural

In this section, we help the Narrator sound natural when using any feature of the calculator. Make sure Visual Studio is open with the scientific calculator project.

1. When a UI element is highlighted and narrated, the Narrator first tests for the property **AutomationProperites.Name**. If one is found, that is the word or phrase that is used. If one is not found, the **Content** property is used instead. So, for all those UI elements that are not well pronounced, we need to add the **AutomationProperites.Name** property with a clearly pronounceable name. In the MainPage.xaml file, add the following name properties to their respective xaml entries. Take your time, as this is a long list, and you'll need to add the entries one by one. Cut and paste from the list below, or use the quick attribute entry features of Visual Studio.

```xml
 <Button x:Name="ButtonNMemoryPlus" AutomationProperties.Name="Memory plus" Content="M+"
 <Button x:Name="ButtonNMemoryMinus" AutomationProperties.Name="Memory minus" Content="M-"
 <Button x:Name="ButtonNMemoryMultiply" AutomationProperties.Name="Memory times" Content="M*"
 <Button x:Name="ButtonNMemoryDivide" AutomationProperties.Name="Memory divided by" Content="M/"
 <Button x:Name="ButtonLeft" AutomationProperties.Name="Open" Content="("
 <Button x:Name="ButtonSqrt" AutomationProperties.Name="Square root" Content="Sqrt"
 <Button x:Name="ButtonPow" AutomationProperties.Name="to the Power of" Content="^"
 <Button x:Name="ButtonPi" AutomationProperties.Name="Pi" Content="&#928;"
 <Button x:Name="ButtonRight" AutomationProperties.Name="Close" Content=")"
 <Button x:Name="ButtonArcsine" AutomationProperties.Name="Arc sine" Content="Asin"
 <Button x:Name="ButtonArccosine" AutomationProperties.Name="Arc cosine" Content="Acos"
 <Button x:Name="ButtonArctangent" AutomationProperties.Name="Arc tangent" Content="Atan"
 <Button x:Name="ButtonSin" AutomationProperties.Name="Sine" Content="Sin"
 <Button x:Name="ButtonCos" AutomationProperties.Name="Cosine" Content="Cos"
 <Button x:Name="ButtonTan" AutomationProperties.Name="Tangent" Content="Tan"
 <Button x:Name="ButtonNegative" AutomationProperties.Name="Negative" Content="-N"
 <Button x:Name="ButtonPlus" AutomationProperties.Name="plus" Content="+"
 <Button x:Name="ButtonMinus" AutomationProperties.Name="minus" Content="-"
 <Button x:Name="ButtonMultiply" AutomationProperties.Name="times" Content="*"
 <Button x:Name="ButtonDivide" AutomationProperties.Name="divided by" Content="/"
 <Button x:Name="ButtonEquals" AutomationProperties.Name="equals" Content="="
 <TextBox x:Name="TextDisplay" AutomationProperties.Name="Calculation"
 <Button x:Name="ButtonClr" AutomationProperties.Name="Clear" Content="Clr"
 <Button x:Name="ButtonDel" AutomationProperties.Name="Delete" Content="Del"
   />
```

2. Next, let's address the sloppiness of the list of constants. Open the `MainPage.xaml.cs` file and locate the **LoadConstants** method.

3. Replace the list of strings with the following, noting how all shorthand terms have been replaced with longhand.

```cs
string[] initialConstants = {
                "Acceleration due to gravity = 9.80665",
                "Bars to pounds per square inch = 14.5037738",
                "Centimeters to inches = 0.393700787",
                "Degrees to radians = 0.0174532925",
                "Feet to meters = 0.3048",
                "Grams to ounces = 0.035273",
                "Inches to centimeters = 2.540",
                "Inches to millimeters = 25.4",
                "Kilograms to pounds = 2.20462262",
                "Kilometers to miles = 0.621371192",               
                "Liters to pints = 2.11337642",
                "Meters to feet= 3.2808",
                "Miles to kilometers = 1.609344",
                "Millimeters to inches = 0.0393700787",
                "Ounces to grams = 28.3495",
                "Pints to liters = 0.473176473",   
                "Pounds per square inch to bars = 0.0689475729",
                "Pounds to kilograms = 0.45359237",                            
                "Radians to degrees = 57.2957795",
                "Speed of light in meters per second = 299792458",
                "Speed of light in miles per second = 186282.397"
            };
```

4. Now run the app and turn on narration. To be thorough, you'll need to highlight each of the math functions, operations, and constants, so that the Narrator will read them. Are they all now sounding natural and understandable? If not, make your corrections to the strings or add or adjust the **AutomationProperites.Name** property.

5. Try entering a calculation with brackets and several math functions (whether they make any mathematical sense doesn't matter), then highlight the text display. We'll need to do some coding to fix this.

### Add code to aid the Narrator

Thanks to our changes, Narrator now does a great job with UI elements. However, there are a few cases where a spoken message would help, but the triggering event isn't a UI element. Also, we'd like to improve the pronunciation of the calculation. Here we'll add a speech synthesizer to handle error messages, and some short code changes to handle the calculation.

1. Open the MainPage.xaml.cs file and update the using statements to include the following.

```cs
using System.Threading.Tasks;
using Windows.Media.SpeechSynthesis;
using Windows.UI.Xaml.Automation;
```

2. Add the following to the list of global variables.

```cs
        // Declare variables needed for speech output.
        SpeechSynthesizer speech;
        MediaElement mediaElement;
```

3. Initialize these variables in the **MainPage** method, so it now looks like this.

```cs
        public MainPage()
        {
            this.InitializeComponent();

            // Hide the error field.
            textError.Visibility = Visibility.Collapsed;

            LoadConstants();

            calculation = new ArrayList();
            backupCalculation = new ArrayList();

            mode = Emode.Calculate;

            // The objects for controlling and playing audio.
            speech = new SpeechSynthesizer();
            mediaElement = new MediaElement();
        }
```

4. It's good practice to add a toggle switch or other UI element, so the user can decide whether they want narration help. In the `MainPage.xaml` file, just above the **listConstants** entry (near the last UI element entries), add the following.

```cs
        <ToggleSwitch x:Name="ToggleNarration"
            Margin="551,407,0,0"
            HorizontalAlignment="Left"
            VerticalAlignment="Top"
            Header="Narration help"
            IsOn="True" />
```
> [!NOTE]
> It's important to get these elements in the right order in the XAML file. If not, you'll get show-through effects, such as this entry appearing into the list of constants.

5. Back in `MainPage.xaml.cs`, add a **SayAsync** method to speak any given line of text. Note the use of the **speech** and **mediaElement** variables we've just added, and that this is an asynchronous task.

```cs
        private async Task SayAsync(string text)
        {
            // Narrate the given text if narration help is on.
            if (ToggleNarration.IsOn == true)
            {
                // Generate the audio stream from plain text.
                SpeechSynthesisStream stream = await speech.SynthesizeTextToStreamAsync(text);

                // Send the stream to the media object, then play it.
                mediaElement.SetSource(stream, stream.ContentType);
                mediaElement.Play();
            }
        }
```

6. We now need to add calls to the **SayAsync** method. Start with the **catch** block of the **CalculateAsync** method.

```cs
            catch
            {
                TextError.Visibility = Visibility.Visible;
                CopyCalculation(backupCalculation, calculation);
                await SayAsync("Oops, there is an error in your calculation.");
            }
```

7. Still in the **CalculateAsync** method, add the following call to **SayAsync** after the lines shown here.

```cs
                    // Add the entry to the next calculation, just in case the user wants to add to it.
                    OneEntry resultEntry = new OneEntry(Etoken.Number, result, txt);
                    calculation.Add((object)resultEntry);

                    await SayAsync($"The result is: {txt}");
```

8. Now locate the **Button_Click** method and change the **default:** entry in the switch block to the following. This will make the calculation pronounceable.

```cs
                default:

                    // User has clicked a math or digit button.
                    string tag = b.Tag.ToString();
                    string txt = "";

                    // If in narrative mode, then use a full English string for the display text, if a full string has been specified.
                    if (ToggleNarration.IsOn == true)
                    {
                        txt = b.GetValue(AutomationProperties.NameProperty).ToString();
                    }

                    // Use the content of the button as the equation text.
                    if (txt.Length == 0)
                    {
                        txt = b.Content.ToString();
                    }

                    MathEntry(txt, tag);
                    break;
```

9. Test your code by running the app. Ensure the Narrator, and the **Narration help** toggle button are on. Enter a nonsensical calculation (such as **Sqrt (**, which will appear as **Square root Open** ). Do you get a natural-sounding error message when you select **=**? Notice how the same voice is used for your **SayAsync** method and the Narrator, which keeps audio experience smooth.

11. Complete the calculation and notice that the text is spelled out in the display. If you then highlight the display, the calculation is read out clearly by the Narrator. Some select operations might still be a bit of a challenge, but this is good enough to provide a far more accessible experience.

Add a speech synthesis option to your app does allow you to fill in any gaps in narration that might help your users. This is highly app-specific, so the priority should be getting the UI elements Narrator-friendly first. A minimal amount of additional narration might be all you need, as was the case here.

## Unit summary

In this unit, we learned that speech synthesis is now amazingly good, at least compared with what it used to be. We learned that a good deal of narration comes for free with Windows, just by turning on the Narrator. However, we also learned that sloppiness in our message strings becomes readily apparent when using the Narrator. For an accessible app, we need to make sure our message strings are clean and thorough.

We also learned that the Narrator is not perfect and needs to be helped in certain circumstances. For example, a mathematical word like "sin" will not be pronounced correctly as the shortened form is a word in its own right. But XAML settings to fix this issue are readily available and aren't hard to implement.
