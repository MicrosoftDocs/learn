[!include[](../../includes/xamarin-not-maintained.md)]

In the last exercise, you set up your `ListView` control to display your collection by calling `ToString` on each item. In this exercise, you'll customize the display with `ImageCell` to show an image and two labels.

## Define ImageCell for row visualization

You first need to create a `DataTemplate` instance and assign it to the `ItemTemplate` property of the `ListView` control. To set the two labels:

1. Open the **AllFlags.xaml** markup page.

1. Assign the `ListView.ItemTemplate` property to a new `DataTemplate` instance.

   ```xml
   <ListView ...>
      <ListView.ItemTemplate>
          <DataTemplate>

          </DataTemplate>
      </ListView.ItemTemplate>
   </ListView>
   ```

1. In the `DataTemplate` instance, create an `ImageCell` instance.

1. Set `DetailColor` to **"Gray"**.

1. Use a `{Binding}` to display the flag's `Country` property in the `Text` property of `ImageCell`.

1. Use a `{Binding}` to display the flag's `DateAdopted` property in the `Detail` property of `ImageCell`. In the binding, include a `StringFormat` value of **'Adopted on {0:d}'**.

   ```xml
   <ListView ...>
      <ListView.ItemTemplate>
          <DataTemplate>
             <ImageCell DetailColor="Gray"
                        Text="{Binding Country}"
                        Detail="{Binding DateAdopted, StringFormat='Adopted on {0:d}'}"/>
          </DataTemplate>
      </ListView.ItemTemplate>
   </ListView>
   ```

1. Run the application. Each flag should be accompanied by the country/region name and date on which the flag was adopted.

## Add an image to the row

Finally, you need add the flag image to the row. To load the flag images, you need a value converter. The details page already includes a converter that you can use. Move it to the global scope to make it available on your list page as well.

1. Open the **FlagDetailsPage.xaml** markup page.

1. Move `ResourceDictionary` into the **App.xaml** file. You'll need to move the namespace definitions for the converters (`xmlns:cvt`) and data (`xmlns:data`).

1. Open the **AllFlags.xaml** file.

1. Data-bind the `ImageCell.ImageSource` property to the `ImageUrl` property by using the converter.

   ```xml
   <ListView ...>
      <ListView.ItemTemplate>
          <DataTemplate>
             <ImageCell DetailColor="Gray"
                        ImageSource="{Binding ImageUrl, Converter={StaticResource irConverter}}"
                        Text="{Binding Country}"
                        Detail="{Binding DateAdopted, StringFormat='Adopted on {0:d}'}"/>
          </DataTemplate>
      </ListView.ItemTemplate>
   </ListView>
   ```

1. Run the application. You should now see the flag images for each country/region.