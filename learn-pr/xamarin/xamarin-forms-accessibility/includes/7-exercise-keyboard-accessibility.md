To complete the project, we must now implement a way to enter data for the users forename and surname and their managers.

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
    <Entry
        Grid.Row="1"
        Grid.Column="1"
        Placeholder="Enter forename"/>
        
    <Entry Grid.Row="2" 
            Placeholder="Enter surname" />
    <Entry
        Grid.Row="2"
        Grid.Column="1"
        Placeholder="Enter surname" />
</Grid>
```

## Run the application

When you run the application and use the screen reader to navigate the elements on the screen. The default ordering of the screen reader is row-based. This means that the entry of names changes back and forth between the report and the managers names. 

![Default Row-based Tab Order](../media/default-tab-order.png)

The default tab order of controls is the same order in which they are listed in XAML, or programmatically added to a child collection. This is not an accessible order for data entry. Instead we would prefer to go down the column to fill in the forename and then the surname of each person.

## Set the tab order

1. Reorder the `Entry` elements so they in the order in which the screen reader should read them back.


```xaml
<Entry Grid.Row="1" 
        Placeholder="Enter forename"/>
        
<Entry Grid.Row="2" 
        Placeholder="Enter surname"/>

<Entry
    Grid.Row="1"
    Grid.Column="1"
    Placeholder="Enter forename"/>

<Entry
    Grid.Row="2"
    Grid.Column="1"
    Placeholder="Enter surname"/>
```

Now, when you run the application you will see the new column-based tab ordering as navigating through the elements.

![Column-based Tab Order](../media/correct-tab-order.png)

We have now explored multiple ways to enhance the accessibility of the application. Let's recap what we have learned and see even more ways we can make apps accessible.
