In this module, you'll be using some of the key functional components of **Power Apps**. This includes, Measure in MR, Emailing via Power Apps, Filtering ways and techniques, and so on. Users can measure distance, area, and volume in the real world with Power Apps' **Measure in MR** component.

## Spatial filtering using Measure in MR

We will leverage the power of **Measure in MR** in spatially filtering the products that can be easily placed in the real world according to the measurements received through the measuring session. We will also use some basic formulas to perform the filtering.

1. Navigate to the **Home page** and on the **Insert** tab, expand the **Mixed Reality** dropdown, and select **Measure in MR**.

2. Position the **Measure in MR** button as shown in the figure and configure the following properties:
    * **Text**: Filter by Dimensions
    * **Unit of measurement**: Centimeters
    * **Mesurement type**: Freeform

3. On the **Insert** tab, expand the **Gallery** dropdown and select **Vertical**. Rename the **Gallery** to **Measure_gallery**.

4. Position the **Vertical Gallery** just below the **Filter by Dimensions** button. Next, configure the **Layout** property by selecting **Title, Subtitle, and body**.

5. Configure the **Data source** property of the **Measure_gallery** by adding the following line:

    ```Power Apps
    MeasureInMR1.Measurements
    ```

6. Position the **Title**, **Subtitle**, and **Body** equidistant from each other as shown in the picture.

7. Configure the **Text** property of the three labels in the following way respectively:
    * **Title**:

        ```Power Apps
        "Unit: "&ThisItem.Unit
        ```

    * **Subtitle**:

        ```Power Apps
        "Area: "&ThisItem.Area&"cm²"
        ```

    * **Body**:

        ```Power Apps
        "Height: "&ThisItem.Height&"cm"
        ```

8. Let's add a **Reload** icon to let the users redo the measurements if they are not happy. On the **Insert** tab, expand the **Icons** dropdown and select **Reload** icon.

9. Position the icon as shown in the figure and configure the **OnSelect** property in the following way:

    ```Power Apps
    UpdateContext({galleryvisible:false});
    ```

10. Once the **Measure in MR** component is fully configured, we move to the **Spatial filtering**. Navigate to the **Sofas** page and configure the **Items** property by adding the following:

    ```Power Apps
    If (
    Measure_gallery.Selected.Height = 0,
    Filter('Easy Sales - Sofas', Area <= Measure_gallery.Selected.Area),
    Measure_gallery.Selected.Height > 0,
    Filter('Easy Sales - Sofas', Area <= Measure_gallery.Selected.Area && Height <= Measure_gallery.Selected.Height), 'Easy Sales - Sofas'
    )
    ```

    >[!Important]
    > Provide appropriate names for the **SharePoint** list and **Gallery** to avoid having errors in the future. Maintain the names of the components in the formulas to avoid confusion.

11. Follow the same procedure for **Chairs** and **Tables** page. Configure the **Items** property in the following way respectively:

    * **Chairs**:

        ```Power Apps
        If (
        Measure_gallery.Selected.Height = 0,
        Filter('Easy Sales - Chairs', Area <= Measure_gallery.Selected.Area),
        Measure_gallery.Selected.Height > 0,
        Filter('Easy Sales - Chairs', Area <= Measure_gallery.Selected.Area && Height <= Measure_gallery.Selected.Height), 'Easy Sales - Chairs'
        )
        ```

    * **Tables**:

        ```Power Apps
        If (
        Measure_gallery.Selected.Height = 0,
        Filter('Easy Sales - Tables', Area <= Measure_gallery.Selected.Area),
        Measure_gallery.Selected.Height > 0,
        Filter('Easy Sales - Tables', Area <= Measure_gallery.Selected.Area && Height <= Measure_gallery.Selected.Height), 'Easy Sales - Tables'
        )
        ```

>[!Note]
> We're not going to spatially filter products in the **Carpets** page as we add a feature specific to the product. We'll be calculating the price of the carpet concerning the area calculated in the **Measure in MR** session.

## Calculate price based on area

1. Navigate to the **Details_carpets** page, configure the empty label beside **Area** in the following way to display the area calculated:

    ```Power Apps
    Measure_gallery.Selected.Area&"cm²"
    ```

2. Configure the label beside the **Price** label in the following way to display the calculated price:

    ```Power Apps
    "$"&Measure_gallery.Selected.Area * content_carpets.'Price/cm2'
    ```

## Create order summary page

1. Consider adding a **Button** to **Details_sofas**, **Details_chairs**, **Details_tables**, and **Details_carpets** screens. Rename the button to **Order** and change the display text of the button to **Order**.

2. Create four new **Blank** screens and rename them as **Order_sofas**, **Order_chairs**, **Order_tables**, and **Order_carpets**.

3. Navigate to the **Details_sofas** screen and configure the **OnSelect** property of the **Order** button as seen below:

    ```Power Apps
    Navigate('Order_sofas',ScreenTransition.Cover)
    ```

4. Follow the same procedure for **Details_chairs**, **Details_tables**, and **Details_carpets** screens.

5. In the **Order_sofas** page, insert **Product**, **Price**, **Color**, and **Notes** labels and rename them accordingly.

6. Insert empty label beside the **Product**, **Price**, **Color**, and **Notes** as shown in the figure.

7. Configure the **Text** property of these empty labels in the following way:
    * **Product**:

        ```Power Apps
        Gallery_sofas.Selected.'Name (Title)'
        ```

    * **Price**:

        ```Power Apps
        Gallery_sofas.Selected.Price
        ```

    * **Color**:

        ```Power Apps
        Gallery_sofas.Selected.Color
        ```

    * **Notes**:

        ```Power Apps
        TextInput_sofas.Text
        ```

8. Consider adding another label at the top and change its display text to **Order Summary**. Change the font size and font according to your requirement.

9. On the **Insert** tab, expand the **Gallery** dropdown and select **Horizontal**. Retain only the image and delete other components of the **Gallery**.

10. Configure the **Items** property of this gallery by adding the line given below:

    ```Power Apps
    ViewInMR1.Photos
    ```

11. Add three **Labels** and change the display text as **Enter your email to get an order confirmation mail!**, **Organization mail ID:**, and **Customer mail ID:** respectively.

12. On the **Insert** tab, expand the **Input** dropdown and select **Text input**. Add two **Text input** components to the screen and position them as shown in the figure. Rename them as **Input1** and **Input2** respectively

13. Configure the **Hint text** property by adding **Enter mail ID:** and store no value in the **Default** property. Then, adjust the font size and color according to your need.

14. Consider adding a button from the **Insert** tab and configure its **Text** property by adding **Confirm**.

15. On the **Insert** tab, expand the **Icons** dropdown and select **Back** and **Home** icon. Position them correctly, as shown in the figure.

16. Configure the **OnSelect** property of these two icons in the following way:
    * **Back**:

        ```Power Apps
        Navigate(Details_sofas,ScreenTransition.CoverRight)
        ```

    * **Home**:

        ```Power Apps
        Navigate('Home Page',ScreenTransition.CoverRight)
        ```

## Create end page

1. Create a **Blank** screen and rename it as **End page**.

2. Add a **Label** and change its display text to **Order Successfully Placed!**. Position the label as required on the screen.

3. Consider adding a **Button** at the bottom of the screen. Configure the **Text** property of the button by adding **Shop more**. Let's navigate the user to the home page by clicking the **Shop more** button by adding the following line in the **OnSelect** property.

    ```Power Apps
    Navigate('Home Page',ScreenTransition.Cover)
    ```

## Send emails via Power Apps

1. Click the **Data** tab and select **+ Add data**. Next, expand the **Connectors** to select **Office 365 Outlook** to add it as one of the connectors for this application.

2. Configure the **OnSelect** property of the **Confirm** button by adding the following lines:

    ```Power Apps
    Office365Outlook.SendEmailV2(Input1 & ";"& Input2,"Order Summary","<b> Your order is successfully placed! </b> <br>
    Order details are as follows: <ul> <li> Product: " & Name_sofa2 & "</li> <li> Price: " & Price_sofa2 & "</li> <li> Color: " & color_sofa2 & "</li> </ul>Notes: " & TextInput3 & "<br><b> Thank you for shopping with us! </b>");
    Navigate('End Screen',ScreenTransition.Cover) 
    ```

    >[!Note]
    >The names used in the above function follow the namings used in this application at the time of development. You may customize the function concerning your application.
    