![Tech logo for U W P and W P F.](../media/tech-all.png)

In this unit, we build on the ideas from the previous two units. Over the course of this lesson, we build a specialized calculator that accepts user input through various ways:

- Text input
- Buttons
- Sliders
- Specialized controls like `DatePicker`

This app uses a combination of the most popular layout controls. It shows you how to take these steps:

- Accept user input through button selections and text entry.
- Act on this input.
- Display the calculated results back to the user.

In this unit, we learn how to do these things:

- Create a user interface with various ways for the user to enter information.
- Use events and event handlers to act when the user enters the information.
- Use the input to perform a calculation and display the result to the user.

Let's get started.

### Accepting user input

::: zone pivot="uwp"

![Tech logo for U W P and W P F. W P F appears dimmed.](../media/tech-uwp.png)

#### Create a new project

With Visual Studio open, create a UWP C# project. Give the project a meaningful name for this lesson. An example is **UserInput.Uwp**.

:::image type="content" source="../media/1-create-new-project-uwp.png" alt-text="Screenshot that shows the Configure your new project window with red boxes around the Blank App (Universal Windows) project type, the Project name text box, and the Create button.":::

#### Input controls

A wide variety of controls are built to accept user input. In this unit, we use a few of the most common controls to get basic information from a user. This information is text, numeric, date, and true or false Boolean values.

- `Button`. The `Button` is one of the most popular and natural ways that a user interacts with an application. When it's selected, it triggers a **Click** event that you can use to run logic.
- `TextBox`. With this control, the user can enter text information. It has a **Text** property that you can read anytime. Or you can subscribe to the **TextChanged** event to get character-by-character changes.
- `Slider`. With this control, the user can slide a handle to set a **Value** between a **Minimum** and **Maximum** range of numbers with a preset precision. For example, a volume slider sets a value between 0 and 100 percent at 1 percent increments.
- `DatePicker`. As the name suggests, by using this control, the user can enter a date value. With many `DatePicker` controls, the user can select the date from a pop-up menu or enter a value by using text.
- `RadioButton`. This control is like a `CheckBox`. But it's round in appearance and can be grouped with other `RadioButton`s for exclusive selection.

In this application, we set up a user interface with the following requirements:

- The user can enter numeric values by using both text and numbers in a `TextBox`.
- The user can enter a second number by using a `Slider`.
- Select a `RadioButton` to set an arithmetic operation. Examples are add and subtract.
- Select a `Button` to run the arithmetic logic and display the output.
- Optionally, the user can add a time stamp to the output with a `DatePicker`.

Now you know the controls we can use and what they're be used for. Let's build the app.

Open **MainPage.xaml** and create a `StackPanel` with centered **HorizontalAlignment** and **VerticalAlignment**:

```xml
<Page
    x:Class="UserInput.MainPage"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="using:UserInput"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    mc:Ignorable="d"
    Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

        </StackPanel>
    </Grid>
</Page>
```

The first child of the `StackPanel` is our first input control, the `TextBox`. Let's start by setting the **FontFamily**, **TextAlignment**, **HorizontalAlignment**, **Watermark**, and **Width**:

```xml
<Page
    x:Class="UserInput.MainPage"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="using:UserInput"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    mc:Ignorable="d"
    Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     PlaceholderText="enter first number"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     Width="220"/>

        </StackPanel>
    </Grid>
</Page>
```

> [!NOTE]
> The **Watermark** property is text that's shown when the TextBox.Text is empty. Think of it as having a `TextBlock` behind the `TextBox`. So you can tell the user what to enter.

Now we do something we haven't covered yet in this module. We subscribe to an **event** and use an **event handler**.

Add the **FirstNumberBox_OnTextChanged** event handler to the `TextBox`'s **TextChanged** event:

```xml
<TextBox x:Name="FirstNumberBox"
         PlaceholderText="enter first number"
         FontFamily="Consolas"
         TextAlignment="Center"
         HorizontalAlignment="Center"
         Width="220"
         TextChanged="FirstNumberBox_OnTextChanged" />
```

Next, we use a Visual Studio feature to automatically add the **FirstNumberBox_OnTextChanged** event handler to the code-behind file and fix the error.

Put your cursor in the middle of the **FirstNumberBox_OnTextChanged** text. Go to the **Properties** window, and select the lightning icon. You see a list of event handlers. Scroll to **TextChanged**, and then double-click the text in the text box.

:::image type="content" source="../media/3-properties-event-handler.png" alt-text="Screenshot that shows the Properties window with a red box around the TextChanged text box.":::

Visual Studio opens **MainPage.xaml.cs** and automatically inserts the missing code. **MainPage.xaml.cs** is also known as the **code-behind file**.

The `MainPage` class now looks like this code:

```csharp
using System;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        public MainPage()
        {
            this.InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {

        }
    }
}
```

Any code you put inside the event handler is run every time the user changes the text in the `TextBox`. We use the `TextBox` to get the user-entered text and convert it to a number we can use for a math operation.

Before we start to write any event handler code, we want a variable for the current number value. We might use an `integer`. But we want to calculate results with decimal precision. So a `double` is more suitable.

Add a **FirstNumber** property to the code-behind file:

```csharp
using System;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;

public sealed partial class MainPage : Page
{
	// Gets or sets the value of the first number that the arithmetic will be performed on.
	private double? FirstNumber { get; set; }

	public MainPage()
	{
		this.InitializeComponent();
	}

	private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
	{

	}
}

```
> [!NOTE]
> The `?` after `double` declares that it's **nullable**. Null is different than 0. It means there's no value at all. Null is important because later, we check to see if the user entered a value in the first `TextBox`. We want to do the calculation if the user entered 0 **but not if the user left it empty**.

Next, we finish the logic we want to run when the `TextBox`'s **TextChanged** event occurs. Update the code to contain the following snippet. The code comments explain what each step does:

```csharp
using System;
using System.Linq;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        public MainPage()
        {
            this.InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }
    }
}
```

> [!IMPORTANT]
> Notice the new `using` statements at the top of the file. They do the same thing that **xmlns** does for XAML. With these statements, the file you're working in can access code in the namespace. In the preceding code snippet, by using the `System.Linq` namespace, we can use the `LastOrDefault()` method.

Before we move forward, let's add another `double SecondNumber` property to hold the value of a second number. We use it for a math operation later in this lesson:

```csharp
using System;
using System.Linq;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        public MainPage()
        {
            this.InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }
    }
}
```


Now we want to give the user the ability to choose between different math operations. We use the `RadioButton` to make the selection. But before we do that, we need to create the math operations and a way to know which one is selected.

First, let's add a **SelectedMathFunction** property to the `MainPage` class:

```csharp
using System;
using System.Linq;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainPage()
        {
            this.InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }
    }
}
```

`Func<double, double, double>` might look complicated if you're not used to C#. It means *I'm a function that takes two numbers of type `double` and gives back one number of type `double`*. This function is perfect for our math operations.

To help visualize, let's talk about the `Add` operation. To add two numbers together, define the method:

```csharp
// This method accepts two number parameters "a" and "b", and returns one number "result"
private double Add(double a, double b)
{
    double result = a + b;
    return result;
}
```

This image shows how the `SecondNumber` method's parameters line up with the **SelectedMathFunction** definition.

![Explaining SelectedMathFunction.](../media/uwp-user-input-func.png)

We can create four methods to use for that `Func`: **Add**, **Subtract**, **Multiply**, and **Divide**. Remember that the method must accept two `double` parameters and return one `double` value.

Now let's define all four methods in the `MainPage` class:

```csharp
using System;
using System.Linq;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainPage()
        {
            this.InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }
    }
}
```

With the math operations defined, we can add UI elements that the user can select. A `RadioButton` works like a `CheckBox`. But you can group `RadioButton`s together. So only one item can be selected at a time by using the **GroupName** property.

Let's add a `StackPanel` with four `RadioButton` elements. All have the **GroupName** of *MathOperator*:

```xml
<Page
    x:Class="UserInput.MainPage"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="using:UserInput"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    mc:Ignorable="d"
    Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     PlaceholderText="enter first number"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     Width="220"
                     TextChanged="FirstNumberBox_OnTextChanged" />

            <StackPanel Margin="10"
                        Spacing="-5"
                        HorizontalAlignment="Center">
                <RadioButton Content="Add"
                             IsChecked="True"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Subtract"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Multiply"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Divide"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
            </StackPanel>

        </StackPanel>
    </Grid>
</Page>
```

We set `GroupName="MathOperator"` on each of the `RadioButton`s. So only one of them can be selected at a time.

Next, resolve the **RadioButton_OnChecked** event handler. As you did for the `TextBox`, add the code to the `MainPage` class:

```csharp
using System;
using System.Linq;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainPage()
        {
            this.InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }

        // We can use one Checked event handler for all the RadioButtons to avoid code duplication.
        private void RadioButton_OnChecked(object sender, RoutedEventArgs e)
        {
            // We can use a single line of code to get the RadioButton reference.
            var radioButton = sender as RadioButton;

            // Get the value of the RadioButton's Content (this contains the name of the math operation we want).
            string radioButtonContent = radioButton?.Content?.ToString();

            // Set the appropriate arithmetic operation to use by checking radioButtonContent's value.
            switch (radioButtonContent)
            {
                case "Add":
                    SelectedMathFunction = Add;
                    break;
                case "Subtract":
                    SelectedMathFunction = Subtract;
                    break;
                case "Multiply":
                    SelectedMathFunction = Multiply;
                    break;
                case "Divide":
                    SelectedMathFunction = Divide;
                    break;
                default:
                    SelectedMathFunction = null;
                    break;
            }
        }
    }
}
```

We use the **Content** property of the `RadioButton` to know which one was selected. Then set the **SelectedMathFunction** value accordingly.

> [!NOTE]
> In most cases, you use a separate event handler for an event. An example is **FirstNumberBox_OnTextChanged**. But in this case, we reuse the same event handler. 

To get the second number's value, we use another `TextBox` like we did for the first number. But this time, we disable the `TextBox` and use a `Slider` control to set the **Text** programmatically.

Add the **SecondNumberTextBox** and **SecondNumberSlider** just underneath the `RadioButton`'s `StackPanel`:

```xml
<Page
    x:Class="UserInput.MainPage"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="using:UserInput"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    mc:Ignorable="d"
    Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     PlaceholderText="enter first number"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     Width="220"
                     TextChanged="FirstNumberBox_OnTextChanged" />

            <StackPanel Margin="10"
                        Spacing="-5"
                        HorizontalAlignment="Center">
                <RadioButton Content="Add"
                             IsChecked="True"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Subtract"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Multiply"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Divide"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
            </StackPanel>

            <TextBox x:Name="SecondNumberBox"
                     IsReadOnly="True"
                     PlaceholderText="Use Slider for 2nd number"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     Width="220"
                     TextChanged="SecondNumberBox_OnTextChanged" />

            <Slider x:Name="SecondNumberSlider"
                    Minimum="-10"
                    Maximum="10"
                    StepFrequency="0.01"
                    Width="220"
                    ValueChanged="SecondNumberSlider_OnValueChanged" />
        </StackPanel>
    </Grid>
</Page>
```

Now add the **SecondNumberBox_OnTextChanged** and **SecondNumberSlider_OnValueChanged** event handlers to the `MainPage` class:

```csharp
using System;
using System.Linq;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainPage()
        {
            this.InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }

        // We can use one Checked event handler for all the RadioButtons to avoid code duplication.
        private void RadioButton_OnChecked(object sender, RoutedEventArgs e)
        {
            // We can use a single line of code to get the RadioButton reference.
            var radioButton = sender as RadioButton;

            // Get the value of the RadioButton's Content (this contains the name of the math operation we want).
            string radioButtonContent = radioButton?.Content?.ToString();

            // Set the appropriate arithmetic operation to use by checking radioButtonContent's value.
            switch (radioButtonContent)
            {
                case "Add":
                    SelectedMathFunction = Add;
                    break;
                case "Subtract":
                    SelectedMathFunction = Subtract;
                    break;
                case "Multiply":
                    SelectedMathFunction = Multiply;
                    break;
                case "Divide":
                    SelectedMathFunction = Divide;
                    break;
                default:
                    SelectedMathFunction = null;
                    break;
            }
        }

        private void SecondNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // We can reuse the same logic we did for the FirstNumberBox.
            if (string.IsNullOrEmpty(SecondNumberBox?.Text))
            {
                SecondNumber = null;
                return;
            }

            if (double.TryParse(SecondNumberBox.Text, out double parsedNumber))
            {
                SecondNumber = parsedNumber;
            }
            else
            {
                SecondNumberBox.Text = SecondNumberBox.Text.TrimEnd(SecondNumberBox.Text.LastOrDefault());
            }
        }

        private void SecondNumberSlider_OnValueChanged(object sender, RangeBaseValueChangedEventArgs e)
        {
            // You would typically use e.NewValue to get the Slider's value as it changes.
            // However, the SecondNumberBox.TextChanged event is already getting the value,
            // we can just set the SecondNumberBox.Text instead.
            SecondNumberBox.Text = e.NewValue.ToString("N");
        }
    }
}
```

The `Slider` control's **ValueChanged** event passes the user's selection inside the `RangeBaseValueChangedEventArgs` parameter. Then we use the numeric **e.NewValue** from the `Slider` and update the `TextBox`'s **Text** with it. This action causes the **SecondNumberBox_OnTextChanged** event handler to be invoked. It then updates the **SecondNumber** property.

You usually set `SecondNumber` directly with **e.NewValue**. By doing it this way, you can prevent a user from interacting with parts of your UI. But it still provides visual feedback.

Finally, let's add the ability to append a date stamp to the calculation output. When you use the `DatePicker` control, you can accept date values from the user. You don't have to parse text from a `TextBox` into a correct `DateTime` object.

Add the following **CalculationDatePicker** `DatePicker` and **IncludeDateCheckBox** `CheckBox` to the XAML. When you use the `CheckBox`, the user can select whether or not the output gets a date stamp:

```xml
<Page
    x:Class="UserInput.MainPage"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="using:UserInput"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    mc:Ignorable="d"
    Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     PlaceholderText="enter first number"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     Width="220"
                     TextChanged="FirstNumberBox_OnTextChanged" />

            <StackPanel Margin="10"
                        Spacing="-5"
                        HorizontalAlignment="Center">
                <RadioButton Content="Add"
                             IsChecked="True"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Subtract"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Multiply"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Divide"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
            </StackPanel>

            <TextBox x:Name="SecondNumberBox"
                     IsReadOnly="True"
                     PlaceholderText="Use Slider for 2nd number"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     Width="220"
                     TextChanged="SecondNumberBox_OnTextChanged" />

            <Slider x:Name="SecondNumberSlider"
                    Minimum="-10"
                    Maximum="10"
                    StepFrequency="0.01"
                    Width="220"
                    ValueChanged="SecondNumberSlider_OnValueChanged" />

            <CheckBox x:Name="IncludeDateCheckBox"
                      Content="Include Date and Time in results"
                      Checked="IncludeDateCheckBox_OnChecked"
                      Unchecked="IncludeDateCheckBox_OnUnchecked"
                      HorizontalAlignment="Center" />

            <DatePicker x:Name="CalculationDatePicker"
                        Visibility="Collapsed"
                        HorizontalAlignment="Stretch"
                        Margin="0,0,0,10" />
        </StackPanel>
    </Grid>
</Page>                     
```

Next, add the event handlers **IncludeDateCheckBox_OnChecked** and **IncludeDateCheckBox_OnUnchecked** to your `MainPage` class:

```csharp
using System;
using System.Linq;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainPage()
        {
            this.InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }

        // We can use one Checked event handler for all the RadioButtons to avoid code duplication.
        private void RadioButton_OnChecked(object sender, RoutedEventArgs e)
        {
            // We can use a single line of code to get the RadioButton reference.
            var radioButton = sender as RadioButton;

            // Get the value of the RadioButton's Content (this contains the name of the math operation we want).
            string radioButtonContent = radioButton?.Content?.ToString();

            // Set the appropriate arithmetic operation to use by checking radioButtonContent's value.
            switch (radioButtonContent)
            {
                case "Add":
                    SelectedMathFunction = Add;
                    break;
                case "Subtract":
                    SelectedMathFunction = Subtract;
                    break;
                case "Multiply":
                    SelectedMathFunction = Multiply;
                    break;
                case "Divide":
                    SelectedMathFunction = Divide;
                    break;
                default:
                    SelectedMathFunction = null;
                    break;
            }
        }

        private void SecondNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // We can reuse the same logic we did for the FirstNumberBox.
            if (string.IsNullOrEmpty(SecondNumberBox?.Text))
            {
                SecondNumber = null;
                return;
            }

            if (double.TryParse(SecondNumberBox.Text, out double parsedNumber))
            {
                SecondNumber = parsedNumber;
            }
            else
            {
                SecondNumberBox.Text = SecondNumberBox.Text.TrimEnd(SecondNumberBox.Text.LastOrDefault());
            }
        }

        private void SecondNumberSlider_OnValueChanged(object sender, RangeBaseValueChangedEventArgs e)
        {
            // You would typically use e.NewValue to get the Slider's value as it changes.
            // However, the SecondNumberBox.TextChanged event is already getting the value,
            // we can just set the SecondNumberBox.Text instead.
            SecondNumberBox.Text = e.NewValue.ToString("N");
        }

        private void IncludeDateCheckBox_OnChecked(object sender, RoutedEventArgs e)
        {
            // When the CheckBox is checked, show the DatePickers.
            CalculationDatePicker.Visibility = Visibility.Visible;
            CalculationDatePicker.SelectedDate = DateTimeOffset.Now;
        }

        private void IncludeDateCheckBox_OnUnchecked(object sender, RoutedEventArgs e)
        {
            // When the CheckBox is unchecked, hide the DatePickers.
            CalculationDatePicker.Visibility = Visibility.Collapsed;
        }
    }
}
```

When the `CheckBox` is selected, it shows the `DatePicker`. When it's not selected, the `DatePicker` is hidden. We also set the `DatePicker` **SelectedDate** to the current date and time.

Now let's perform the calculations.

Normally, you can perform the calculations whenever the input changes on any of the controls. In this case, we keep things simple and use the following controls:

* A `Button` with a **Click** event handler.
* A `TextBlock` to show the results.

Add the final `Button` and **ResultsTextBlock** `TextBlock` controls underneath the `DatePicker`:

```xml
<Page
    x:Class="UserInput.MainPage"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="using:UserInput"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    mc:Ignorable="d"
    Background="{ThemeResource ApplicationPageBackgroundThemeBrush}">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     PlaceholderText="enter first number"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     Width="220"
                     TextChanged="FirstNumberBox_OnTextChanged" />

            <StackPanel Margin="10"
                        Spacing="-5"
                        HorizontalAlignment="Center">
                <RadioButton Content="Add"
                             IsChecked="True"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Subtract"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Multiply"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Divide"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
            </StackPanel>

            <TextBox x:Name="SecondNumberBox"
                     IsReadOnly="True"
                     PlaceholderText="Use Slider for 2nd number"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     Width="220"
                     TextChanged="SecondNumberBox_OnTextChanged" />

            <Slider x:Name="SecondNumberSlider"
                    Minimum="-10"
                    Maximum="10"
                    StepFrequency="0.01"
                    Width="220"
                    ValueChanged="SecondNumberSlider_OnValueChanged" />

            <CheckBox x:Name="IncludeDateCheckBox"
                      Content="Include Date and Time in results"
                      Checked="IncludeDateCheckBox_OnChecked"
                      Unchecked="IncludeDateCheckBox_OnUnchecked"
                      HorizontalAlignment="Center" />

            <DatePicker x:Name="CalculationDatePicker"
                        Visibility="Collapsed"
                        HorizontalAlignment="Stretch"
                        Margin="0,0,0,10" />

            <Button Content="Calculate Results"
                    HorizontalAlignment="Stretch"
                    Click="EqualsButton_OnClick"
                    Margin="0,10" />

            <TextBlock x:Name="ResultsTextBlock"
                       Text="---"
                       FontSize="22"
                       FontWeight="Bold"
                       FontFamily="Consolas"
                       VerticalAlignment="Center"
                       HorizontalAlignment="Center" />
        </StackPanel>
    </Grid>
</Page>
```

Next, add the **EqualsButton_OnClick** event handler to the `MainPage` class:

```csharp
using System;
using System.Linq;
using Windows.UI.Popups;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;

namespace UserInput
{
    public sealed partial class MainPage : Page
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainPage()
        {
            this.InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }

        // We can use one Checked event handler for all the RadioButtons to avoid code duplication.
        private void RadioButton_OnChecked(object sender, RoutedEventArgs e)
        {
            // We can use a single line of code to get the RadioButton reference.
            var radioButton = sender as RadioButton;

            // Get the value of the RadioButton's Content (this contains the name of the math operation we want).
            string radioButtonContent = radioButton?.Content?.ToString();

            // Set the appropriate arithmetic operation to use by checking radioButtonContent's value.
            switch (radioButtonContent)
            {
                case "Add":
                    SelectedMathFunction = Add;
                    break;
                case "Subtract":
                    SelectedMathFunction = Subtract;
                    break;
                case "Multiply":
                    SelectedMathFunction = Multiply;
                    break;
                case "Divide":
                    SelectedMathFunction = Divide;
                    break;
                default:
                    SelectedMathFunction = null;
                    break;
            }
        }

        private void SecondNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // We can reuse the same logic we did for the FirstNumberBox.
            if (string.IsNullOrEmpty(SecondNumberBox?.Text))
            {
                SecondNumber = null;
                return;
            }

            if (double.TryParse(SecondNumberBox.Text, out double parsedNumber))
            {
                SecondNumber = parsedNumber;
            }
            else
            {
                SecondNumberBox.Text = SecondNumberBox.Text.TrimEnd(SecondNumberBox.Text.LastOrDefault());
            }
        }

        private void SecondNumberSlider_OnValueChanged(object sender, RangeBaseValueChangedEventArgs e)
        {
            // You would typically use e.NewValue to get the Slider's value as it changes.
            // However, the SecondNumberBox.TextChanged event is already getting the value,
            // we can just set the SecondNumberBox.Text instead.
            SecondNumberBox.Text = e.NewValue.ToString("N");
        }

        private void IncludeDateCheckBox_OnChecked(object sender, RoutedEventArgs e)
        {
            // When the CheckBox is checked, show the DatePickers.
            CalculationDatePicker.Visibility = Visibility.Visible;
            CalculationDatePicker.SelectedDate = DateTimeOffset.Now;
        }

        private void IncludeDateCheckBox_OnUnchecked(object sender, RoutedEventArgs e)
        {
            // When the CheckBox is unchecked, hide the DatePickers.
            CalculationDatePicker.Visibility = Visibility.Collapsed;
        }

        private async void EqualsButton_OnClick(object sender, RoutedEventArgs e)
        {
            // Before doing any calculations, confirm the user entered both numbers.
            if (FirstNumber == null || SecondNumber == null)
            {
                await new MessageDialog("You need to set both numbers to calculate a result.").ShowAsync();
                return;
            }

            // Now is a good time to do some validation on the numbers and prevent any serious problems.
            // For example, here we make sure the user isn't trying to divide from zero, this can crash your app!
            if (SecondNumber == 0 && SelectedMathFunction == Divide)
            {
                await new MessageDialog("You cannot divide from zero, please pick a different 2nd number.").ShowAsync();
                return;
            }

            // Next, it's time to do the actual math. We only need to pass the two numbers into the SelectedMathFunction.
            double result = SelectedMathFunction((double)FirstNumber, (double)SecondNumber);

            // Finally, show the result to the user!
            if (IncludeDateCheckBox.IsChecked == true)
            {
                // If the CheckBox was checked, show the number with the "N2" string format (a number to 2 decimal points),
                // but also include the Date in the output with the "d" string format (a short date format).
                ResultsTextBlock.Text = $"Result: {result:N2}, Date: {CalculationDatePicker.SelectedDate:d}";
            }
            else
            {
                // If the CheckBox was not checked, show the number with the "N2" string format (a number to 2 decimal points).
                ResultsTextBlock.Text = $"Result: {result:N2}";
            }
        }
    }
}
```

The code comments explain the details. But let's briefly walk through what's going on at a high level:

1. First, we make sure the user's input is valid and doesn't crash the app: `if (FirstNumber == null || SecondNumber == null)` and `if (SecondNumber == 0 && SelectedMathFunction == Divide)`.

2. To perform the calculation, we invoke the **SelectedMathFunction** function: `double result = SelectedMathFunction((double)FirstNumber, (double)SecondNumber)`.

3. Finally, we check if the user wants a date stamp and then append the date to the results: `IncludeDateCheckBox.IsChecked == true)`.

The coding is done. Now let's test your application.

#### Runtime

Let's deploy the application and try it out. Select F5 to build, deploy, and start debugging. You're presented with the following UI:

:::image type="content" source="../media/3-complete-app-no-entry-uwp.png" alt-text="Screenshot that shows the finished app UI with nothing selected and all text boxes empty.":::

To try the app, take these steps:

1. Enter a number into the first `TextBox` to set **FirstNumber**.
2. Select a `RadioButton` to set **SelectedMathFunction**. Notice that you can only make one selection at a time.
3. Move the `Slider` to set **SecondNumber**. Notice that the `Slider` updates the `TextBox`'s **Text**.
4. Select the `CheckBox` to make the `DatePicker` appear.
5. Select the **Calculate Results** `Button`. Now you see the results shown underneath.

The finished result looks like this image:

:::image type="content" source="../media/3-complete-app-uwp.png" alt-text="Screenshot that shows the finished app with numbered red arrows pointing to selections in the app.":::

::: zone-end

::: zone pivot="wpf"

![Tech logo for U W P and W P F. U W P appears dimmed.](../media/tech-wpf.png)

#### Create a new project

With Visual Studio open, create a WPF C# project. Give the project a meaningful name for this lesson. An example is **UserInput.Wpf**.

:::image type="content" source="../media/1-create-new-project-wpf.png" alt-text="Screenshot that shows the Configure your new project window with red boxes around the WPF Application project type, the Project name text box, and the Next button.":::

#### Input controls

A wide variety of controls are built to accept user input. In this unit, we use a few of the most common controls to get basic information from a user. This information is text, numeric, date, and true or false Boolean values.

- `Button`. The `Button` is one of the most popular and natural ways that a user interacts with an application. When it's selected, it triggers a **Click** event you can use to run logic.
- `TextBox`. with this control, the user can enter text information. You can read its **Text** property anytime. Or you can subscribe to the **TextChanged** event to get character-by-character changes.
- `Slider`. with this control, the user can slide a handle to set a **Value** between a **Minimum** and **Maximum** range of numbers with a preset precision. For example, a volume slider sets a value between 0 and 100 percent at 1 percent increments.
- `DatePicker`. As the name suggests, by using this control, the user can enter a date value. With many `DatePicker` controls, the user can select the date from a pop-up menu or enter a value by using text.
- `RadioButton`. This control is similar to a `CheckBox`. But it's round in appearance and can be grouped with other `RadioButton`s for exclusive selection.

In this application, we set up a user interface with the following requirements:

- The user can enter numeric values by using both text and numbers in a `TextBox`.
- The user can enter a second number by using a `Slider`.
- Select a `RadioButton` to set an arithmetic operation. Examples are add and subtract.
- Select a `Button` to run the arithmetic logic and display the output.

Optionally, the user can add a time stamp to the output with a `DatePicker`.

Now you know the controls we can use and what they're used for. Let's build the app.

Open **MainWindow.xaml** and create a `StackPanel` with centered **HorizontalAlignment** and **VerticalAlignment**:

```xml
<Window x:Class="UserInput.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        mc:Ignorable="d"
        Title="MainWindow"
        Height="450"
        Width="800">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

        </StackPanel>
    </Grid>
</Window>
```

The first child of the `StackPanel` is our first input control, the `TextBox`. Set the **FontFamily**, **TextAlignment**, **HorizontalAlignment**, **Watermark**, and **Width**:

```xml
<Window x:Class="UserInput.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        mc:Ignorable="d"
        Title="MainWindow"
        Height="450"
        Width="800">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     Text="0"
                     Width="200"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center" />

        </StackPanel>
    </Grid>
</Window>
```

Next, we do something we haven't done yet in this module. We subscribe to an **event** and use an **event handler**.

We use a Visual Studio feature to automatically add the missing **FirstNumberBox_OnTextChanged** event handler to the code-behind file and fix the error.

Put your cursor in the middle of the **FirstNumberBox_OnTextChanged** text. Go to the **Properties** window, and select the lightning icon. You see a list of event handlers. Scroll to **TextChanged**, and then double-click the text in the text box.

:::image type="content" source="../media/3-properties-event-handler.png" alt-text="Screenshot that shows the Properties window with a red box around the TextChanged text box.":::

At this point, Visual Studio opens **MainWindow.xaml.cs** and automatically inserts the missing code. **MainWindow.xaml.cs** is also called the **code-behind file**.

Now the `MainWindow` class looks like this code:

```csharp
using System;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {

        }
    }
}
```

Go back to **MainWindow.xaml**.

Any code you put inside the event handler runs every time the user changes the text in the `TextBox`. We use it to get the user-entered text and convert it to a number that we can use for a math operation.

Before we write any event handler code, we want a variable for the current number value. We might use an `integer`. But we want to calculate results with decimal precision. So a `double` is more suitable.

Add a **FirstNumber** property to the `MainWindow` class:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {

        }
    }
}
```

> [!NOTE]
> The `?` after `double` declares that it's **nullable**. Null isn't the same as 0. It means that there's no value at all. Null is important because later, we check to see if the user entered a value in the first `TextBox`. We want to do the calculation if the user entered a 0 **but not if the user left it empty**.

Next, we finish the logic we want to run when the `TextBox`'s **TextChanged** event occurs. Update the code to contain the following snippet. The code comments explain what each step does:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox?.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }
    }
}
```

> [!IMPORTANT]
> Notice the new `using` statements at the top of the file. They do the same thing that **xmlns** does for XAML. With these statements, the file you're working in can access to code in the namespace. In the preceding code snippet, by using the `System.Linq` namespace, we can use the `LastOrDefault()` method.

Before we move forward, let's add a `double SecondNumber` property to hold the value of a second number. We use it for a later math operation:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox?.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }
    }
}
```


Next, we want to give the user the ability to choose between different math operations. We use the `RadioButton` to make the selection. But before we do that, we create the math operations and a way to know which one is selected.

First, let's add a **SelectedMathFunction** property to the `MainWindow` class:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox?.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }
    }
}
```

`Func<double, double, double>` might look complicated if you're not used to C#. It means *I'm a function that takes two numbers of type `double` and gives back one number of type `double`*. This function is perfect for our math operations.

To help visualize, let's talk about the `Add` operation. To add two numbers together, define the method:

```csharp
// This method accepts two number parameters "a" and "b", and returns one number "result"
private double Add(double a, double b)
{
    double result = a + b;
    return result;
}
```

This image shows how the **SecondNumber** method's parameters line up with the **SelectedMathFunction** definition.

![Explaining SelectedMathFunction.](../media/uwp-user-input-func.png)

We can create four methods to use for that `Func`: **Add**, **Subtract**, **Multiply**, and **Divide**. Remember that the method must accept two `double` parameters and return one `double` value.

Now let's define all four methods in the `MainWindow` class:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox?.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }
    }
}
```

With the math operations defined, we can add UI elements that the user can select. A `RadioButton` works like a `CheckBox`. But you can group `RadioButton`s together. So only one item can be selected at a time by using the **GroupName** property.

Let's add a `StackPanel` with four `RadioButton` elements. All have the **GroupName** of **MathOperator**:

```xml
<Window x:Class="UserInput.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        mc:Ignorable="d"
        Title="MainWindow"
        Height="450"
        Width="800">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     Text="0"
                     Width="200"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     TextChanged="FirstNumberBox_OnTextChanged" />

            <StackPanel Margin="10"
                        HorizontalAlignment="Center">
                <RadioButton Content="Add"
                             IsChecked="True"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Subtract"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Multiply"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Divide"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
            </StackPanel>
        </StackPanel>
    </Grid>
</Window>
```

We set `GroupName="MathOperator"` on each of the `RadioButton`s. Only one of the `RadioButton`s in that group name can be selected at a time.

Next, resolve the **RadioButton_OnChecked** event handler. As you did for the `TextBox`, add the code to the `MainWindow` class:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox?.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }

        // We can share one event handler for all the RadioButtons' Checked event, this prevents a lot of duplicate code.
        private void RadioButton_OnChecked(object sender, RoutedEventArgs e)
        {
            // We can use a single line of code to get the RadioButton reference.
            var radioButton = sender as RadioButton;

            // Get the value of the RadioButton's Content (this contains the name of the math operation we want).
            string radioButtonContent = radioButton?.Content?.ToString();

            // Set the appropriate arithmetic operation to use by checking radioButtonContent's value.
            switch (radioButtonContent)
            {
                case "Add":
                    SelectedMathFunction = Add;
                    break;
                case "Subtract":
                    SelectedMathFunction = Subtract;
                    break;
                case "Multiply":
                    SelectedMathFunction = Multiply;
                    break;
                case "Divide":
                    SelectedMathFunction = Divide;
                    break;
                default:
                    SelectedMathFunction = null;
                    break;
            }
        }
    }
}
```

We use the **Content** property of the `RadioButton` to know which one was selected. Then set the **SelectedMathFunction** value accordingly.

> [!NOTE]
> In most cases, you use a separate event handler for an event, like **FirstNumberBox_OnTextChanged**. But in this case, we reuse the same event handler.

To get the second number's value, we use another `TextBox` like we did for the first number. But this time, we disable the `TextBox` and use a `Slider` control to set the **Text** programmatically.

Add the **SecondNumberTextBox** and **SecondNumberSlider** just underneath the `RadioButton`'s `StackPanel`:

```xml
<Window x:Class="UserInput.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        mc:Ignorable="d"
        Title="MainWindow"
        Height="450"
        Width="800">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     Text="0"
                     Width="200"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     TextChanged="FirstNumberBox_OnTextChanged" />

            <StackPanel Margin="10"
                        HorizontalAlignment="Center">
                <RadioButton Content="Add"
                             IsChecked="True"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Subtract"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Multiply"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Divide"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
            </StackPanel>


            <TextBlock Text="UseSlider to set 2nd number"
                       HorizontalAlignment="Center"/>

            <TextBox x:Name="SecondNumberBox"
                     Text="0"
                     Width="200"
                     IsReadOnly="True"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     TextChanged="SecondNumberBox_OnTextChanged" />

            <Slider x:Name="SecondNumberSlider"
                    Minimum="-10"
                    Maximum="10"
                    TickFrequency="0.01"
                    Width="200"
                    Margin="0,5,0,10"
                    ValueChanged="SecondNumberSlider_OnValueChanged" />
        </StackPanel>
    </Grid>
</Window>

```

Now add the **SecondNumberBox_OnTextChanged** and **SecondNumberSlider_OnValueChanged** event handlers to the `MainWindow` class:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox?.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }

        // We can share one event handler for all the RadioButtons' Checked event, this prevents a lot of duplicate code.
        private void RadioButton_OnChecked(object sender, RoutedEventArgs e)
        {
            // We can use a single line of code to get the RadioButton reference.
            var radioButton = sender as RadioButton;

            // Get the value of the RadioButton's Content (this contains the name of the math operation we want).
            string radioButtonContent = radioButton?.Content?.ToString();

            // Set the appropriate arithmetic operation to use by checking radioButtonContent's value.
            switch (radioButtonContent)
            {
                case "Add":
                    SelectedMathFunction = Add;
                    break;
                case "Subtract":
                    SelectedMathFunction = Subtract;
                    break;
                case "Multiply":
                    SelectedMathFunction = Multiply;
                    break;
                case "Divide":
                    SelectedMathFunction = Divide;
                    break;
                default:
                    SelectedMathFunction = null;
                    break;
            }
        }

        private void SecondNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // We can reuse the same logic we did for the FirstNumberBox.
            if (string.IsNullOrEmpty(SecondNumberBox?.Text))
            {
                SecondNumber = null;
                return;
            }

            if (double.TryParse(SecondNumberBox?.Text, out double parsedNumber))
            {
                SecondNumber = parsedNumber;
            }
            else
            {
                SecondNumberBox.Text = SecondNumberBox.Text.TrimEnd(SecondNumberBox.Text.LastOrDefault());
            }
        }

        private void SecondNumberSlider_OnValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            // You would typically use e.NewValue to get the Slider's value as it changes.
            // However, the SecondTextBox.TextChanged event is already getting the value, we can just set the SecondNumberBox.Text instead.
            SecondNumberBox.Text = e.NewValue.ToString("N");
        }
    }
}
```

The `Slider` control's **ValueChanged** event passes the user's selection inside the `RoutedPropertyChangedEventArgs<double>` parameter. Then we use the numeric **e.NewValue** from the `Slider` to update the `TextBox`'s **Text**. This action causes the **SecondNumberBox_OnTextChanged** event handler to be invoked. It then updates the **SecondNumber** property.

You usually set `SecondNumber` directly with **e.NewValue**. By doing it this way, you can prevent a user from interacting with parts of your UI. But it still provides visual feedback.

Finally, let's add the ability to append a date stamp to the calculation output. When you use the `DatePicker` control, you can accept date values from the user. You don't have to parse text from a `TextBox` into a correct `DateTime` object.

Add the following **CalculationDatePicker** `DatePicker` and **IncludeDateCheckBox** `CheckBox` to the XAML. When you use the `CheckBox`, the user can select whether or not the output gets a date stamp:

```xml
<Window x:Class="UserInput.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        mc:Ignorable="d"
        Title="MainWindow"
        Height="450"
        Width="800">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     Text="0"
                     Width="200"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     TextChanged="FirstNumberBox_OnTextChanged" />

            <StackPanel Margin="10"
                        HorizontalAlignment="Center">
                <RadioButton Content="Add"
                             IsChecked="True"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Subtract"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Multiply"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Divide"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
            </StackPanel>


            <TextBlock Text="UseSlider to set 2nd number"
                       HorizontalAlignment="Center"/>

            <TextBox x:Name="SecondNumberBox"
                     Text="0"
                     Width="200"
                     IsReadOnly="True"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     TextChanged="SecondNumberBox_OnTextChanged" />

            <Slider x:Name="SecondNumberSlider"
                    Minimum="-10"
                    Maximum="10"
                    TickFrequency="0.01"
                    Width="200"
                    Margin="0,5,0,10"
                    ValueChanged="SecondNumberSlider_OnValueChanged" />

            <CheckBox x:Name="IncludeDateCheckBox"
                      Content="Include Date and Time in results"
                      Checked="IncludeDateCheckBox_OnChecked"
                      Unchecked="IncludeDateCheckBox_OnUnchecked"
                      HorizontalAlignment="Center" />

            <DatePicker x:Name="CalculationDatePicker"
                        Visibility="Collapsed"
                        HorizontalAlignment="Center"
                        Margin="0,10,0,10" />
        </StackPanel>
    </Grid>
</Window>

```

Next, add the event handlers **IncludeDateCheckBox_OnChecked** and **IncludeDateCheckBox_OnUnchecked** to your `MainPage` class:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox?.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }

        // We can share one event handler for all the RadioButtons' Checked event, this prevents a lot of duplicate code.
        private void RadioButton_OnChecked(object sender, RoutedEventArgs e)
        {
            // We can use a single line of code to get the RadioButton reference.
            var radioButton = sender as RadioButton;

            // Get the value of the RadioButton's Content (this contains the name of the math operation we want).
            string radioButtonContent = radioButton?.Content?.ToString();

            // Set the appropriate arithmetic operation to use by checking radioButtonContent's value.
            switch (radioButtonContent)
            {
                case "Add":
                    SelectedMathFunction = Add;
                    break;
                case "Subtract":
                    SelectedMathFunction = Subtract;
                    break;
                case "Multiply":
                    SelectedMathFunction = Multiply;
                    break;
                case "Divide":
                    SelectedMathFunction = Divide;
                    break;
                default:
                    SelectedMathFunction = null;
                    break;
            }
        }

        private void SecondNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // We can reuse the same logic we did for the FirstNumberBox.
            if (string.IsNullOrEmpty(SecondNumberBox?.Text))
            {
                SecondNumber = null;
                return;
            }

            if (double.TryParse(SecondNumberBox?.Text, out double parsedNumber))
            {
                SecondNumber = parsedNumber;
            }
            else
            {
                SecondNumberBox.Text = SecondNumberBox.Text.TrimEnd(SecondNumberBox.Text.LastOrDefault());
            }
        }

        private void SecondNumberSlider_OnValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            // You would typically use e.NewValue to get the Slider's value as it changes.
            // However, the SecondTextBox.TextChanged event is already getting the value, we can just set the SecondNumberBox.Text instead.
            SecondNumberBox.Text = e.NewValue.ToString("N");
        }

        private void IncludeDateCheckBox_OnChecked(object sender, RoutedEventArgs e)
        {
            // When the CheckBox is checked, show the DatePickers.
            CalculationDatePicker.Visibility = Visibility.Visible;
            CalculationDatePicker.SelectedDate = DateTime.Now;
        }

        private void IncludeDateCheckBox_OnUnchecked(object sender, RoutedEventArgs e)
        {
            // When the CheckBox is unchecked, hide the DatePickers.
            CalculationDatePicker.Visibility = Visibility.Collapsed;
        }
    }
}
```

When the `CheckBox` is selected, it shows the `DatePicker`. When it's not selected, the `DatePicker` is hidden. We also set the `DatePicker` **SelectedDate** to the current date and time.

Now let's perform the calculations.

You usually perform the calculations whenever the input changes on any of the controls. In this case, we keep things simple and use the following controls:

- A `Button` with a **Click** event handler.
- A `TextBlock` to show the results.

Add the final `Button` and **ResultsTextBlock** `TextBlock` controls underneath the `DatePicker`:

```xml
<Window x:Class="UserInput.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        mc:Ignorable="d"
        Title="MainWindow"
        Height="450"
        Width="800">

    <Grid>
        <StackPanel x:Name="CalculationGrid"
                    VerticalAlignment="Center"
                    HorizontalAlignment="Center">

            <TextBox x:Name="FirstNumberBox"
                     Text="0"
                     Width="200"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     TextChanged="FirstNumberBox_OnTextChanged" />

            <StackPanel Margin="10"
                        HorizontalAlignment="Center">
                <RadioButton Content="Add"
                             IsChecked="True"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Subtract"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Multiply"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
                <RadioButton Content="Divide"
                             GroupName="MathOperator"
                             Checked="RadioButton_OnChecked" />
            </StackPanel>


            <TextBlock Text="UseSlider to set 2nd number"
                       HorizontalAlignment="Center"/>

            <TextBox x:Name="SecondNumberBox"
                     Text="0"
                     Width="200"
                     IsReadOnly="True"
                     FontFamily="Consolas"
                     TextAlignment="Center"
                     HorizontalAlignment="Center"
                     TextChanged="SecondNumberBox_OnTextChanged" />

            <Slider x:Name="SecondNumberSlider"
                    Minimum="-10"
                    Maximum="10"
                    TickFrequency="0.01"
                    Width="200"
                    Margin="0,5,0,10"
                    ValueChanged="SecondNumberSlider_OnValueChanged" />

            <CheckBox x:Name="IncludeDateCheckBox"
                      Content="Include Date and Time in results"
                      Checked="IncludeDateCheckBox_OnChecked"
                      Unchecked="IncludeDateCheckBox_OnUnchecked"
                      HorizontalAlignment="Center" />

            <DatePicker x:Name="CalculationDatePicker"
                        Visibility="Collapsed"
                        HorizontalAlignment="Center"
                        Margin="0,10,0,10" />

            <Button Content="Calculate Results"
                    HorizontalAlignment="Center"
                    Click="EqualsButton_OnClick"
                    Margin="0,10" />

            <TextBlock x:Name="ResultsTextBlock"
                       Text="---"
                       FontSize="22"
                       FontWeight="Bold"
                       FontFamily="Consolas"
                       VerticalAlignment="Center"
                       HorizontalAlignment="Center" />
        </StackPanel>
    </Grid>
</Window>

```

Next, add the **EqualsButton_OnClick** event handler to the `MainWindow` class:

```csharp
using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace UserInput
{
    public partial class MainWindow : Window
    {
        // Gets or sets the value of the first number that the arithmetic will be performed on.
        private double? FirstNumber { get; set; }

        // Gets or sets the value of the second number that the arithmetic will be performed on.
        private double? SecondNumber { get; set; }

        // Gets or sets the selected arithmetic operation.
        private Func<double, double, double> SelectedMathFunction { get; set; }

        public MainWindow()
        {
            InitializeComponent();
        }

        private double Add(double a, double b)
        {
            double result = a + b;
            return result;
        }

        private double Subtract(double a, double b)
        {
            double result = a - b;
            return result;
        }

        private double Multiply(double a, double b)
        {
            double result = a * b;
            return result;
        }

        private double Divide(double a, double b)
        {
            double result = a / b;
            return result;
        }

        private void FirstNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // Check if the text in FirstNumberBox.Text is empty.
            if (string.IsNullOrEmpty(FirstNumberBox?.Text))
            {
                FirstNumber = null;
                return;
            }

            // If text was entered, check to see if it can be parsed into an number.
            if (double.TryParse(FirstNumberBox?.Text, out double parsedNumber))
            {
                // If the text is an integer, then set the value of the FirstNumber property.
                FirstNumber = parsedNumber;
            }
            else
            {
                // If it not a number, remove the last entered character with Trim() method.
                FirstNumberBox.Text = FirstNumberBox.Text.TrimEnd(FirstNumberBox.Text.LastOrDefault());
            }
        }

        // We can share one event handler for all the RadioButtons' Checked event, this prevents a lot of duplicate code.
        private void RadioButton_OnChecked(object sender, RoutedEventArgs e)
        {
            // We can use a single line of code to get the RadioButton reference.
            var radioButton = sender as RadioButton;

            // Get the value of the RadioButton's Content (this contains the name of the math operation we want).
            string radioButtonContent = radioButton?.Content?.ToString();

            // Set the appropriate arithmetic operation to use by checking radioButtonContent's value.
            switch (radioButtonContent)
            {
                case "Add":
                    SelectedMathFunction = Add;
                    break;
                case "Subtract":
                    SelectedMathFunction = Subtract;
                    break;
                case "Multiply":
                    SelectedMathFunction = Multiply;
                    break;
                case "Divide":
                    SelectedMathFunction = Divide;
                    break;
                default:
                    SelectedMathFunction = null;
                    break;
            }
        }

        private void SecondNumberBox_OnTextChanged(object sender, TextChangedEventArgs e)
        {
            // We can reuse the same logic we did for the FirstNumberBox.
            if (string.IsNullOrEmpty(SecondNumberBox?.Text))
            {
                SecondNumber = null;
                return;
            }

            if (double.TryParse(SecondNumberBox?.Text, out double parsedNumber))
            {
                SecondNumber = parsedNumber;
            }
            else
            {
                SecondNumberBox.Text = SecondNumberBox.Text.TrimEnd(SecondNumberBox.Text.LastOrDefault());
            }
        }

        private void SecondNumberSlider_OnValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            // You would typically use e.NewValue to get the Slider's value as it changes.
            // However, the SecondTextBox.TextChanged event is already getting the value, we can just set the SecondNumberBox.Text instead.
            SecondNumberBox.Text = e.NewValue.ToString("N");
        }

        private void IncludeDateCheckBox_OnChecked(object sender, RoutedEventArgs e)
        {
            // When the CheckBox is checked, show the DatePickers.
            CalculationDatePicker.Visibility = Visibility.Visible;
            CalculationDatePicker.SelectedDate = DateTime.Now;
        }

        private void IncludeDateCheckBox_OnUnchecked(object sender, RoutedEventArgs e)
        {
            // When the CheckBox is unchecked, hide the DatePickers.
            CalculationDatePicker.Visibility = Visibility.Collapsed;
        }

        private void EqualsButton_OnClick(object sender, RoutedEventArgs e)
        {
            // Before doing any calculations, confirm the user entered both numbers.
            if (FirstNumber == null || SecondNumber == null)
            {
                MessageBox.Show("You need to set both numbers to calculate a result.");
                return;
            }

            // Now is a good time to do some validation on the numbers and prevent any serious problems.
            // For example, here we make sure the user isn't trying to divide from zero, this can crash your app!
            if (SecondNumber == 0 && SelectedMathFunction == Divide)
            {
                MessageBox.Show("You cannot divide from zero, please pick a different 2nd number.");
                return;
            }

            // Next, it's time to do the actual math. We only need to pass the two numbers into the SelectedMathFunction.
            double result = SelectedMathFunction((double)FirstNumber, (double)SecondNumber);

            // Finally, show the result to the user!
            if (IncludeDateCheckBox.IsChecked == true)
            {
                // If the CheckBox was checked, show the number with the "N2" string format (a number to 2 decimal points),
				// but also include the Date in the output with the "d" string format (a short date format).
                ResultsTextBlock.Text = $"Result: {result:N2}, Date: {CalculationDatePicker.SelectedDate:d}";
            }
            else
            {
                // If the CheckBox was not checked, show the number with the "N2" string format (a number to 2 decimal points).
                ResultsTextBlock.Text = $"Result: {result:N2}";
            }
        }
    }
}
```

The code comments explain the details. But let's briefly walk through what's going on at a high level:

1. First, we make sure the user's input is valid and doesn't crash the app: `if (FirstNumber == null || SecondNumber == null)` and `if (SecondNumber == 0 && SelectedMathFunction == Divide)`.

2. We invoke the **SelectedMathFunction** function to perform the calculation: `double result = SelectedMathFunction((double)FirstNumber, (double)SecondNumber)`.

3. Finally, we check if the user wants a date stamp and then append the date to the results: `(IncludeDateCheckBox.IsChecked == true)`.

The coding is done. Now it's time to test your application.

#### Runtime

Let's deploy the application and try it out. Select F5 to build, deploy, and start debugging. You're presented with the following UI:

:::image type="content" source="../media/3-complete-app-no-entry-wpf.png" alt-text="Screenshot that shows the finished WPF app UI with nothing selected and all of the text boxes empty.":::

To try the app, take the following steps:

1. Enter a number into the first `TextBox` to set **FirstNumber**.
2. Select a `RadioButton` to set **SelectedMathFunction**. Notice that you can only make one selection at a time.
3. Move the `Slider` to set **SecondNumber**. Notice that the `Slider` updates the `TextBox`'s **Text**.
4. Select the `CheckBox` to make the `DatePicker` appear.
5. Select the **Calculate Results** `Button`. Now you see the results shown underneath.

The finished result looks like the following image:

:::image type="content" source="../media/3-complete-app-wpf.png" alt-text="Screenshot that shows the finished WFP app with numbered red arrows pointing to selections in the app.":::

::: zone-end

### Summary

You learned how to do these things:

- Lay out a UI with input controls.
- Use events and event handlers.
- Work on values inputted by a user.

These steps form the basic building blocks of the UI of any complex Windows app you might build.

You can walk through this process in the other application framework. UWP and WPF share many features, which include using the same markup and coding languages. So you can reuse most of what you learned and see which one you prefer to use.
