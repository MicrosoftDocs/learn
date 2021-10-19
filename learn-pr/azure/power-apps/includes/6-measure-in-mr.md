Users can measure distance, area, and volume in the real world with Power Apps' Measure in MR component. You build two-dimensional and three-dimensional polygons during measuring, which can be used to confirm how a specific-sized object would fit within a space. 

When you include this feature in the application, it creates a button. When the button is pressed, the device's live camera feed appears. You can then choose a starting point and particular spots to measure. The measured segment distances are displayed in real-time on the live camera stream. After you exit the component, the measurements made are recorded or kept in the **Measurements** and **MeasurementsDetailed** properties. In addition, the Photos property stores screenshots collected throughout the mixed reality experience that can be viewed within the app.

>[!Note]
>The mixed reality parts work best in sufficiently bright conditions with flat surfaces. When setting up the following, point the gadget at the surface you might want to track and slowly pan the gadget from right to left in broad arm movements. In the case, if it fails, exit and enter the mixed reality view to reset the following and attempt once more.
>LIDAR-empowered gadgets will bring about better tracking.

## Properties

You can alter the Measure in MR component with several properties. Some of them are discussed below:

* **Unit of measurement** - This represents the measuring unit used during the session. You can choose from the dropdown having options like centimeters, meters, inches, and feet.
* **Measurement type** - You have the liberty to choose the measurement type; it can be point-to-point distance, a complete area, or a three-dimensional volume(area and height together).
* **Measurement** - A complete table describes the measured distances, areas, and volumes. It is composed of various sub-properties like Label, Id, Units, Height, Length, Area, Volume, and so on.
* **Photos** - You also can capture photos during the Measure in MR session. These photos can be utilized for future references.

## Formulas in power apps

Formulas created in your canvas app can respond to user input (as the app requires) and calculate values (as we do in Excel). You can create comparable formulas in Power Apps by configuring controls instead of cells. Users can also create formulas that are particular to apps rather than spreadsheets.

To decide how your app responds when users choose a button, alter a slider, or offer other input, you can create a formula. For example, these formulas could display a different screen, update an external data source, or build a table with a subset of the data in an existing table.

Formulas are made up of values, operators, and functions. These functions use parameters, execute an operation, and return a value. You can add formulas to specific properties of your UI components included in the application.

## If functions

**If** is a function that tests one or more conditions until it finds a true result. If such a result is obtained, a value is returned in its place. A default value is returned if no such result is discovered. The returned value could be a string to display, a formula to evaluate, or another form of result.
The most common syntax for this function is **If( Condition, ThenResult, DefaultResult )**, which provides the common “if … then … else …” pattern seen in other programming tools.
**If** is a tool for evaluating a variety of unrelated conditions. You can declare several conditions without nest If formulae in Power Apps (unlike Microsoft Excel).

**Syntax**:
**If**( Condition, ThenResult [, DefaultResult ] )
**If**( Condition1, ThenResult1 [, Condition2, ThenResult2, ... [ , DefaultResult ] ] )

## Switch functions

The **Switch** function evaluates a formula and determines whether the result matches any value in a specified sequence. A relative value is returned if a match is found. A default value is returned if no match is discovered. The returned value could be a string to display, a formula to evaluate, or another type of result in either instance.
**Switch** is a tool for comparing a single condition against numerous matches. In this scenario, you could also use If, but you'd have to repeat the formula for each possible match.

**Syntax**:
**Switch**( Formula, Match1, Result1 [, Match2, Result2, ... [, DefaultResult ] ] )

## Office 365 Outlook

When you connect to Office 365 Outlook, you can view, send, delete, and reply to email messages in addition to other tasks.
You can add controls to perform these functions in your application.

For example, you can add text input controls to request the recipient,  subject, and body of the email and add a button control to send the email.
