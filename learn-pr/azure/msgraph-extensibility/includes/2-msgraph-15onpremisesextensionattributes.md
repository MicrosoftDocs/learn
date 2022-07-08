<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->

<!--TODO: add your topic sentences(s)-->

Microsoft Graph provides four types of extensions for adding custom properties to users and storing custom data. The first type of extensions is the 15 predefined **extension attribute properties**.

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
<!--TODO: add your scenario sub-task-->

In the team bonding app scenario, we want to store user-specific data about their public LinkedIn profile URL, Skype ID, and Xbox gamertag.

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
<!--TODO: write your prose table-of-contents-->

Here, you'll learn how to use the extension attribute properties to store the three pieces of user data about the employees.

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
<!--TODO: add a visual element-->

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
<!--## H2 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)-->

<!-- Pattern for complex chunks (repeat as needed) -->
<!--## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->

## 15 Extension attribute properties

The Microsoft Graph **user** resource defines 15 predefined extension attribute properties for adding custom data. With these properties, you don't define custom names for the extension properties. Instead, you only update the properties to store user-specific data.

### How extension attribute properties are presented for use

On the Microsoft Graph **user** resource is a predefined property called **onPremisesExtensionAttributes**. This property was initially intended to allow tenants to sync data from on-premises Active Directory (AD), hence the name. However, its use has evolved to support storing custom data in the cloud.

The return type for the **onPremisesExtensionAttributes** property isn't a primitive data type. Instead, the return type is a complex type named **onPremisesExtensionAttributes**. The **onPremisesExtensionAttributes** complex type in turn defines the 15 extension attribute properties with the following naming convention: *extensionAttribute{x}* where *{x}* is an integer between 1 and 15. *extensionAttribute{x}* can then be used to store String data values.

The following is a JSON representation of the **onPremisesExtensionAttributes** property with no values assigned to the 15 nested extension attribute properties.

```http
{
    "onPremisesExtensionAttributes": {
        "extensionAttribute1": null,
        "extensionAttribute2": null,
        "extensionAttribute3": null,
        "extensionAttribute4": null,
        "extensionAttribute5": null,
        "extensionAttribute6": null,
        "extensionAttribute7": null,
        "extensionAttribute8": null,
        "extensionAttribute9": null,
        "extensionAttribute10": null,
        "extensionAttribute11": null,
        "extensionAttribute12": null,
        "extensionAttribute13": null,
        "extensionAttribute14": null,
        "extensionAttribute15": null
    }
}
```

You don't need to store data in all extension attributes. You only store data based on your need and unused extension attributes can be *null*.

You also don't need to use the extension attributes in their logical order. For example, you can choose to use **extensionAttribute14** only or **extensionAttribute1** and **extensionAttribute9** only. To store the employees' public LinkedIn profile URL, Skype ID, and Xbox gamertag, you can choose to use **extensionAttribute13**, **extensionAttribute14**, and **extensionAttribute15**.

You can assign values to the extension properties when creating new users or by updating the properties for existing users. For your scenario, the employees will be updating their existing profiles through the team bonding app user interface that calls Microsoft Graph as the underlying API.

#### Query capabilities supported by extension attribute properties

Extension attribute properties support both the `$select` and `$filter` OData query parameters. The following operators are supported by `$filter`: `eq` and `ne` operators. You can also filter the results to return only users whose specific extension attributes are empty.

The extension attribute properties are specially indexed in Microsoft Graph for advanced querying. This means the HTTP request must include the `$count=true` query parameter and set the **ConsistencyLevel** header to `eventual`.

### Considerations for using extension attribute properties

The 15 extension attributes already predefined in Microsoft Graph and their property names can't be changed. Therefore, you can't use custom names such as **SkypeId** for the extension attributes. This requires you and the organization to define the extension attribute properties that are in use so that the values aren't inadvertently overwritten by other apps.