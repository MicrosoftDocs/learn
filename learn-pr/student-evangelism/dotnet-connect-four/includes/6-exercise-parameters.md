The game works, but maybe you don't like our default colors. In Blazor, we can define parameters on our components that allow us to pass in values that look like attributes on an HTML tag.

In this exercise, we focus on customization and making the game look better using parameters.

## Customizing the board with parameters

Let's add some parameters for the colors on the board, and pass in some groovy colors from the `Home` page.

Parameters in Blazor are properties on a component that have been decorated with the `Parameter` attribute.

1. In *Board.razor*, let's define three properties for the board color, and each player's color. Before the `OnInitialized` method, add these lines of code:

    ```csharp
    [Parameter]
    public Color BoardColor { get; set; } = ColorTranslator.FromHtml("yellow");
    
    [Parameter]
    public Color Player1Color { get; set; } = ColorTranslator.FromHtml("red");
    
    [Parameter]
    public Color Player2Color { get; set; } = ColorTranslator.FromHtml("blue");
    ```

    We use the `Color` type to ensure that the values passed to our Board component are in-fact colors.

1. Add a `@using` directive to the top of the *Board.razor* file to indicate we're using content from the `System.Drawing` namespace.

    ```razor
    @using System.Drawing
    ```

1. Use the parameters in the CSS block at the top of *Board.razor* to set the values of the CSS variables.

    ```razor
    <HeadContent>
        <style>
            :root {
                --board-bg: @ColorTranslator.ToHtml(BoardColor);
                --player1: @ColorTranslator.ToHtml(Player1Color);
                --player2: @ColorTranslator.ToHtml(Player2Color);
            }
        </style>
    </HeadContent>
    ```

    This change shouldn't have changed anything in the appearance of our game board.

1. Let's head back to *Home.razor* and add some parameters to our `Board` tag and see how they change the game

    ```razor
    <Board @rendermode="InteractiveServer"
         BoardColor="System.Drawing.Color.Black"
         Player1Color="System.Drawing.Color.Green"
         Player2Color="System.Drawing.Color.Purple" />
    ```

    Isn't that a cool looking board?

    :::image type="content" source="../media/4-board.png" alt-text="Screenshot of showing end of game.":::
