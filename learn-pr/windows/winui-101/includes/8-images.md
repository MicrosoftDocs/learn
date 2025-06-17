To enhance the game's visual appeal, you'll add images representing different stages of the snow pal being built. This process involves adding images to your project and updating the ViewModel to dynamically change the image as the player makes incorrect guesses.

Add images to the project:

1. Go to **[this github repo](https://github.com/microsoft/Windows-DevRel/tree/main/Samples/SnowPal-Win-101/snowpal/Assets)** and locate the following images:

- snow-0.png
- snow-1.png
- snow-2.png
- snow-3.png
- snow-4.png
- snow-5.png
- snow-6.png

2. **Download** those images to your computer’s **Desktop**
3. In the Solution Explorer, open the **Assets folder** by double clicking
4. **Drag and drop** the **images** into the Assets folder

:::image type="content" source="../media/8-images/drag-and-drop.png" alt-text="Screenshot of the Visual Studio showing the Assets folder and the snow images.":::

5. **Select all** the snow images by either holding CTRL key and clicking on each image or click on the top-most image and hold SHIFT key and click on the bottom-most image
6. **Right click** on the select images
7. **Click** on **Properties**
8. A Properties panel will open
9. **Change** the Copy to Output Directory to `Copy if newer`
10. Close the Properties panel

:::image type="content" source="../media/8-images/properties.png" alt-text="Screenshot of the Visual Studio showing the images properties.":::

Setting the "Copy to Output Directory" property to "Copy if newer" ensures that image files are copied to the output directory where the compiled application runs, making them accessible at runtime. This setting optimizes the build process by only copying modified image files since the last build, reducing unnecessary file operations and improving build times.

## ViewModel

The ViewModel is responsible for knowing the image source path and using the `IncorrectGuesses` variable to dynamically change the image when the player makes an incorrect guess.

11. In the Solution Explorer, open the **MainViewModel.cs**
12. Above the `// Properties bound to the UI` comment, add the following:

```csharp
private string ImageSourcePath = "ms-appx:///Assets/snow-{0}.png";
```

13. Under the `// Properties bound to the UI` comment, add the following:

```csharp
[ObservableProperty]
public partial string ImageSource { get; set; }
```

14. Locate the `UpdateProperties` function
15. Add the following to the end of the `UpdateProperties` function:

```csharp
ImageSource = string.Format(ImageSourcePath, IncorrectGuesses);
```

## View

Now, update the View to bind the Image source to the `ImageSource` variable in the ViewModel.

16. In the Solution Explorer, open **GamePage.xaml**
17. Locate the **Image element**
18. Replace the Image element’s **source** with: ` "{x:Bind ViewModel.ImageSource, Mode=OneWay}"`

```xaml
<Image x:Name="Image" Grid.Row="1" Grid.Column="0" Style="{StaticResource ImageStyle}" Source="{x:Bind ViewModel.ImageSource, Mode=OneWay}"/>
```

19. On the title bar, **click** on **Debug**, **click** on **Start Debugging** OR on your keyboard press **F5** key

You should see something like this:

:::image type="content" source="../media/8-images/game-with-images.png" alt-text="Screenshot of game with images added.":::

You've successfully integrated dynamic images into your game, making it more interactive and fun for players. You added these images to your project, updated the ViewModel to dynamically change the image based on incorrect guesses, and modified the View to bind to this new image source.

The game is complete!
