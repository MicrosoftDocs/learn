Keyboard navigation has proven to be the most important feature of inclusive apps. Blind users might have a braille keyboard, and users with motor skills challenges typically find a keyboard much easier to control than a mouse. Combined with the Narrator (which we cover in a different module), keyboard navigation gives those with more severe visual challenges a chance to use your app.

In this unit we will learn:
- The advantages of arrow-controlled navigation over Tab key navigation.
- How to use the **FocusManager** to handle arrow control.
- How to add accelerator keys to all UI elements
- That there are some issues with radio buttons and arrow navigation.

## Keyboard navigation

There are two standard ways of navigating an app using the keyboard: Tab index navigation and arrow key navigation. In this unit we will discuss both, but only implement arrow navigation as the more appropriate for our test app.

### Implement arrow key navigation

Tab navigation involves adding explicit **TabIndex** entries to the XAML file. The  **Tab** key is then used to progress through the UI elements in the order defined by the index, while **Shift Tab** will progress backwards through the index. Arrow key navigation does not involve any changes to the XAML, but will require additions to your app's code.

1. By default, the tab index of our buttons starts top left. Run the app and select **Show constants**, then press the space bar to close the list of constants. Now press the **Tab** key repeatedly. Notice how your selection travels down the columns of buttons, then onto the next column, and so on. Try **Shift Tab** a few times to go back.

2. As a test of where the tab index does not follow the order of buttons, open the Calculator that comes with Windows. Select any key with the mouse pointer, then press **Tab** many times. Notice how the functions are grouped together; the numbers are traversed in order, as are the mathematical operations.

3. However, our scientific calculator has a great deal of buttons, making tab navigation unwieldy. We can do better. Close the Windows calculator, open the *MainPage.xaml.cs* file, and find the **Grid_KeyDown** method. Currently, the method only tests for the **PageDown** key, to show and hide the inner mechanics of the calculator (we won't be covering this feature as part of the module).

> [!NOTE]
> Tab navigation will still work in this app, but it'll just use the default list of buttons, with no unique behavior.

4. As this calculator is so obviously grid-based, using arrow keys to traverse left and right as well as up and down would seem like the most intuitive solution. This feature is provided by the **FocusManager** class. Replace the code for **Grid_KeyDown** with the following method. The key calls are to **TryMoveFocus**, with a few tests for the mode the calculator is in to support the list of constants.

```cs
        private void Grid_KeyDown(object sender, KeyRoutedEventArgs e)
        {
            switch (e.Key)
            {
                case Windows.System.VirtualKey.Up:
                    if (mode != Emode.SelectConstant || (ListConstants.SelectedIndex > 0 &&
                        ListConstants.FocusState == FocusState.Keyboard))
                    {
                        FocusManager.TryMoveFocus(FocusNavigationDirection.Up);
                    }
                    break;

                case Windows.System.VirtualKey.Down:
                    if (mode != Emode.SelectConstant || (ListConstants.SelectedIndex < ListConstants.Items.Count - 1 &&
                        ListConstants.FocusState == FocusState.Keyboard))
                    {
                        FocusManager.TryMoveFocus(FocusNavigationDirection.Down);
                    }
                    break;

                case Windows.System.VirtualKey.Left:
                    if (mode != Emode.SelectConstant || ListConstants.SelectedIndex == 0)
                    {
                        FocusManager.TryMoveFocus(FocusNavigationDirection.Left);
                    }
                    break;

                case Windows.System.VirtualKey.Right:
                    if (mode != Emode.SelectConstant || ButtonConstant.FocusState == FocusState.Keyboard)
                    {
                        FocusManager.TryMoveFocus(FocusNavigationDirection.Right);
                    }
                    break;

                case Windows.System.VirtualKey.PageDown:
                    if (ListTokens.Visibility == Visibility.Collapsed)
                    {
                        ListTokens.Visibility = Visibility.Visible;
                    }
                    else
                    {
                        ListTokens.Visibility = Visibility.Collapsed;
                    }
                    break;

                default:
                    // Do nothing.
                    break;
            }
        }
```
5. To set the initial focus of an element, add the following code to the last line of the **MainPage** method.

```cs
        ButtonConstant.Focus(FocusState.Keyboard);
```

6. Now run your app and use the four arrow keys to move around. Notice how quick movement across the grid is. Also, locate  **Show constants**, press the space bar to select it, and move the focus into the list by selecting the right arrow. You can now traverse up and down the list, then out of the list of constants by moving to the first constant and selecting the left arrow. Note we are not yet able to use the keyboard to enter a constant into our calculation, so let's add that now. Add the following code as another `case` in the **Grid_KeyDown** method.

```cs
                case Windows.System.VirtualKey.Insert:
                    if (mode == Emode.SelectConstant && ListConstants.SelectedIndex >= 0)
                    {
                        InsertConstantInCalculation();
                    }
                    break;
```

7. To increase usability further, add some help text to the **Show Constants** button. Add the following attribute to its code in the XAML file.

```xml
ToolTipService.ToolTip="Right arrow to enter the list of constants. Double click, or use the Insert button, to include a constant in your calculation."
```


8. Keyboard navigation using the arrow keys is great, but can run into a few glitches. For one, arrowing across the full width of the calculator can get tiresome. To alleviate this, add the following cases to the **Grid_KeyDown** method. They respective allow the user to press the **Home** and **End** keys to jump to the top-right and bottom-left buttons.

```cs
                case Windows.System.VirtualKey.Home:
                    ButtonConstant.Focus(FocusState.Keyboard);
                    break;

                case Windows.System.VirtualKey.End:
                    ButtonEquals.Focus(FocusState.Keyboard);
                    break
```

Radio buttons are another problem. As you may already have found, once you enter a list of radio buttons with the arrow keys, using the arrow keys does not get you back out. As we've given the user the Home and End buttons as a way out, we could just ignore the problem. Alternately, we could add code to handle a conditional case, to jump to the next UI element up when a radio button is highlighted and the up arrow is pressed.

Another method is to replace radio buttons with UI elements without this behavior. Let's try that.

### Replace radio buttons with toggle switches

Let's replace the **Degrees"** and **"Radians"** radio buttons with a toggle switch.

1. In the `MainPage.xaml` file find the following entries.

```xml
        <RadioButton x:Name="RadioDegrees" Content="Degrees"
            Margin="396,401,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" IsChecked="True"
            />

        <RadioButton x:Name="RadioRadians" Content="Radians"
            Margin="397,439,0,0" HorizontalAlignment="Left" VerticalAlignment="Top"
            />
```

2. Replace them both with the following single item.

```cs
        <ToggleSwitch x:Name="ToggleAngles"
            Margin="391,407,0,0"
            HorizontalAlignment="Left"
            VerticalAlignment="Top"
            Header="Angles in degrees"
            IsOn="True" />
```

3. Now update a few other sections of code to address the change in UI elements. Replace the **RadiansToDegrees** and **DegreesToRadians** methods with the code below.

```cs
        private double RadiansToDegrees(double d)
        {
            if (ToggleAngles.IsOn)
            {
                return (d * 180d) / Math.PI;
            }
            return d;
        }

        private double DegreesToRadians(double d)
        {
            if (ToggleAngles.IsOn)
            {
                return (d * Math.PI) / 180d;
            }
            return d;
        }
```

4. Run the app and test the arrow navigation again. It should now easily navigate through the toggle switches, with no difficulties encountered.


### Add accelerator keys to all buttons and UI controls

Providing keyboard accelerators, or shortcuts, for all buttons and UI controls are an accessibility tool which is often appreciated by power users. Here, we'll use them to provide an alternative method of triggering UI actions in your app, other than traditional pointer input or the earlier keyboard navigation.

Keyboard accelerators are added to a button in the XAML definition of that button. The available modifiers for the custom keyboard shortcut are **Control**, **Menu**, **None**, **Shift** and **Windows**. We recommend that you use the **Control**, **Menu** and **Shift** modifiers freely, and avoid the **Windows** modifier (as its use can trigger a number of Windows functions that will take precedence over your app).

> [!NOTE]
> You might be surprised that the **Alt** is not included in this list of modifiers. Don't worry - it's represented by the **Menu** option.

More than one accelerator can be applied to any one button. Here, both regular and number pad 9 key will work to trigger the **9** button. Don't include this in your code yet.

```xml
           <Button x:Name="Button9" Content="9"
                Grid.Row="0"
                Grid.Column="7"
                Width="60"
                Height="50"
                Margin="5,5,20,5"
                BorderBrush="Black"
                BorderThickness="1,1,3,3"
                Click="Button_Click"
                FontSize="24"
                FontWeight="SemiBold"
                Tag="Digit">
                <Button.KeyboardAccelerators>
                    <KeyboardAccelerator Key="Number9" Modifiers="None" />
                    <KeyboardAccelerator Key="NumberPad9" Modifiers="None" />
                </Button.KeyboardAccelerators>
            </Button>
```

Similarly, here's an example of a toggle switch with a custom **Control + a** accelerator.

```xml
        <ToggleSwitch x:Name="ToggleAngles"
            Margin="391,407,0,0"
            HorizontalAlignment="Left"
            VerticalAlignment="Top"
            Header="Angles in degrees"
            IsOn="True" >
            <ToggleSwitch.KeyboardAccelerators>
                <KeyboardAccelerator Key="A" Modifiers="Control" />
            </ToggleSwitch.KeyboardAccelerators>
        </ToggleSwitch>
```
> [!NOTE]
> There is an implied importance to the first accelerator in the list. This will be the only one appearing as tooltip text, or presented via the Narrator.

1. Ideally, you should enter a keyboard accelerator for _every_ button and toggle switch. To test their function is this unit, at least replace the following buttons with these new definitions.

```xml
            <Button x:Name="Button8" Content="8"
                Grid.Row="0"
                Grid.Column="6"
                Width="60"
                Height="50"
                Margin="5,5,20,5"
                BorderBrush="Black"
                BorderThickness="1,1,3,3"
                Click="Button_Click"
                FontSize="24"
                FontWeight="SemiBold"
                Tag="Digit">
                <Button.KeyboardAccelerators>
                    <KeyboardAccelerator Key="Number8" Modifiers="None" />
                    <KeyboardAccelerator Key="NumberPad8" Modifiers="None" />
                </Button.KeyboardAccelerators>
            </Button>

           <Button x:Name="ButtonSqrt" AutomationProperties.Name="Square root" Content="Sqrt"
                Grid.Row="3"
                Grid.Column="3"
                Width="60"
                Height="50"
                Margin="5,5,20,5"
                BorderBrush="Black"
                BorderThickness="1,1,3,3"
                Click="Button_Click"
                FontSize="16"
                FontWeight="SemiBold"
                Tag="Sqrt">
                <Button.KeyboardAccelerators>
                    <KeyboardAccelerator Key="F2" Modifiers="None" />
                </Button.KeyboardAccelerators>
            </Button>

            <Button x:Name="Button9" Content="9"
                Grid.Row="0"
                Grid.Column="7"
                Width="60"
                Height="50"
                Margin="5,5,20,5"
                BorderBrush="Black"
                BorderThickness="1,1,3,3"
                Click="Button_Click"
                FontSize="24"
                FontWeight="SemiBold"
                Tag="Digit">
                <Button.KeyboardAccelerators>
                    <KeyboardAccelerator Key="Number9" Modifiers="None" />
                    <KeyboardAccelerator Key="NumberPad9" Modifiers="None" />
                </Button.KeyboardAccelerators>
            </Button>

            <Button x:Name="ButtonEquals" AutomationProperties.Name="equals" Content="="
                Grid.Row="3"
                Grid.Column="8"
                Width="60"
                Height="50"
                Margin="15,5,20,5"
                BorderBrush="Black"
                BorderThickness="1,1,3,3"
                Click="Button_Click"
                FontSize="24"
                FontWeight="Bold">
                <Button.KeyboardAccelerators>
                    <KeyboardAccelerator Key="E" Modifiers="None" />
                </Button.KeyboardAccelerators>
            </Button>

```

2. Now run the app, and use the keyboard to enter the calculation **8 Sqrt 9**. You should be able to accomplish this with the following keyboard commands: 8, F2, 9, E. You should get the result **24**.

3. When navigating the calculator using the keyboard arrows or the mouse pointer, notice how the keyboard accelerators appear as tooltip text. This can save you the hassle of communicating this information to your users yourself.

4. Ideally, all the interactable UI elements in your app should have keyboard accelerators. When adding accelerators to the entire app, however, it's easy to accidentally apply the same to two keys. We encourage you to use an organized spreadsheet or other documentation to ensure that you don't cause overlap, which could ruin the user experience.

Feel free to add other accelerators to further enhance your app, if you want.

## Unit summary

In this unit you have gone a long way to making your app inclusive for users with more than slight impairments. You have learned how to implement a solid arrow-based keyboard navigation system. You have also learned that accelerator keys should be added to all UI elements. These two additions make your app completely controllable from the keyboard. You now have a robust inclusive app.

In the next unit, we go further and implement speech recognition for our app. Get this going and users can almost use your app eyes and hands free. Almost.
