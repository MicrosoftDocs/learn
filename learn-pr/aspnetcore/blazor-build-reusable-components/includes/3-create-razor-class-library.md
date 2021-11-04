In this exercise, we will create a simple modal dialog that can be included and referenced in other Blazor applications.

![Screenshot of our desired modal dialog presented in the standard Blazor template application](../media/first-modal.png)

Our outcome of this exercise will be a reusable modal dialog in a Razor class library that we use in the default Blazor template application.

## Create the Razor class library Project

Let's first create the Razor Class library project for a modal dialog component.  You can use Visual Studio to create a new project or you can create the project in a new folder with the .NET Command-line tool as follows:

```dotnetcli
dotnet new razorclasslib -o FirstClassLibrary -f net6.0
```

## Build the Modal Dialog Component

Next, we will build the `Modal` component in our project with an appropriate CSS file to go with it and provide an initial format.

1. Rename the `Component1.razor` file to `Modal.razor` and the `Component1.razor.css` file to `Modal.razor.css`.  This file contains the component we will create and in the future you can add blank text files to your project and format them with content for razor or CSS appropriately.
1. Add the following razor content to the Modal.razor file

    ```razor
    @if (Show) {
    
     <div class="dialog-container">
      <div class="dialog">
       <div class="dialog-title">
        <h2>@Title</h2>
       </div>
    
       <div class="dialog-body">
        @ChildContent
       </div>
    
       <div class="dialog-buttons">
        <button class="btn btn-secondary mr-auto" @onclick="OnCancel">@CancelText</button>
        <button class="btn btn-success ml-auto" @onclick="OnConfirm">@ConfirmText</button>
       </div>
    
      </div>
     </div>
    
    }
    
    @code {
    
     [Parameter]
     public string Title { get; set; }
    
     [Parameter]
     public string CancelText { get; set; } = "Cancel";
    
     [Parameter]
     public string ConfirmText { get; set; } = "Ok";
    
     [Parameter]
     public RenderFragment ChildContent { get; set; }
    
     [Parameter]
     public bool Show { get; set; }
    
    
     [Parameter] public EventCallback OnCancel { get; set; }
     [Parameter] public EventCallback OnConfirm { get; set; }
    
    }
    ```

    This component has several nice features that we want to share between our projects.  It allows for a `Title`, Cancel, and Confirm button labels to be configured, inner content of the component to be set through the `ChildContent` parameter, control the display or hidden state of the dialog with the `Show` parameter and handle the click events of the two buttons.

1. Add the following CSS to the `Modal.razor.css` file to provide default formatting for the component:

    ```css
    .dialog-container {
     position: absolute;
     top: 0;
     bottom: 0;
     left: 0;
     right: 0;
     background-color: rgba(0,0,0,0.5);
     z-index: 2000;
     display: flex;
     animation: dialog-container-entry 0.2s;
    }
    
    @keyframes dialog-container-entry {
     0% {
       opacity: 0;
     }
    
     100% {
       opacity: 1;
     }
    }
    
    .dialog {
     background-color: white;
     box-shadow: 0 0 12px rgba(0,0,0,0.6);
     display: flex;
     flex-direction: column;
     z-index: 2000;
     align-self: center;
     margin: auto;
     width: 700px;
     max-height: calc(100% - 3rem);
     animation: dialog-entry 0.4s;
     animation-timing-function: cubic-bezier(0.075, 0.820, 0.165, 1.000);
    }
    
    @keyframes dialog-entry {
     0% {
       transform: translateY(30px) scale(0.95);
     }
    
     100% {
       transform: translateX(0px) scale(1.0);
     }
    }
    
    .dialog-title {
     background-color: #444;
     color: #fff2cc;
     padding: 1.3rem 0.5rem;
    }
    
     .dialog-title h2 {
       color: white;
       font-size: 1.4rem;
       margin: 0;
       font-family: Arial, Helvetica, sans-serif;
       line-height: 1.3rem;
     }
    
    .dialog-body {
     flex-grow: 1;
     padding: 0.5rem 3rem 1rem 0.5rem;
    }
    
    .dialog-buttons {
     height: 4rem;
     flex-shrink: 0;
     display: flex;
     align-items: center;
     background-color: #eee;
     padding: 0 1rem;
    }
    ```

    This markup gives some default coloring to a title bar and button bar at the bottom, making it more interesting than a simple set of grey colored HTML elements.

## Reference and Use the Modal Component

With the `Modal` component residing in the `FirstClassLibrary` project, let's add a new Blazor Server application and start using the `Modal` component. 

1. Create a new Blazor Server project called `MyBlazorServer` in a folder next to the `FirstClassLibrary` project by either using the Visual Studio Add New Project feature or executing the following at the command line:

    ```dotnetcli
    dotnet new blazorserver -o MyBlazorServer -f net6.0
    ```

1. In the `MyBlazorServer` project, let's add reference to the `FirstClassLibrary` project by using the Visual Studio Add Reference feature or we can execute the following command from the `MyBlazorServer` folder:

    ```dotnetcli
    dotnet add reference ../FirstClassLibrary
    ```

    This project reference allows the `MyBlazorServer` application to interact with the components in the `FirstClassLibrary` project.

1. Let's make it easier to reference the `Modal` component by adding an entry to the end of the `_Imports.razor` file in the `MyBlazorServer` application.  This allows us to reference the `Modal` component without specifying the entire namespace for the component.

    ```dotnetcli
    @using FirstClassLibrary
    ```

1. Now we can add a `Modal` component to the opening page of this application.  Let's add that component and give it a title 'My first Modal dialog' with some content in a paragraph to be presented inside the dialog.  Also, we will want to set the dialog to be shown by using the `Show` parameter.

    ```razor
    <Modal Title="My first Modal dialog" Show="true">
     <p>
       This is my first modal dialog
     </p>
    </Modal>
    ```

## Check your work

1. Run the `MyBlazorServer` application and open it in your browser.
1. You should be greeted with the 'My first Modal dialog' dialog overlaying the rest of the content on screen.

![Screenshot of the desired modal dialog presented in the standard Blazor template application](../media/first-modal.png)