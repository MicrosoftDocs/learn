As the number of rows in a `ListView` increases, it gets harder for users to find a particular item. Also, a user might be interested only in a certain subset of items. For example, in a calendar app, a user might want to see only appointments on Tuesday. Or in the smart home app, a user might want to look at smoke detectors. In these situations, grouping our items can be helpful. The user can scroll quickly to the correct group and see all the relevant information.

In this unit, we'll look at how to group items in a `ListView`. We'll also add a group header to provide a title.

## Group data in a ListView

There are two things we need to do to group our data. The first step is to set `IsGroupingEnabled` to `True` on our `ListView`:

```xaml
    <ListView IsGroupingEnabled="True">
```

The second thing we need to do is change how we use our `ListView.ItemsSource`. When we were showing rows without groups, our `ItemsSource` was a collection of items, and each item was represented by a row. For example, a collection of `Appointments` would result in one row for each appointment.

### Restructure the ItemsSource

For grouped data, however, we'll need our `ItemsSource` to be a collection of *groups*. Each group, in turn, is a collection of things that need rows. For an appointment list, that could mean `ItemsSource` is set to a collection of `Day` objects, and each `Day` has a collection of `Appointments` under it.

- ItemsSource
  - Monday
    - 8am - listen to podcast
    - 9am - meet with Sue
    - ...
  - Tuesday
    - 8am - coffee at the corner brewery
    - 9am - heads-down work
  - ...

And each of those groups is going to need at least a name. So we can't just use nested `List<List<T>>` as our collection of collections. We need the group name to show on our `ListView` section header.

If we're starting with a flat collection of items that we want to convert to a nested collection with group names, the `ToLookup` method is often the ideal solution:

```csharp
var groupedAppointments = appointments.All.
    .ToLookup(appt => appt.Day.ToString() );
```

Here, `ToLookup` is taking a collection of appointments and returning a collection of `IGrouping` objects. Each `IGrouping` contains:

- A `Key`. We'll use this key as the name for our group. It's derived from unique values of `appt.Day.ToString()`.
- A collection of appointments that all have the same `Day` as the group `Key`.

To display our appointments by day, we just need to set this as our `ItemSource` and remember to set `IsGroupingEnabled`:

```csharp
appointmentListView.ItemsSource = groupedAppointments;
appointmentListView.IsGroupingEnabled = true;
```

### Add group headers

Though each `IGrouping` has a `Key` that we can use as our section header, we still need to tell the `ListView` to use it. We can do that by using the `GroupDisplayBinding` property:

```xaml
<ListView GroupDisplayBinding="{Binding Key}" ...>
```

> [!TIP]
> `GroupDisplayBinding` just sets the text of the header. If we need full layout control, we can use `GroupHeaderTemplate`. There are also properties available for setting the header or footer of the whole table. See the `ListView` documentation for details.
