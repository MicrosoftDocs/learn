The Contoso Pets app helps find new homes for abandoned pets. The team wants the search feature improved to let users enter multiple terms when searching for dogs to adopt.

## Search specification

In this first challenge exercise, you need to update the single term search feature to allow users to enter multiple search terms separated by commas.

### Gather multiple search terms from the user

- Allow the user to enter multiple search terms when searching for dogs
- The user needs instructions to "enter the search terms separated by commas"
- Separate out individual search terms from the user entry string and store as values in an array
- Sort the terms in the array in *alphanumeric sort order*

### Identify dogs with descriptions with matches for one, or more, user search term

- As you identify a dog in the `animalsArray`, search for matches for each term the user has entered
- For a term match, output a message with the dogs name and the term that is matched
  - example: `Our dog Jake is a match for your search for sheppard!`
- When all term searches complete for the current dog description:
  - For one or more matches, output the nickname and description for the current dog
  - For one or more matches, track that there has been a match so you know not to display an "no matches found for any available dogs" message (refer to the next item)
- After *all* dog searches complete with no matches, display a message "No matches found for any available dogs"

### Enforce the following validation rules

- values can't be null
- values can't have zero characters
- any further restriction is up to the developer

### Code comments

- Numbered code comments in the starter code offer suggestions
- The comments are in a sequential order and only the comments starting with #1, #2, and #3 apply to this exercise of the challenge

### Sample output

- Review the following animated image
  - Notice the temporary display of "`searching...`" followed by the current term (example: "`searching...retriever`")
  - Notice the order the terms appear in search is now in alphanumeric
  - Notice the messages for matches persist (example: "`Our dog lola is a chase match!`")
  
    :::image type="content" source="../media/pet-search-animation.gif" alt-text="Example of application searching dog descriptions with four user submitted terms":::

- Review the sample output in the following section, "How to check your work", to further clarify how to implement features

## How to check your work

To validate that your code satisfies the specified requirements, complete the following steps:

1. Use Visual Studio Code to build and run your app.

> [!NOTE]
> You can exit the verification test before completing all of the verification steps if see a result that does not satisfy the specification requirements. To force an exit from the running program, in the Terminal panel, press **Ctrl-C**. After exiting the running app, complete the edits that you believe will address the issue you are working on, save your updates to the Program.cs file, and then re-build and run your code.

1. The terminal command prompt should display as the starting point for the program

1. At the command prompt, enter **2** menu:

    ```Output
    Welcome to the Contoso PetFriends app. Your main menu options are:
     1. List all of our current pet information
     2. Display all dogs with a specified characteristic
    
    Enter your selection number (or type Exit to exit the program)
    2
    
    Enter dog characteristics to search for separated by commas
    ```

1. At the command prompt, enter **large, cream, golden** to test when more than one search term matches the dog descriptions. Verify that the Terminal panel updates with a message similar to the code output sample:

    ```Output
    Enter dog characteristics to search for separated by commas
    large, cream, golden
    
    Our dog Nickname: lola matches your search for cream
    Our dog Nickname: lola matches your search for golden
    Nickname: lola (ID #: d1)
    Physical description: medium sized cream colored female golden retriever weighing about 45 pounds. housebroken.
    Personality: loves to have her belly rubbed and likes to chase her tail. gives lots of kisses.
    
    Our dog Nickname: gus matches your search for golden
    Our dog Nickname: gus matches your search for large
    Nickname: gus (ID #: d2)
    Physical description: large reddish-brown male golden retriever weighing about 85 pounds. housebroken.
    Personality: loves to have his ears rubbed when he greets you at the door, or at any time! loves to lean-in and give doggy hugs.
    
    Press the Enter key to continue
    ```

1. At the command prompt, press the enter key to continue to the main menu

1. At the command prompt, enter **2** menu:

    ```Output
    Welcome to the Contoso PetFriends app. Your main menu options are:
     1. List all of our current pet information
     2. Display all dogs with a specified characteristic
    
    Enter your selection number (or type Exit to exit the program)
    2
    
    Enter dog characteristics to search for separated by commas

    ```

1. At the command prompt, enter **big, grey, stripes** to test when none of the search terms match dog descriptions. Verify that the Terminal panel updates with a message similar to the code output samples:

    ```Output
    Enter dog characteristics to search for separated by commas
    big, grey, stripes
    
    None of our dogs are a match for: big, grey, stripes

    
    Press the Enter key to continue
    ```

1. If you specified further restrictions for valid entries, run the appropriate test cases to verify your work.

> [!NOTE]
> If your code meets the requirements you should be able to complete each step in order and see the expected results in a single test pass. If you added additional restrictions, you may need to exit the application and then run a separate test pass to complete your verification.

Congratulations if you succeeded in this challenge exercise!
