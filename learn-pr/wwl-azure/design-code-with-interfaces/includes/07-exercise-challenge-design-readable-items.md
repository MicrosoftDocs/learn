Code challenges reinforce what you've learned, and help you gain some confidence before continuing on.

The game designer is planning to add new items to the game. These items will include maps, scrolls, letters, and other texts. The designer wants to make sure that the player can read these items. The designer has asked you to add support for readable items.

## Challenge: Create Readable items

1. Create a new IReadable interface. 

    At a minimum, the interface should include the methods `Read` and `MarkAsUnread`.
    The `Read` method should mark the item as read, and the MarkAsUnread method should mark the item as unread.
    
    If you get stuck, take a look at the `IEquipable` interface for a hint on how to proceed.

1. A `Scroll` class has been added for you to test your interface with.

    Implement the IReadable interface on the `Scroll` class.

1. Open the **Model.cs** file and navigate to `GetItemAction` method.

    Update the method to return "Read" or "Mark as Unread" for items that implement `IReadable`.

1. Navigate to the **DoItemAction** method.

    Update the method to call the `Read` or `MarkAsUnread` methods for items that implement `IReadable`.

1. Navigate to the `GetReadables` method.

    This method needs to return a list of all `IReadable` objects in the player's inventory. Currently, this method doesn't contain any logic to successfully complete its task.

1. When you've completed your implementation, set the `ScrollsImplemented` boolean value to `true`.

    ```c#
    public static bool ScrollsImplemented = true;
    ```


## Check your work

When you've completed the code, test your code with the following steps:

1. Run the project and click "Text Items"

    The inventory should update to only display items that are readable. The available Scroll items should appear.
    
1. Select a scroll. 

    The action button should display "Read". 
    
1. Click the "Read" button.

    The button text should update to "Mark as Unread".
