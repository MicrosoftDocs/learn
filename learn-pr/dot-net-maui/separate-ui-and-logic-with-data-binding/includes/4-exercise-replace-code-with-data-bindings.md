In this exercise, you'll convert an app that uses events and code-behind to one that uses mostly data binding. The sample app is a weather forecasting app that displays the weather for the day.

## Download and run the sample

To start this exercise module, download the [Weather Sample](https://github.com/MicrosoftDocs/mslearn-dotnetmaui-databinding1/raw/main/part4-exercise-start.zip) project. This project displays the weather from a fake weather reporting service. The code doesn't contain any data binding.

01. Download and extract the [Weather Sample](https://github.com/MicrosoftDocs/mslearn-dotnetmaui-databinding1/raw/main/part4-exercise-start.zip) project to a temporary folder.
01. Navigate to the _before_ folder and open the _WeatherClient.sln_ solution.
01. Build and run the project to make sure it works. On the screen displayed, you'll see some empty weather details. Press the **Refresh** button and you'll see the weather details update.

    :::image type="content" source="../media/4-exercise-replace-code-with-data-bindings/app2.png" alt-text="Screenshot of a weather app showing the weather for the day.":::

01. For reference, here's a summary of the classes and files you'll work with in this exercise.

    | File                         | Description                                                                                                                                          |
    |------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
    | _MainPage.xaml_              | Defines the UI and logic for the initial page. The **XAML** file defines the UI by using markup.                                                     |
    | _MainPage.xaml.cs_           | Defines the UI and logic for the initial page. The associated code-behind file that contains the code related to the UI defined by _MainPage.xaml_. |
    | _Services\WeatherService.cs_ | This class simulates a weather reporting service. It contains a single method named `GetWeather` that returns a `WeatherData` type.                 |
    | _Models\WeatherData.cs_      | Contains the weather data. This is a simple record type that provides the day's temperature, precipitation, humidity, wind, and condition.           |
    | _Models\WeatherType.cs_      | An enumeration of the weather condition, sunny or cloudy.                                                                                            |

## Set the binding context

You'll need to edit the code-behind for the **Refresh** button's click event handler. The code currently gets the weather data and updates the controls directly. Instead, get the weather data and set it as the binding context for the page.

01. Open the _MainPage.xaml.cs_ code file.
01. Review the `btnRefresh_Clicked` method. This method performs the following steps:

    - Disables the button and enables the "busy" spinner.
    - Gets the weather forecast from the weather service.
    - Updates the controls on the page with the weather information.
    - Enables the button and disables the "busy" spinner.

01. Remove the code that updates the controls with data. Your event code should look like the following snippet:

    ```csharp
    private async void btnRefresh_Clicked(object sender, EventArgs e)
    {
        btnRefresh.IsEnabled = false;
        actIsBusy.IsRunning = true;
    
        Models.WeatherData weatherData = await Services.WeatherServer.GetWeather(txtPostalCode.Text);
    
        btnRefresh.IsEnabled = true;
        actIsBusy.IsRunning = false;
    }
    ```

01. Instead of assigning the result of the service's `GetWeather` method to a variable, assign it to the `BindingContext` of the page:

    ```csharp
    private async void btnRefresh_Clicked(object sender, EventArgs e)
    {
        btnRefresh.IsEnabled = false;
        actIsBusy.IsRunning = true;
    
        BindingContext = await Services.WeatherServer.GetWeather(txtPostalCode.Text);
    
        btnRefresh.IsEnabled = true;
        actIsBusy.IsRunning = false;
    }
    ```

01. Run the project. Notice that when you press the **Refresh** button and the weather service returns the data, none of the controls are updated with the weather forecast. You'll fix this bug in the next section.

## Create bindings in XAML

Now that the code-behind sets the binding context for the page, you can add the bindings to the controls to use the data on the context.

01. Open the _MainPage.xaml_ file.
01. Find the inner `Grid` that contains all the `Label` controls.

    ```xaml
    <Grid Grid.Row="2" RowDefinitions="Auto, Auto, Auto, Auto, Auto" ColumnDefinitions="Auto, Auto" Margin="0,5,0,0">
        <Label Grid.Row="0" Grid.Column="0" Text="Condition" VerticalOptions="Center" />
        <Image x:Name="imgCondition" Grid.Row="0" Grid.Column="1" HeightRequest="25" WidthRequest="25" Source="question.png" HorizontalOptions="Start" />
        <Label Grid.Row="1" Grid.Column="0" Text="Temperature" Margin="0,0,20,0" />
        <Label x:Name="lblTemperature" Grid.Row="1" Grid.Column="1" Text="0" />
        <Label Grid.Row="2" Grid.Column="0" Text="Humidity" Margin="0,0,20,0" />
        <Label x:Name="lblHumidity" Grid.Row="2" Grid.Column="1" Text="0" />
        <Label Grid.Row="3" Grid.Column="0" Text="Precipitation" Margin="0,0,20,0" />
        <Label x:Name="lblPrecipitation" Grid.Row="3" Grid.Column="1" Text="0" />
        <Label Grid.Row="4" Grid.Column="0" Text="Wind" Margin="0,0,20,0" />
        <Label x:Name="lblWind" Grid.Row="4" Grid.Column="1" Text="0" />
    </Grid>
    ```

01. Add bindings to each of the named `Label` controls. There are four.

    The `Label.Text` property should have its value changed to the `{Binding PROPERTY_NAME}` syntax where `PROPERTY_NAME` is a property from the `Models.WeatherData` type defined in _Models\WeatherData.cs_. Remember, this type is the data type returned by the weather service.

    For example, the `Label` named `lblWind` (the last label in the grid) should have the `Text` property look like the following code:

    ```xaml
    <Label x:Name="lblWind" Grid.Row="4" Grid.Column="1" Text="{Binding Wind}" />
    ```

01. Within the `<Grid>` of controls that lists all of the weather details, remove all of the `x:Name="..."` attributes.

    The names aren't required now that the controls aren't referenced in the code-behind.

01. Verify that your XAML bindings match the following snippet:

    ```xaml
    <Grid Grid.Row="2" RowDefinitions="Auto, Auto, Auto, Auto, Auto" ColumnDefinitions="Auto, Auto" Margin="0,5,0,0">
        <Label Grid.Row="0" Grid.Column="0" Text="Condition" VerticalOptions="Center" />
        <Image Grid.Row="0" Grid.Column="1" HeightRequest="25" WidthRequest="25" Source="question.png" HorizontalOptions="Start" />
        <Label Grid.Row="1" Grid.Column="0" Text="Temperature" Margin="0,0,20,0" />
        <Label Grid.Row="1" Grid.Column="1" Text="{Binding Temperature}" />
        <Label Grid.Row="2" Grid.Column="0" Text="Humidity" Margin="0,0,20,0" />
        <Label Grid.Row="2" Grid.Column="1" Text="{Binding Humidity}" />
        <Label Grid.Row="3" Grid.Column="0" Text="Precipitation" Margin="0,0,20,0" />
        <Label Grid.Row="3" Grid.Column="1" Text="{Binding Precipitation}" />
        <Label Grid.Row="4" Grid.Column="0" Text="Wind" Margin="0,0,20,0" />
        <Label Grid.Row="4" Grid.Column="1" Text="{Binding Wind}" />
    </Grid>
    ```

01. Run the app and press the **Refresh** button. The app works almost like the original.

Notice that the icon representing the **Condition** doesn't update from the question mark to a sun or cloud icon. Why doesn't the icon change? Because the icon is an image resource that was chosen in code based on the `WeatherData.Condition` enumeration value. The enumeration value can't be changed to an image resource without some extra effort This is fixed in the next exercise after you learn more about bindings.
