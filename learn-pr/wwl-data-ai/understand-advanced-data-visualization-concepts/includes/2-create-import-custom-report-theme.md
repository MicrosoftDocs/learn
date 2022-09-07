When you create a custom theme, you ensure a cohesive look and feel for reports across your organization. Deploying an enterprise-wide custom theme provide consistency for:

* Organizational branding
* Accessibility requirements

## Access themes

Navigate to the **View** tab on the ribbon, then select the drop-down arrow on Themes to:

* Choose a built-in theme
* Browse for themes
* View the Theme gallery
* Customize current theme
* Save current theme

## Create your custom theme

Currently there are almost 20 built-in report themes, including high contrast and color-blind safe options. However, if you have a certain color palette and font family in mind, you can go to **Customize current theme**. From here, you can make changes in the following categories:

* Theme name and color settings include theme colors, sentiment colors, divergent colors, and structural colors (Advanced).
* Text settings include font family, size, and color, which sets the primary text class defaults for labels, titles, cards and KPIs, and tab headers.
* Visual settings include background, border, header, and tooltips.
* Page element settings include wallpaper and background.
* Filter pane settings include background color, transparency, font and icon color, size, filter cards.

After you make your changes, select Apply to save changes to your theme. Now you can use your theme for your current report and export for future use. Custom themes are an excellent choice for organizations, allowing a cohesive look for reports across entire department or organization.

Using the **Customize current theme** option is a quick and easy way to create a custom theme. If you want to make finer adjustments to themes you can also [create a custom theme through JSON](/power-bi/create-reports/desktop-report-themes#report-theme-json-file-format), which we don’t cover in this module.

## Export and import themes

After you’ve applied changes to your custom theme, you need to go back to the **Themes** drop-down menu and select **Save current theme** to export the theme. A JSON file will be created that can be shared with others and used for any future reports.
Now that your custom theme has been exported, you and others will need to import it to apply to other reports. Importing is as easy as exporting is – navigate to the **Themes** drop-down menu again, select **Browse for themes**, and choose the JSON file you just created (or that was shared with you). You'll get a notification when the theme successfully imports.

## Enterprise considerations

Any changes made to this theme will need to be saved again to either overwrite the existing theme or as a new theme. Themes are local to the file as well, so changes made on someone’s copy on their computer won’t affect your copy. The theme could be saved as a **Power BI Template (.PBIT) file**, and then shared that way as well. When sharing custom themes, consider a business process to validate that the theme and/or template are being used.

> [!TIP]
> Once you’ve published your report, consider [creating themes for your dashboard in the Power BI service](/power-bi/create-reports/service-dashboard-themes).
