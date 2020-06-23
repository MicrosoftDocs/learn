

`xamarin.forms.dualscreen`


MainActivity.OnCreate method:

```csharp
Xamarin.Forms.DualScreen.DualScreenService.Init(this);
```

```xaml
xmlns:dualscreen="clr-namespace:Xamarin.Forms.DualScreen;assembly=Xamarin.Forms.DualScreen"
```


```xaml
    <dualScreen:TwoPaneView>
        <dualScreen:TwoPaneView.Pane1>
            <!--existing ListView-->
        </dualScreen:TwoPaneView.Pane1>
        <dualScreen:TwoPaneView.Pane2>
            <!--ScrollView from FlagDetailsPage-->
        </dualScreen:TwoPaneView.Pane2>
    </dualScreen:TwoPaneView>
```


Remove the item tapped handler, since the list and detail are now on the same ContentPage, databinding takes care of the selected item being displayed.

```xaml
ItemTapped="ListView_ItemTapped"
```

Also remove the implementation:

```csharp
private async void ListView_ItemTapped(object sender, ItemTappedEventArgs e)
{
    await this.Navigation.PushAsync(new FlagDetailsPage());
}
```




```xaml
MinWideModeWidth="550"
```