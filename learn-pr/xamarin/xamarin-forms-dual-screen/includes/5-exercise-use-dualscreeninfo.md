


add
```xaml
<dualScreen:TwoPaneView
    x:Name="twoPaneView"
    MinWideModeWidth="550"
    TallModeConfiguration="SinglePane"
    WideModeConfiguration="SinglePane"
    PanePriority="Pane1">
```

add

```csharp
using Xamarin.Forms.DualScreen;
// ...
public bool DeviceIsSpanned => DualScreenInfo.Current.SpanMode != TwoPaneViewMode.SinglePane;
```

in AllFlagsPage constructor

```csharp
DualScreenInfo.Current.PropertyChanged += Current_PropertyChanged;
```

```csharp
using System.ComponentModel;
// ...
private void Current_PropertyChanged(object sender, PropertyChangedEventArgs e)
{
    UpdateLayouts();
}
```

```csharp
public void UpdateLayouts()
{
    //...
```
