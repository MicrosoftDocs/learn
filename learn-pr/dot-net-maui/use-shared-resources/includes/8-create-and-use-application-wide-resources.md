Defining resources and styles on a XAML page is a great way to reduce repeated code. There's a problem, though. Those resources and styles are available only on that specific XAML page. Page-level resource dictionaries aren't sufficient to let you avoid repeated code across an application when you have multiple pages. In this unit, you see how to share resources and styles across all the pages in your application.

## Where resource dictionaries are available

The **VisualElement** class defines the **Resources** property. Controls, pages, and layouts inherit from **VisualElement**, so they all have a **Resources** property that can hold a resource dictionary.

The **Application** class also defines a **Resources** property. **Application** doesn't inherit from **VisualElement**, so the property is defined as part of this class.

The following illustration shows the structure of a typical application. Each of the elements shown has a **Resources** property that can hold a resource dictionary.

> [!NOTE]
> This diagram shows a much simplified depiction of how the items in an application are organized. In this diagram, the term *View* refers to a singleton control such as **Button** or **Label** that doesn't act as a container for any child controls. Also, the term *Layout* implies a container that is responsible for organizing the layout of its child controls. A layout can be nested. For example a **Grid** control could be held within a **StackLayout** control.

:::image type="content" source="../media/8-resource-scope.png" alt-text="A diagram of the  high-level structure of a typical .NET MAUI application.":::

## How to define application-level resources and styles

You define application-level resources and styles in the XAML file associated with your **Application** class. The following code shows how to declare a **Color** resource in the application resource dictionary.

```XML
<Application.Resources>
    <Color x:Key="MyTextColor">Blue</Color>
</Application.Resources>
```

## How .NET MAUI locates a resource or style

Suppose you apply a resource to one of your controls as shown in the following code.

```XML
<Label TextColor="{StaticResource MyTextColor}" ... />
```

.NET MAUI needs to locate the definition of that resource so it can apply the value. A single application can have many dictionaries. Which dictionaries will .NET MAUI search, and in which order? To answer these questions, it helps to think of the **VisualElement** instances on pages as forming a tree-like structure. The application is at the root, with the pages, layouts, and views spreading out below it. This structure is often called the *visual tree*. Each element in the tree can have its own dictionary that can contain resources. The style search algorithm in .NET MAUI walks up the visual tree:

1. Begin the search with the dictionary in the **VisualElement** instance to which the resource is applied. In the previous example, the search starts with the **Label** type. If there's no resource dictionary, or if it has a dictionary but the resource doesn't exist, then the search moves on.

1. Move to the parent of the  (control) and repeat the search. Typically, the next place to be searched is a layout.

1. Check the parent of the layout. Typically, the next place to be searched is the page, although if a layout is nested inside another layout (such as a **Grid** within a **StackLayout**), then the search will move up the tree to the parent layout.

1. Look in the dictionary for the **Application** class.

The search returns the first item found with a matching **x:Key** value. The following image summarizes the resource lookup sequence.

:::image type="content" source="../media/8-lookup-rules.png" alt-text="A diagram showing how .NET searches for resources. It starts at the view, then layouts, then pages, then to the application.":::

In practice, most developers ignore the **Resources** property in views and layouts. They use the page-level dictionaries for things they use on a single page. Resources and styles they want to share across multiple pages are defined at the application level. The lookup process then needs to check only two dictionaries: the one in the current page instance and the one in application.

> [!NOTE]
> If a resource with the specified key isn't found, the app will use default values for the styling.

## Duplicate keys

Each **ResourceDictionary** instance is independent, which means that the same **x:Key** value can be used in more than one dictionary. Having the same **x:Key** identifier in multiple dictionaries on the search path doesn't cause an error. The resource associated with the first matching **x:Key** value on the path is the one used.

For example, suppose you have the following resource defined in your **Application** class:

```XML
<Application.Resources>
    <x:String x:Key="msg">Two</x:String>
</Application.Resources>
```

Then you define the following resource in a **ContentPage** and apply it to a **Label** on that same page:

```XML
<ContentPage.Resources>
    <x:String x:Key="msg">One</x:String>
</ContentPage.Resources>
...
<Label Text="{StaticResource msg}">
```

Because the first matching **x:Key** value is used, the **Text** property is set to **One**.

<!-- REMOVE THE REMAINING CONTENT IF DICTIONARY MERGING IS NOT IMPLEMENTED IN .NET MAUI -->
<!-- ## How to merge dictionaries

It's also possible to import dictionaries from one element to another. This enables you to combine the entries in one dictionary with another when the dictionary is searched for resources. A dictionary imported from another dictionary is called a *merged dictionary*.

Consider this example. Assume you have a **ContentPage** named **AboutPage**, and you define a resource named **size**.

```XML
<ContentPage ...>
    <ContentPage.Resources>
        <x:Double x:Key="size">32</x:Double>
    </ContentPage.Resources>
   ...
</ContentPage>
```

You decide to merge the dictionary for **AboutPage** into another page called **SettingsPage**. You can modify the **ResourceDictionary** on **SettingsPage** in the following way:

```XML
<ContentPage ...>
    <ContentPage.Resources>
        <ResourceDictionary MergedWith="theme:AboutPage" />
    </Page.Resources>
    ...
</ContentPage>
```

**SettingsPage** can now use any resources defined in the dictionary for **AboutPage**, along with resources defined in its own local dictionary.
-->
