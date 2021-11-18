Blazor components provide layout and user interface logic for an application. Sometimes you want to create more generic components that can be reused across multiple applications. These components can contain tried and tested layout and logic, but allow a developer to customize them with more UI elements. These components are called *template components*.

You could use a template component to apply a common corporate look and feel across a web app. You define these elements in the template then apply this template to all pages in the web app. If you need to change the styling (perhaps the corporate logo changes following a rebranding exercise), you only need to make this change in one place - the template.

In this unit, you'll learn how to create template components, and how you can incorporate them into a Blazor Server application.

## Understand the RenderFragment type

A template component supplies the layout and logic for one or more fragments of HTML markup. This HTML is rendered using the context provided by the template component. A template component uses a *RenderFragement* object as a placeholder into which the markup is inserted at runtime. The following code illustrates a basic component named *HeadingComponent.razor*. The component contains a single *RenderFragment* object. The markup for the *RenderFragment* object is supplied as a parameter, and in this example, the object is given the name *ChildContent*. The layout provided by the template renders the markup with a fixed heading and a copyright message:

```razor
<h1>Contoso Ltd</h1>
<h3>Heading</h3>

@ChildContent

<p></p>
<p style="font-style:italic; color:red;">(c) 2021</p>
@code {
  [Parameter]
  public RenderFragment ChildContent { get; set; }
}
```

> [!NOTE]
> A template is just an ordinary Razor component.

To use this template, a Razor page creates a \<HeadingComponent\> element and specifies the markup to be displayed by the template as the body of the element. This markup will be passed to the template component in the *ChildContent* parameter. The example below shows a page named *testpage*:

```razor
@page "/testpage"

<HeadingComponent>
    <p>This text will be rendered by the template.</p>
    <p>So will this list:
    <ol>
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3</li>
    </ol>
    </p> 
</HeadingComponent>
```

The *testpage* page looks like this when it's rendered:

:::image type="content" source="../media/6-simple-testpage.png" alt-text="The *testpage* page rendered by using the template component.":::

The name *ChildContent* is the default name for a *RenderFragment* parameter. You can give the parameter a different name, but you must specify this name when the test page applies the template. As an example, the template below uses the name *BodyContent*:

```razor
<h1>Contoso Ltd</h1>
<h3>Heading</h3>

@BodyContent
<p></p>
<p style="font-style:italic; color:red;">(c) 2021</p>

@code {
  [Parameter]
  public RenderFragment BodyContent { get; set; }
}
```

A page utilizing this template must specify that the content to be rendered should be passed to the *BodyContent* parameter:

```razor
@page "/testpage"

<HeadingComponent>
    <BodyContent>
        <p>This text will be rendered by the template.</p>
        <p>So will this list:
        <ol>
            <li>Item 1</li>
            <li>Item 2</li>
            <li>Item 3</li>
        </ol>
        </p> 
    </BodyContent>
</HeadingComponent>
```

This approach enables a template component to format more than one *RenderFragment* object. Suppose you also wanted to provide the markup for the heading as a parameter. You can add a second parameter, like this:

```razor
<h1>Contoso Ltd</h1>
<h3>@HeaderContent</h3>

@BodyContent
<p></p>
<p style="font-style:italic; color:red;">(c) 2021</p>

@code {
  [Parameter]
  public RenderFragment HeaderContent { get; set; }

  [Parameter]
  public RenderFragment BodyContent { get; set; }
}
```

The *testpage* page can now specify markup for the heading and the body:

```razor
@page "/testpage"

<HeadingComponent>
    <HeaderContent>
        This is the test page heading
    </HeaderContent>
    <BodyContent>
        <p>This text will be rendered by the template.</p>
        <p>So will this list:
        <ol>
            <li>Item 1</li>
            <li>Item 2</li>
            <li>Item 3</li>
        </ol>
        </p> 
    </BodyContent>
</HeadingComponent>
```

### Understand generic RenderFragment parameters

By default, the *RenderFragment* class acts as a placeholder for a block of HTML markup. However, you can use it to render other types of content by using a type parameter, then providing the logic to handle the specified type in the template component. For example, suppose you want to create a template that displays the items in a collection. You might use a C# `foreach` loop to iterate through the collection and display the items found. However, the collection might contain data of any type, so you need a generic way of rendering each item. The following template component, named *ObjectDataList.razor*, shows how you can achieve this aim:

```razor
@typeparam TItem
@foreach(TItem item in Data ?? Array.Empty<TItem>())
{
    <p>@ChildContent(item)</p>
}


@code {
  [Parameter]
  public IEnumerable<TItem> Data { get; set; }

  [Parameter]
  public RenderFragment<TItem> ChildContent { get; set; }
}
```

The important points to note in this template are:

- The type parameter, *TItem*, is introduced using the *@typeparam* directive. A template component can have multiple type parameters if necessary.
- The template expects a parameter containing an enumerable collection of objects of the type specified by the type parameter.
- The template also defines a *ChildContent* parameter based on the generic *RenderFragment* type that takes the same type parameter.
- The `foreach` loop iterates through the enumerable collection, rendering each item found.

The page below shows how an application can use this template. This example is based on the data retrieved using the *WeatherForecastService* service created as part of the sample code generated by the Blazor Server App template. Remember that the *WeatherForecast* type looks like this:

```csharp
using System;

namespace WebApplication.Data
{
    public class WeatherForecast
    {
        public DateTime Date { get; set; }
        public int TemperatureC { get; set; }
        public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
        public string Summary { get; set; }
    }
}
```

The Razor page connects to the Weather Service and populates the *forecasts* array, as described in earlier examples in this module. The page provides the *forecasts* variable as the *Data* parameter to the *ObjectDataList* component, and then supplies the markup that's used to render each item in the array. This markup is passed as the *ChildContent* parameter to the template. The template makes the fields in each item available through the *context* variable. This variable is created automatically, based on the type parameter for the template component. In the *ObjectDataList* template component, the parameter *RenderFragment\<TItem\>* is actually a *RenderFragment\<WeatherForecast\>*, so the fields available in the *context* variable are those defined in the *WeatherForecast* class.

```razor
@page "/testpage"
@using WebApplication.Data
@inject WeatherForecastService ForecastService

<ObjectDataList Data=@forecasts>
    <h4>Date: @context.Date</h4>
    <p>Temperature (C): @context.TemperatureC</p>
    <p>Temperature (F): @context.TemperatureF</p>
    <p>Summary: @context.Summary</p>
</ObjectDataList>

@code {
    private WeatherForecast[] forecasts;

    protected override async Task OnInitializedAsync()
    {
        await base.OnInitializedAsync();
        forecasts ??= await ForecastService.GetForecastAsync(DateTime.Now);
    }
}
```

When the *testpage* page is rendered, it looks like this:

:::image type="content" source="../media/6-list-testpage.png" alt-text="The testpage page, showing the forecast data rendered by using the ObjectDataList template component.":::

## Compose templates

Many web apps make use of nested elements, such as list items within lists. In a similar way, you can create templates that format data by using other templates. You can then compose complex pages based on a series of simple templates. Each template focuses on providing the layout and logic for a specific aspect.

Suppose you want to create a template that emulates a collection of tab pages, with vertical tabs down the left side. The user selects a tab to display the corresponding page in the body of the component. The simplest way to implement this feature is to define two templates:

- A *VerticalTab* template that acts as a container for the vertical tabs and the current page being displayed.
- A *TabPage* template that renders a page within the *VerticalTab* template.

Starting with the *VerticalTab* template, the markup looks like this:

```html
<CascadingValue Value="this">
    <div class="row align-items-start">
        <div class="btn-group-vertical">
            @foreach (TabPage tabPage in Items)
            {
                <button type="button" class="btn @GetButtonClass(tabPage) text-left" style="margin-bottom: 10px;" @onclick=@(() => ActivateItem(tabPage) )>    
                    @tabPage.Title
                </button>
             }
        </div>
        <div class="card-body" style="background-color:#EBEBEB;">
            @ChildContent
        </div>
    </div>
</CascadingValue>
```

In this markup:

- The value of *this* (the current instance of the template), is configured as a cascading value that will be passed as a cascading parameter to each instance of the *TabPage* template referenced by the markup. This reference provides a way for each *TabPage* instance to query and obtain information from the *VerticalTab* template that acts as the container for each page.
- The first \<div\> element creates a vertically aligned collection of buttons. These buttons will simulate tab controls. Each button will display the title of a *TabPage* control (you'll see the *TabPage* template shortly). The *onclick* event runs the *ActivateItem* method of the template, which you'll see next.
- The second \<div\> element displays the page content for the currently selected tab. This page is displayed using the CSS *card-body* style.

The code section for the template defines the parameters, properties, and methods:

```razor
@code {
    [Parameter]
    public RenderFragment ChildContent { get; set; }
    
    public TabPage CurrentItem { get; set; }
    private List<TabPage> Items = new List<TabPage>();

    internal void AddItem(TabPage tabPage)
    {
        Items.Add(tabPage);
        if (Items.Count == 1)
        {
            CurrentItem = tabPage;
        }
        StateHasChanged();
    }

    string GetButtonClass(TabPage tabPage) => tabPage == CurrentItem ? "btn-primary" : "btn-secondary";

    void ActivateItem(TabPage tabPage) => CurrentItem = tabPage;
}
```

The *CurrentItem* property references the page currently being displayed. The pages are all stored in the *Items* list. The *AddItem* method adds a new page to the *Items* collection and calls *StateHasChanged* to update the display. The *ActivateItem* method sets the specified page as the current item.

The *GetButtonClass* is used to determine how the button that represents the page in the vertical tab \<div\> element is displayed. If the button is for the currently selected page, it's assigned the *btn-primary* CSS class, which causes the button to be highlighted. When you'd prefer the button target a different page, it's assigned the *btn-secondary* CSS class, which displays the button as deselected.

The *TabPage* template is simpler:

```razor
@if (Container.CurrentItem == this)
{
    @ChildContent
}

@code {
    [CascadingParameter]
    private VerticalTab Container { get; set; }

    [Parameter]
    public RenderFragment ChildContent { get; set; }

    [Parameter]
    public string Title { get; set; }
  
    protected override void OnInitialized()
    {
        if (Container is null)
        {
            throw new ArgumentNullException(nameof(Container), "Cannot create a tab page without a vertical tab container");
        }
        base.OnInitialized();
        Container.AddItem(this);
    }
}
```

The *Container* cascading parameter is a reference to the *VerticalTab* instance that displays the pages. The markup on this page determines whether the page represented by the container is the current page. If it is, the content for the page is displayed.

The *TabPage* template provides the *Title* parameter. The text for this parameter is used as the label on the button that acts as the tab in the *VerticalTab* object.

The *OnInitialized* event is used to add the page to the container, using the *AddItem* method of the container. This event also checks to ensure that the template is being used with the *VerticalTab* template. If there's no *VerticalTab* object referenced by the *Container* parameter, the code throws an exception.

To use these templates on a Razor page, add a \<VerticalTab\> element that contains one or more \<TabPage\> elements. For each \<TabPage\> element, you provide a title and markup that will be rendered on the page:

```razor
@page "/testpage"

<VerticalTab>
    <TabPage Title="Tab 1">
        <h1>Content for tab 1</h1>
        <p>Text</p>
        <p>Text</p>
        <p>Text</p>
    </TabPage>
    <TabPage Title="Tab 2">
        <h1>Content for tab 2</h1>
        <p>Rhubarb</p>
        <p>Custard</p>
    </TabPage>
        <TabPage Title="Tab 3">
        <h1>Content for tab 1</h1>
        <p>Cat</p>
        <p>Dog</p>
    </TabPage>
</VerticalTab>
```

The image below shows this page running. The user has selected the second tab.

:::image type="content" source="../media/6-vertical-tab.png" alt-text="The test page showing the vertical tab component with test data.":::

You can utilize these templates with the *ObjectDataList* template you saw earlier. This gives you another way to display weather forecast data, with the information for each day shown on a separate tab:

```razor
@page "/testpage"

@using WebApplication2.Data
@inject WeatherForecastService ForecastService

<h1>Weather forecast</h1>

<VerticalTab>
    <ObjectDataList Data=@forecasts>
        <TabPage Title=@context.Date.ToString()>
            <h3>Date: @context.Date</h3>
            <p>Temperature (C): @context.TemperatureC</p>
            <p>Temperature (F): @context.TemperatureF</p>
            <p>Summary: @context.Summary</p>
        </TabPage>
    </ObjectDataList>
</VerticalTab>

@code {
    private WeatherForecast[] forecasts;

    protected override async Task OnInitializedAsync()
    {
        await base.OnInitializedAsync();
        forecasts ??= await ForecastService.GetForecastAsync(DateTime.Now);
    }
}
```

:::image type="content" source="../media/6-weather-forecast-tabs.png" alt-text="Thw weather forecast data displayed using the vertical tab template.":::
