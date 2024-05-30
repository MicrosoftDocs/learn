In the previous exercise, you used the accessibility error indicators in the form elements on the sample webpage. In this exercise, you use Accessibility Insights for Web to find and fix visual accessibility issues.

1. Run the application, and then run FastPass. You should see three color contrast issues detected.

    :::image type="content" source="../media/fast-pass-contrast-issues.png" alt-text="Screenshot of FastPass results, showing issues of color contrast.":::

1. Expand the first issue to show more details.

    :::image type="content" source="../media/contrast-details.png" alt-text="Screenshot that shows details of a color contrast issue in Accessibility Insights for Web.":::

  Here's the important part:

  > "Element has insufficient color contrast of 4.44 (foreground color: #6c757d, background color: #f8f9fa, font size: 12.0pt (16px), font weight: normal). Expected contrast ratio of 4.5:1"

  This information tells you that the accessibility standards recommend a contrast ratio of 4.5:1, but your gray text (using class `text-muted`) on a gray background (from class `bg-light`) is only 4.44:1.

  If you look at the other contrast errors, you can see that they all have the same issue.

  You have two simple options: either eliminate the gray background or use standard black text. After a quick chat with your designer, you decide to use black text on the gray background.

1. Edit the HTML and remove the `text-muted` class from the three `bg-light` paragraphs. The resulting HTML below the form should look like the following example.

    ```html
    <p style="font-size: 30px"><b>All about our wonderful pizza!</b></p>
    <p class="bg-light">We make it fresh every day, sometimes up to three times a day!<br><br>
    We love to make pizza!
    </p>
     
    <div class="text-center">
      <img width="120" src="data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='M.226 112L36.2.2c60 16 74 49 81 84z' fill='%23ea8'/%3e%3cpath d='M.197 112L31 14C84 29 96 57 103 88z' fill='%23fea' /%3e%3c/svg%3e">
    </div>
     
    <p style="font-size: 30px"><b>We take your privacy seriously!</b></p>
    <p class="bg-light">Unlike other pizza restaurants that share your pizza preferences, we care about your privacy.<br><br>
    Want to know more? <a href="/Privacy">Click here.</a>
    </p>
     
    <p style="font-size: 30px"><b>Delivery options</b></p>
    <p class="bg-light">There are a few ways we can get the pizza to you:<br>
      - Postal mail<br>
      - Dog sled<br>
      - Drone (experimental!)
    </p>
    ```

1. Run the application and FastPass again to verify that the color contrast issues are cleared.

  > [!NOTE]
  > If a single color contrast issue remains for the *Click here* link text, you can ignore it. The issue is not related to this module.

In the next unit, we'll look into making content accessible to screen readers.
