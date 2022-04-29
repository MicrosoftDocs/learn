Sometimes, no matter how well you plan, things go wrong. Imagine two developers are working on the same project file at the same time. The first developer pushes their changes up to the `main` branch of the project repo without any issue. When the second developer tries to push their changes, Git says there's a *merge conflict*. The file that the second developer is trying to modify is no longer up to date in terms of the most recent changes or file version. The file version must be brought up to date before the second developer's changes can be merged in. Developers who use version control dread few things more than a merge conflict!

Conflicts like this can happen, so you *must* know how to deal with them. The good news is that Git provides solutions for dealing with merge conflicts.

## Create branches for Alice and Bob

Let's begin by creating a branch for Alice and a branch for Bob. Both of your developer friends are updating files in the project repo at the same time. They're not aware of each other's changes because they're making updates in their local branches.

1. Be sure you're in the *Alice* directory, and then create a branch named `add-cat` for Alice to work in:

    ```bash
    git checkout -b add-cat

    ```

1. Change to the *Bob* directory, and then create a branch named `style-cat` for Bob to work in:

    ```bash
    cd ../Bob
    git checkout -b style-cat

    ```

Now, let's make some changes in the branches.

## Make a change as Alice

Start by assuming the role of Alice and make a change to the website home page. Replace the picture of Bob's cat with a picture of Alice's.

1. Change back to the *Alice* directory:

    ```bash
    cd ../Alice

    ```

1. If you didn't download the resources earlier, download the zip file that contains the [resources that accompany this lesson](https://github.com/MicrosoftDocs/mslearn-branch-merge-git/raw/main/git-resources.zip). Unzip the resource files:

    ```bash
    wget https://github.com/MicrosoftDocs/mslearn-branch-merge-git/raw/main/git-resources.zip
    unzip git-resources.zip

    ```

1. Move the *bombay-cat-180x240.jpg* file into Alice's *Assets* directory, and delete the other files:

    ```bash
    mv bombay-cat-180x240.jpg Assets/bombay-cat-180x240.jpg
    rm git-resources.zip
    rm bobcat2-317x240.jpg

    ```

1. Open the *index.html* file, and then replace this statement (which uses one of Bob's cat pictures):

    ```html
    <img src="Assets/bobcat2-317x240.jpg" />
    ```

    with this statement (which uses one of Alice's cat pictures):

    ```html
    <img class="cat" src="Assets/bombay-cat-180x240.jpg" />
    ```

1. Save the file and close the editor.

1. Now, run the following Git commands to push the changes to the project repo. First, we'll add the commits made in the *Assets* folder. Then, we'll switch back to the `main` branch, and run `git pull` to make sure nothing has changed. Finally, we'll merge the `add-cat` local branch into the `main` branch, and then push the changes to the repo.

    ```bash
    git add Assets
    git commit -a -m "Add picture of Alice's cat"
    git checkout main
    git pull
    git merge --ff-only add-cat
    git push

    ```

Finish by confirming that the push succeeded.

## Make a change as Bob

Without knowing what Alice is doing, Bob notices that Alice's last push added a CSS style named `cats` to the *site.css* file for the repo. So, Bob decides to apply that class to their cat picture.

1. Return to the *Bob* directory:

    ```bash
    cd ../Bob

    ```

1. Open the *index.html* file. Replace the statement that uses Bob's cat picture with the following statement that adds a `class="cat"` attribute to the `<img>` element:

    ```html
    <img class="cat" src="Assets/bobcat2-317x240.jpg" />
    ```

1. Save the file, and close the editor.

1. Now, run the following Git commands to sync the changes to the project repo like you did for the updates to Alice's repo. Commit the change, switch to the `main` branch, run `git pull`, and then merge the style change:

    ```bash
    git commit -a -m "Style Bob's cat"
    git checkout main
    git pull
    git merge style-cat

    ```

And there it is: *the dreaded merge conflict*. The same line in the same file was changed by two people. Git sees the conflict, and reports "Automatic merge failed." Git has no way of knowing whether the `src` attribute in the `<img>` element should reference the *bobcat2-317x240.jpg* file or the *bombay-cat-180x240.jpg* file.

```output
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```

The output from Git identifies the *index.html* file as the source of the conflict.

The question now is: What is Bob to do?

## Resolve the merge conflict

Bob has a few options at this point. Bob can take one of these actions:

- Run the `git merge --abort` command to restore the `main` branch to what it was before the attempted merge. Run the `git pull` command to get Alice's changes. Then, create a new branch, make their changes, and merge their branch into the `main` branch. Last, they push their changes.
- Run the `git reset --hard` command to get back to where they were before they started the merge.
- Resolve the conflict manually by using information that Git inserts into the affected files.

Developers seem to prefer the last option. When Git detects a conflict in content versions, it inserts *both* versions of the content into the file. Git uses special formatting to help you identify and resolve the conflict: left angle brackets `<<<<<<<`, double dashes (equal signs) `=======`, and right angle brackets `>>>>>>>`. The content above the line of dashes `=======` shows your changes in your branch. The content below the separator line shows the version of the content in the branch that you're trying to merge into.

Here's what the *index.html* file in Bob's repo looks like now. Notice the special formatting around the content with conflicts:

:::code language="html" source="../resources/bob-index.html" range="1-18" highlight="11,13,15":::

Let's resolve the merge conflict by editing the *index.html* file. Because this merge conflict is a quick fix, you'll make the change directly in the `main` branch, even though you're still in the *Bob* directory.

1. Open the *index.html* file, and then delete the special formatting lines. Don't remove any other statements. 

    ```html
    <<<<<<< HEAD
    =======
    >>>>>>> style-cat
    ```

1. Save the file, and close the editor.

    The *index.html* file now has two `<img>` elements: one for Bob's cat picture and one for Alice's.

    Some text editors feature Git integration and offer to help when they see text that indicates a merge conflict. If you open the *index.html* file in Visual Studio Code, you'll see the following code:

    :::image type="content" source="../media/resolve-conflict.png" alt-text="Screenshot that shows how to resolve merge conflicts in Visual Studio Code.":::

    If you select **Accept Both Changes**, the editor removes the lines around the `<img>` elements and leaves both elements intact.

1. Run the following commands to commit the change:

    ```bash
    git add index.html
    git commit -a -m "Style Bob's cat"

    ```

    The `git add` command tells Git that the conflict in the *index.html* file has been resolved.

1. Push the changes to the `main` branch on the remote:

    ```bash
    git push

    ```

1. Finish by syncing the changes into Alice's repo:

    ```bash
    cd ../Alice
    git pull

    ```

1. Finally, open Alice's *index.html* file and confirm that their version also has two `<img>` tags with cat pictures.
