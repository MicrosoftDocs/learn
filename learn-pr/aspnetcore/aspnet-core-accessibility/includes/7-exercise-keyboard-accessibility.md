To complete the project, we must now implement a way to enter data for the user's and their manager's forenames and surnames.

## Add data entry elements for names

1. Replace `<!-- Report and Manager Information -->` with the following XAML:

```xaml
<Grid
    Margin="0,20,0,0"
    ColumnDefinitions="*,*"
    RowDefinitions="Auto,Auto,Auto">
    <Label
        AutomationProperties.IsInAccessibleTree="True"
        HorizontalOptions="Center"
        Text="You" />
    <Label
        Grid.Column="1"
        AutomationProperties.IsInAccessibleTree="True"
        HorizontalOptions="Center"
        Text="Manager" />

    <Entry Grid.Row="1" 
            Placeholder="Enter forename"/>
        
    <Entry Grid.Row="2" 
            Placeholder="Enter surname" />

    <Entry
        Grid.Row="1"
        Grid.Column="1"
        Placeholder="Enter forename"/>
    <Entry
        Grid.Row="2"
        Grid.Column="1"
        Placeholder="Enter surname" />
</Grid>
```

## Run the application

When you run the application and use the screen reader to navigate the elements on the screen. The default ordering of the screen reader is row-based. This means that the entry of names changes back and forth between the report and the managers names. 

![Default Row-based Tab Order](../media/default-tab-order.png)

The default tab order of controls is the same order in which they are listed in XAML, or added to a collection. In the `Grid` items are added to the layout based on the row. This is not an accessible order for data entry. Instead we would prefer them to fill in the forename and then the surname before moving to the next person.

## Reorder the elements

Reorder the `Entry` elements so they in the order in which the screen reader should read them back.


```xaml
<Grid
    Margin="0,20,0,0"
    ColumnDefinitions="Auto,*,*"
    RowDefinitions="Auto,Auto">
    <Label
        AutomationProperties.IsInAccessibleTree="True"
        VerticalOptions="Center"
        Text="You" />
    <Label
        Grid.Row="1"
        AutomationProperties.IsInAccessibleTree="True"
        VerticalOptions="Center"
        Text="Manager" />
    <Entry Grid.Row="0" Grid.Column="1"
        Placeholder="Your forename"/>

    <Entry Grid.Row="0"
        Grid.Column="2"
        Placeholder="Your surname" />
    <Entry
        Grid.Row="1"
        Grid.Column="1"
        Placeholder="Manager's forename" />
    <Entry
        Grid.Row="1"
        Grid.Column="2"
        Placeholder="Manager's surname"/>
</Grid>
```

Now, when you run the application you will see the new column-based accessibility ordering as navigating through the elements. We have also improved the screen reader information on the `Entry` by updating the `Placeholder` with more valuable information such as "Manager's surname" and "Manager's forename" that is read back.

![Column-based Tab Order](../media/correct-tab-order.png)


> [!NOTE]
> If you are interested in further manipulating the accessibility ordering, there are APIs that make this possible. However, it is advised to maintain logical and meaningful content ordering before leveraging those APIs.

We have now explored multiple ways to enhance the accessibility of the application. Let's recap what we have learned and discover even more ways in which we can make apps app accessible.
