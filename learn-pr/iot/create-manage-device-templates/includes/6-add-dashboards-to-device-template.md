Views let you define views and forms that let an operator monitor and interact with a device. Views use visualizations such as charts to show telemetry and property values. You can create default views, custom views, and forms.

:::image type="content" source="../media/device-template-views.png" alt-text="Screenshot that shows the options for generating views in a device template.":::

## Default views

Generating default views is a quick way to visualize your important device information. The three default views are:

- Commands: A view with device commands that lets your operator dispatch them to your device.
- Overview: A view with device telemetry, displaying charts and metrics.
- About: A view with device information, displaying device properties.

After you've selected **Generate default views**, they're automatically added under the **Views** section of your device template.

## Custom views

Add custom views to a device template to enable operators to visualize a device by using charts and metrics. You can add your own custom views to a device template.

To add a view to a device template:

1. Go to your device template, and select **Views**.
2. Select **Visualizing the device**.
3. Enter a name for your view in **View name**.
4. Select **Start with a visual** under add tiles and choose the type of visual for your tile. Then either select **Add tile** or drag and drop the visual onto the canvas. To configure the tile, select the gear icon.

To test your view, select **Configure preview device**. This feature lets you see the view as an operator sees it after it's published. Use this feature to validate that your views show the correct data. Choose from the following options:

- No preview device.
- The real test device you've configured for your device template.
- An existing device in your application, by using the device ID.

## Forms

Add forms to a device template to enable operators to manage a device by viewing and setting properties. Operators can only edit cloud properties and writable device properties. You can have multiple forms for a device template.

1. Select the **Views** node, and then select the **Editing device and cloud data** tile to add a new view.
1. Enter a name for your form in **Form name**.
1. Select from the available properties and cloud properties. Then select **Add section**.
1. Select **Save** to save your new form.
