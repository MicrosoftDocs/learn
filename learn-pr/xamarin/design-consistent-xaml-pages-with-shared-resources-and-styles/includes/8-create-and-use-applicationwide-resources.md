Defining resources and styles on a XAML page is a great way to reduce repeated code. There's a problem, though. Those resources and styles are available only on that specific XAML page. Page-level resource dictionaries aren't sufficient to let you avoid repeated code across an application when you have multiple pages. Let's look at how to share resources and styles across all the pages in your application.

## Where resource dictionaries are available

The `VisualElement` class defines a `Resources` property. Views, pages, and layout panels inherit from `VisualElement`, so they all have a `Resources` property that can hold a resource dictionary.

The `Application` class also defines a `Resources` property. `Application` doesn't inherit from `VisualElement`, so the property is defined on its own. It has the same name and type as the one in `VisualElement`.

The following illustration shows the structure of a typical application. Each of the elements shown has a `Resources` property that can hold a resource dictionary.

![An image that shows the structure of a Xamarin.Forms application containing two pages, two layout panels, and several views](../media/8-resource-scope.png)

## How to define application-level resources and styles

You define application-level resources and styles in the XAML file associated with your `Application` class. The following code shows how to declare a `Color` resource in your application's dictionary. As usual, we don't need to explicitly create the `ResourceDictionary` object. We add items to the `Resources` property, and Xamarin.Forms creates the dictionary for us.

```xml
<Application.Resources>
    <Color x:Key="MyTextColor">Blue</Color>
</Application.Resources>
```

## How Xamarin.Forms locates a resource or style

Suppose you apply a resource to one of your views as shown in the following code.

```xml
<Label TextColor="{StaticResource MyTextColor}" ... />
```

Xamarin.Forms needs to locate the definition of that resource so it can apply the value. We know that a single application can have many dictionaries. Which dictionaries will Xamarin.Forms search? What order does it use? Let's examine the lookup rules that the system uses to find a resource.

It's common to think of the `VisualElement` instances on `Page` as forming a tree-like structure. The application is at the root, with the pages, layout panels, and views spreading out below it. This structure is often called the _visual tree_. Each element in the tree can have its own dictionary that can contain resources.

The search algorithm in Xamarin.Forms walks up the visual tree:

1. Begin the search with the dictionary in the `VisualElement` instance to which the resource is applied. In our previous example, we'd start with `Label`. If that element doesn't have a dictionary, or if it has a dictionary but the resource doesn't exist, then the search moves on.

1. Move to the parent of the view and repeat the search. Typically, the next place to be searched is a layout panel.

1. Check the parent of the layout panel. Typically, the next place to be searched is `Page`.

1. Look in the dictionary, in the `Application` class.

The search returns the first item found with a matching `x:Key` value. The following image summarizes the resource lookup sequence.

![An image that shows the Xamarin.Forms process for searching resource dictionaries to locate a resource definition](../media/8-lookup-rules.png)

In practice, most developers ignore the `Resources` property in views and layout panels. They use the page-level dictionaries for things they use on a single page. Resources and styles they want to share across multiple pages are defined at the application level. The lookup process then needs to check only two dictionaries: the one in the current `Page` instance and the one in `Application`.

### Duplicate keys aren't an error

Each `ResourceDictionary` instance is independent, which means that the same `x:Key` value can be used in more than one dictionary. Having the same `x:Key` value in multiple dictionaries on the search path won't cause an error. The resource associated with the first matching `x:Key` value on the path is the one that will be used.

Let's look at an example. Suppose you have the following resource defined in your `Application` class:

```xml
<Application.Resources>
    <x:String x:Key="msg">Two</x:String>
</Application.Resources>
```

Then you define the following resource in `Page` and apply it to `Label` on that same page:

```xml
<Page.Resources>
    <x:String x:Key="msg">One</x:String>
</Page.Resources>

<Label Text="{StaticResource msg}">
```

Because the first matching `x:Key` value is used, the `Text` property will be set to `One`.

## How to merge dictionaries

It's also possible to import dictionaries from one element to another. A dictionary imported from another dictionary is called a _merged dictionary_. Let's look at how to merge resource dictionaries.

Assume you have a `ContentPage` instance named `AboutPage`, and you define an `x:Key` resource named `size`.

```xml
<ContentPage ...>
    <Page.Resources>
        <x:Double x:Key="size">32</x:Double>
    </Page.Resources>
   ...
</ContentPage>
```

You then decide to merge the dictionary for `AboutPage` into another page called `SettingsPage`. You'll modify `ResourceDictionary` on `SettingsPage` in the following way:

```xml
<ContentPage ...>
    <Page.Resources>
        <ResourceDictionary MergedWith="theme:AboutPage" />
    </Page.Resources>
    ...
</ContentPage>
```

`SettingsPage` can now use any resources defined in the dictionary for `AboutPage`, along with resources defined in their own dictionary.