Information is a vital part of any application; the entire logic resides on the type of information stored. In Power Apps, the data is stored in a data source that can be accessed using connections. The connection utilizes a particular connector to converse with the data source. Many significant services and on-premises data sources, such as SharePoint, SQL Server, Office 365, Salesforce, and Twitter, have connectors in Power Apps.

The most common data sources are tables, which you can use to store and retrieve information. Connections help you read and write data in Microsoft Excel workbooks, SharePoint lists, SQL tables, and many other formats. You can store these in cloud services such as OneDrive, DropBox, and SQL Server.

A connector might give tables of information or actions. A few connectors provide just tables, some provide just actions, and some provide both. Your connector might be either standard or custom.

## Local data sources

To create an app that reads and writes from a data source, you must use one of these controls. They are:

* **Gallery**: Use the Gallery control to filter, sort, search, and scroll through records in a data source, and then select a specific record. You can also display only certain fields from each record so that you can display several records at a time even on a small screen.

* **Display form**: The display form helps you show any or all fields in a single record.

* **Edit form**: The Edit form allows you to update one or more fields in a single record (or create a record starting with default values) and save those changes back to the underlying data source.

These controls are used when Power Apps creates an app from data. Behind the scenes, the application stores and manipulates data from the data source using an internal table.

## SharePoint

There are many SharePoint features that allow users to create specific projects and establish standard business processes for information sharing, document publishing, and recording data. These features help business users be more productive, but SharePoint outperforms previous document-collaboration systems in displaying information about what information/documents are stored and why.

It's straightforward to demand **metadata**, or information about data (such as modified time, created by, and so on, but also custom **tags** on documents or objects) in SharePoint. Workers can better understand why a document exists and why it's important without having to read it. SharePoint also allows users to create custom databases in an easy-to-use structure, allowing them to store thousands of bits of data that may be incorporated into the workflows or other business processes discussed above.

## Controls and properties in canvas apps

In Microsoft Power Apps, users can plan and build a business application using components rather than writing code in a traditional programming language like C#. They can design applications by dragging and dropping elements into a canvas, just as they would design a slide in PowerPoint. Indicating logic and working with data can be achieved through an Excel-like experience. Users can create apps that combine business data from several Microsoft and third-party sources. They're allowed to share the app so that users can run it in a browser or on a mobile device, and embed the app so they can run it in SharePoint, Power BI, or Teams. Here are some of the controls available in Power Apps:

* **Buttons**: Associate with the application by clicking or tapping
* **Gallery**: Show a list of records that contain different sorts of data
* **Drop down**: Shows the first item in a rundown until a chevron is selected
* **Image**: Show a picture from (for instance) a file or a data source
* **Camera**: Take photographs and save them in the app or to a data source

## Gallery control

A **Gallery** control can display multiple records from a data source, and each record can contain various types of data. For example, you can use **Gallery** control to show different products. Each item shows product details that include a name, an image, price, and so on for each product.

Each data field is displayed in a separate control within the Gallery control; you can configure these controls in your template. Any changes made to the template are reflected throughout the gallery control. Predefined templates are available for displaying images and text in a gallery; a gallery for items with varying heights is also available.

> [!IMPORTANT]
> If a user scrolls the **Flexible height** gallery control before all items are loaded, the item that's currently in view might be pushed down and out of view when the data loading is finished. To avoid this issue, use a standard **Gallery** control instead of the **Flexible height** variant.
