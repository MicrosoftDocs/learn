During the implementation phase, it is crucial to maintain the accessibility standards established during the design phase. Here are some tips for ensuring adequate color contrast during this phase, specifically concerning high contrast (for applications).

## Consistent application

Ensure that the color and contrast guidelines are consistently applied across all UI components and screens. Creating a consistent design system and theme for components can assist both developers and designers. In this example, the colors used are from the current palette with the “swatch" prefix. It's important to use colors for their intended purpose. Here, the stroke color wasn't meant to be used as a background and doesn't contrast well with the text color.

```js
<ReadingOrderPaneTextEdit
        foreground="swatchTextCtlSubtle"
        background="swatchStrokeCtlSubtleKeyboard"/>
```

The color combination will meet contrast requirements by using the designated background color from the palette.

```js
<ReadingOrderPaneTextEdit
        foreground="swatchTextCtlSubtle"
        background="swatchBkgCtlSubtle"/>
```

## High-contrast mode

Implement a high-contrast mode that users can use to increase the contrast between text and UI components. This is particularly important for users with low vision. Use Office palettes when designing for Windows apps. Each color palette has a set of colors (called a swatch set) for each theme it supports, including High Contrast. The swatch set includes named colors and values like Button, Text, Highlights, and Backgrounds, which match Windows's system colors based on the current theme. The palette type defines what these named colors are for a specific palette.

```js
Example: CL 20195996
Colors/PowerPoint.palette

<Palette Name="SlideThumbnailColors" App="PPT" Type="SlideThumbnailBorderColors" Platform="Win32">
    <Colorful SwatchSet="SlideThumbnailColorsColorful"/>
    <VeryDark SwatchSet="SlideThumbnailColorsDarkGray"/>
    <Black SwatchSet="SlideThumbnailColorsBlack"/>
    <Fresh SwatchSet="SlideThumbnailColorsWhite"/>
    <HighContrast SwatchSet="SlideThumbnailColorsHighContrast"/>
</Palette>

<SwatchSet Name="SlideThumbnailColorsHighContrast" Type="SlideThumbnailBorderColors" App="PPT" Platform="Win32">
    <ThumbnailSelectedHover SystemColor="ButtonText"/>
    <ThumbnailSelectedActivePane SystemColor="Highlight"/>
    <ThumbnailSelectedInactivePane SystemColor="ButtonText"/>
    <ThumbnailHover SystemColor="ButtonText"/>
    <ThumbnailRest SystemColor="Highlight"/>
    <ThumbnailBorderGap SystemColor="Background"/>
</SwatchSet>
```

Once you have created or chosen the right palette, you can get the colors in your code by creating a palette object and then calling a function to get the color you need by its name. 

```js
Example: CL20226796

// Get the palette
PPTColor::ISlideThumbnailBorderColorsPalette* pThumbnailPalette = PPTColor::SlideThumbnailColorsPalette();

// Get a color from the palette
pThumbnailPalette->GetColor(
PPTColor::ISlideThumbnailBorderColorsSwatch::ThumbnailBorderGap );
```

In FleXML (an XML transformation language), specify the icon ID. You can recolor it by specifying the color font enabled equals false and the color from the palette used. To use Office palettes in Flexml, first include the header, then determine the palette for an element. Then, specify the named color with a Swatch prefix for a given property.

```js
<!-- #include "MsoPaletteNuiMacros.g.h" -->

<!-- Specify which palette to use for an element -->
<Element Palette="palette(TaskPane)"/>

<!-- Specify which color from the palette to use for the property -->
<Element background="swatchBkg"/>
```


Use SmartBitmaps, which are advanced image files optimized for better performance than regular bitmaps, only when necessary. When requesting SmartBitmap assets from the design team, make sure to specify that they must be compatible with high contrast mode. Specific palette indexes need to be used for them to recolor properly in high contrast mode. Make sure to verify that it looks correct in all states, in all high-contrast themes, and at various DPIs. 


## High-Contrast mode in web-based experiences 

CSS variables are used to manage color schemes, making it easier to adjust and maintain consistent contrast ratios throughout the application. By controlling the visual presentation in CSS, you can ensure the text is readable and accessible. CSS can enable you to use custom fonts that might not be available with fallback fonts available on the device. Use HTML for structure and CSS for styling so that the content is accessible and can be presented in various ways without losing its formatting. Use a CSS media query with **"-ms-high-contrast":** active for high contrast mode and add all the rules. Then, style various properties with the values you want to use in high-contrast mode.

```css
myclass:focus,
.myclass:hover {
     /* This renders in windowtext color in Firefox */
     outline: 2px dashed transparent;
}

/* CSS rules to override styling in High Contrast mode */
/* Works on inline SVG as well as HTML */
@media screen and (-ms-high-contrast: active) {
    .myclass {
        /* Include -ms-high-contrast-adjust: none; in each rule */
        -ms-high-contrast-adjust: none;

       /* Use old CSS system colors (window, windowtext, highlight, etc.) */
        color: windowtext;
        background-color: window;
    }

    .myclass:focus svg,
    .myclass:hover svg {
        -ms-high-contrast-adjust: none;
        fill: highlight;
        stroke: highlighttext;
    }
}
```

Firefox renders content in high contrast, but unfortunately, it does not support the **-ms-high-contrast** media query or system colors. Chrome and Opera do not support Windows High-Contrast mode, so the content will render the same as in normal mode.

## Iterative process 

Foster collaboration between designers and developers to ensure accessibility considerations are maintained during the coding process. Create prototypes and gather feedback from users, including those with visual disabilities, to identify and address accessibility issues early in the design process.