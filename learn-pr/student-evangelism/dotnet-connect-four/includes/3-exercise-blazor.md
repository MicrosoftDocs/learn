In this exercise, we create a Blazor project and we start building an app that becomes a "connect four" game throughout the course of the module.

## Create a new Blazor project

First, let's scaffold a new project for our game. With .NET 6 installed, we can start building our application at the command-line.

1. Create a new Blazor application in Visual Studio 2022 by choosing the "File - New... - Project" menu.

1. Choose a "Blazor WebAssembly App" from the list of templates and name it "ConnectFour". Select **next**.

1. Choose the .NET 6 framework, Authentication type should be set to "None" and uncheck the "ASP.NET Core hosted" checkbox.

   This action should create a ConnectFour directory containing our application.

1. Run the app by pressing F5 in Visual Studio 2022. 

    The app now runs on a random port between 5000 and 5300. HTTPS has a port selected for it in the range of 7000 to 7300.

   Your Output Window should report content similar to the following text:

    ```output
    Building...
    info: Microsoft.Hosting.Lifetime[14]
    	Now listening on: https://localhost:7296
    info: Microsoft.Hosting.Lifetime[14]
    	Now listening on: http://localhost:5136
    info: Microsoft.Hosting.Lifetime[0]
    	Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
    	Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
    	Content root path: C:\dev\ConnectFour
    ```

1. Let's navigate to the address our web server announced it's serving the application at.

   > [!NOTE]
   > In the above sample, we would navigate to http://localhost:5136. You should be presented with the following welcome screen in your browser:

   ![Blazor project running](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/1-NewTemplate.png)

   Congratulations! You've created your first Blazor application using the Blazor WebAssembly template.

## Create a Board component

Next, let's create a board component to be used by players in our game. The component is defined using Razor syntax, which is a mix of HTML and C#.

1. Right-click on the Shared folder in the Solution Explorer of Visual Studio. Choose **Add - Razor Component** from the context menu and name the file *Board.razor*.
1. Place this file in the *Shared* folder, this placement allows the component to be referenced and used throughout the application. 

    We use this component to hold everything needed for the game-board layout and managing interactions with it.

    The initial contents of this new component are a simple H3 tag and a code block indicating where C# code should be written:

    ```csharp
    <h3>Board</h3>
    
    @code {
    
    }
    ```

1. Prepare our Index page by opening the *Pages/Index.razor* file. Clear out everything after the third line with the **PageTitle** tags.

   ```csharp
   @page "/"
   
   <PageTitle>Index</PageTitle>
   ``` 

1. Add our Board component to the Index page by just adding a tag with the filename of our component to the Index page.

   ```csharp
   @page "/"
   
   <PageTitle>Index</PageTitle>
   <Board></Board>
   ```

1. Run our application with F5 and in the hot-reload toolbar button activate the "Hot reload on file save" option.

   Hot reload allows you to observe the evolution of the game from a simple page to a full Connect Four board with interactive pieces.

   ![App with board title](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/2-Board-Step1.png)

   Congratulations! You've built your first component and used it on a Blazor page.

## Adding layout and style to our board

Let's start defining a game board with the seven columns and six rows. We add a little style to bring our board to life.

1. In the Board.razor file, let's remove the HTML at the top and add the following content to define a board with 42 places to move.

   We can mix in some C# code in the form of a for loop to generate the 42 board positions. The span tag is picked up and repeated with its contents 42 times to represent our board.

   ```csharp
   <div>
      <div class="board">
        @for (var i = 0; i < 42; i++)
        {
          <span class="container">
            <span></span>
          </span>
        }
      </div>
   </div>
   ```

   When we save the board component, our application refreshes and it appears as an empty page, thanks to the "hot reloading" functionalitY that rebuilds and launches the updated app.

   > [!NOTE]
    > You may be prompted by Visual Studio to restart your app as files change. Confirm that the application should be rebuilt on code edits, and our application will automatically restart and refresh the browser for us as we add features.

### Styling the component

Let's add some style to this component by defining some colors for the frame of the board and the players, just above the first `div` tag of our Board.razor file:

    ```html
    <HeadContent>
    	<style>
    		:root {
    			--board-bg: yellow; 	/** the color of the board **/
    			--player1: blue;		/** Player 1's piece color **/
    			--player2: red;			/** Player 2's piece color **/
    		}
    	</style>
    </HeadContent>
  
    <div>
    ...
    ```

    These CSS variables `--board-bg`, `--player1: blue`, `--player2: red` will be picked up and used in the rest of our stylesheet for this component.

    Next, we'll add a completed stylesheet for the game from the 0-start folder in this repository.

1. Right-click in the Solution Explorer on the Shared folder and create a new CSS file called *Board.razor.css*. 
1. Copy the following content into the new *Board.razor.css* file:

   ```css
   div{position:relative}nav{top:4em;width:30em;display:inline-flex;flex-direction:row;margin-left:10px}nav span{width:4em;text-align:center;cursor:pointer;font-size:1em}div.board{margin-top:1em;flex-wrap:wrap;width:30em;height:24em;overflow:hidden;display:inline-flex;flex-direction:row;flex-wrap:wrap;z-index:-5;row-gap:0;pointer-events:none;border-left:10px solid var(--board-bg)}span.container{width:4em;height:4em;margin:0;padding:4px;overflow:hidden;background-color:transparent;position:relative;z-index:-2;pointer-events:none}.container span{width:3.5em;height:3.5em;border-radius:50%;box-shadow:0 0 0 3em var(--board-bg);left:0;position:absolute;display:block;z-index:5;pointer-events:none}.player1,.player2{width:3.5em;height:3.5em;border-radius:50%;left:0;top:0;position:absolute;display:block;z-index:-8}.player1{background-color:var(--player1);animation-timing-function:cubic-bezier(.5,.05,1,.5);animation-iteration-count:1;animation-fill-mode:forwards;box-shadow:0 0 0 4px var(--player1)}.player2{background-color:var(--player2);animation-timing-function:cubic-bezier(.5,.05,1,.5);animation-iteration-count:1;animation-fill-mode:forwards;box-shadow:0 0 0 4px var(--player2)}.col1{left:calc(0em + 9px)}.col2{left:calc(4em + 9px)}.col3{left:calc(8em + 9px)}.col4{left:calc(12em + 9px)}.col5{left:calc(16em + 9px)}.col6{left:calc(20em + 9px)}.col7{left:calc(24em + 9px)}.drop1{animation-duration:1s;animation-name:drop1}.drop2{animation-duration:1.5s;animation-name:drop2}.drop3{animation-duration:1.6s;animation-name:drop3}.drop4{animation-duration:1.7s;animation-name:drop4}.drop5{animation-duration:1.8s;animation-name:drop5}.drop6{animation-duration:1.9s;animation-name:drop6}@keyframes drop1{100%,75%,90%,97%{transform:translateY(1.27em)}80%{transform:translateY(.4em)}95%{transform:translateY(.8em)}99%{transform:translateY(1em)}}@keyframes drop2{100%,75%,90%,97%{transform:translateY(5.27em)}80%{transform:translateY(3.8em)}95%{transform:translateY(4.6em)}99%{transform:translateY(4.9em)}}@keyframes drop3{100%,75%,90%,97%{transform:translateY(9.27em)}80%{transform:translateY(7.2em)}95%{transform:translateY(8.3em)}99%{transform:translateY(8.8em)}}@keyframes drop4{100%,75%,90%,97%{transform:translateY(13.27em)}80%{transform:translateY(10.6em)}95%{transform:translateY(12em)}99%{transform:translateY(12.7em)}}@keyframes drop5{100%,75%,90%,97%{transform:translateY(17.27em)}80%{transform:translateY(14em)}95%{transform:translateY(15.7em)}99%{transform:translateY(16.5em)}}@keyframes drop6{100%,75%,90%,97%{transform:translateY(21.27em)}80%{transform:translateY(17.4em)}95%{transform:translateY(19.4em)}99%{transform:translateY(20.4em)}}
   ```

    > [!TIP]
    > For convenience, you can also find this content in the [TODO Board.razor.css](0-start/Shared/Board.razor.css) file in this repository.

    Here's some of the CSS used to format the board and 'punch holes' for each of the spaces. There's more content available than displayed below, in the CSS file, and we use that for the game pieces and their animations on screen.

    ```css
    div.board {
    	margin-top: 1em;
    	flex-wrap: wrap;
    	width: 30em;
    	height: 24em;
    	overflow: hidden;
    	display: inline-flex;
    	flex-direction: row;
    	flex-wrap: wrap;
    	z-index: -5;
    	row-gap: 0;
    	pointer-events: none;
    	border-left: 10px solid var(--board-bg);
    }
    
    span.container {
    	width: 4em;
    	height: 4em;
    	margin: 0;
    	padding: 4px;
    	overflow: hidden;
    	background-color: transparent;
    	position: relative;
    	z-index: -2;
    	pointer-events: none;
    }
    
    .container span {
    	width: 3.5em;
    	height: 3.5em;
    	border-radius: 50%;
    	box-shadow: 0 0 0 3em var(--board-bg);
    	left: 0px;
    	position: absolute;
    	display: block;
    	z-index: 5;
    	pointer-events: none;
    }
    ```

    Your browser should be refreshed for you (if not you can manually refresh the browser with F5), and you should be greeted with a proper yellow Connect Four board:

   ![Alt text](https://github.com/dotnet/intro-to-dotnet-web-dev/raw/main/5-blazor/img/2-Board-Step2.png)

   Congratulations, you now have the start of game. In later units, we add game logic to it.