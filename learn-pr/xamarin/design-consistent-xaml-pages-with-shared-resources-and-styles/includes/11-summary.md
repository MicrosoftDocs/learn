In this module, we saw how to use resources and styles in our Xamarin.Forms applications. The goal was to simplify UI updates for the **TipCalculator** app whenever the corporate brand changed. We used both features to reorganize the code so updates to the UI would be fast and accurate:

- Resources: Created symbolic constants for size and color values.

- Styles: Defined the look of a control by using a group of property values.

Resources and styles let us centralize all the definitions that affected the branding of our UI. These features made it easier to achieve consistency across all UI elements. They also let us make updates quickly and without error. As a bonus, the XAML for our pages became easier to read because we could assign to the `Style` property instead of individual property settings.