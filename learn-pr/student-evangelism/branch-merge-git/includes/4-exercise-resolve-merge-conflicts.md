Sometimes, no matter how well you plan, things go wrong. Imagine that two developers are working on the same file at the same time and change the same line. When they push their changes, the second one will experience a *merge conflict*. Developers using version control dread few things more than merge conflicts. But conflicts happen, and you *must* know how to deal with them.

The good news is that Git provides solutions for dealing with merge conflicts.

## Create branches for Bob and Alice

Let's begin by creating a branch for Bob and a branch for Alice. Both are working at the same time, although neither is aware of it.

1. Navigate to the "Alice" directory and create a branch named "add-cat" for Alice to work in:

    ```bash
    cd ../Alice
    git checkout -b add-cat
    ```

1. Return to "Bob" and create a branch named "style-cat" for Bob to work in:

    ```bash
    cd ../Bob
    git checkout -b style-cat
    ```

Now let's make some changes in the branches.

## Make a change as Alice

Let's assume Alice's role again and make a change to the Web site's home page by replacing the picture of Bob's cat with a picture of Alice's.

1. Navigate back to the "Alice" directory:

    ```bash
    cd ../Alice
    ```

1. If you didn't download the resources previously, download the zip file containing the [resources that accompany this lesson](https://topcs.blob.core.windows.net/public/git-resources.zip), and then unzip them with these commands:

    ```bash
    wget https://topcs.blob.core.windows.net/public/git-resources.zip
    unzip git-resources.zip
    ```

1. Copy **bombay-cat-180x240.jpg** into Alice's **Assets** directory, deleting the other files:

    ```bash
    mv bombay-cat-180x240.jpg Assets/bombay-cat-180x240.jpg
    rm git-resources.zip
    rm bobcat2-317x240.jpg
    ```

1. Then open **index.html** and replace this line:

    ```html
    <img src="Assets/bobcat2-317x240.jpg" />
    ```

    With this one:

    ```html
    <img class="cat" src="Assets/bombay-cat-180x240.jpg" />
    ```

    Then save and close the file.

1. Now commit the changes, switch back to "master," do a pull to make sure nothing has changed, merge the "add-cat" branch into "master," and push:

    ```bash
    git add Assets
    git commit -a -m "Add picture of Alice's cat"
    git checkout master
    git pull
    git merge --ff-only add-cat
    git push
    ```

Finish up by confirming that the push succeeded.

## Make a change as Bob

Without knowing what Alice is doing, Bob notices that Alice's last push added a CSS style named `cats` to **site.css**. So Bob decides to apply that class to his cat picture.

1. Return to the "Bob" directory:

    ```bash
    cd ../Bob
    ```

1. Open **index.html**, add a `class="cat"` attribute to the `<img>` element, and save the file:

    ```html
    <img class="cat" src="Assets/bobcat2-317x240.jpg" />
    ```

1. Now commit the change, switch back to "master," do a pull, and merge:

    ```bash
    git commit -a -m "Style Bob's cat"
    git checkout master
    git pull
    git merge style-cat
    ```

    And there it is: the dreaded merge conflict. The same line in the same file was changed by two people. Git sees that and reports "Automatic merge failed." Git has no way of knowing whether the `src` attribute in the `<img>` element should reference **bobcat2-317x240.jpg** or **bombay-cat-180x240.jpg**:

    ```output
    Auto-merging index.html
    CONFLICT (content): Merge conflict in index.html
    Automatic merge failed; fix conflicts and then commit the result.
    ```

The output identifies **index.html** as the source of the conflict. The question now is: What's Bob to do?

## Resolve the merge conflict

Bob has a few options at this point. One is to use `git merge --abort` to restore "master" to what it was before the attempted merge. Bob could then do a pull to get Alice's changes, create a new branch, make his changes, merge the branch into "master," and push his changes. Bob could also use `git reset --hard` to get back to where they were.

The preferred option in many cases is to resolve the conflict using information Git inserted into the affected files. When Git detects a conflict in a file, it inserts *both* conflicting versions into the file between lines starting with `<<<<<<<`, `=======`, and `>>>>>>>`.  

The part before the `=======` line is "your" side of the merge — the branch you were already on — and the part after is "their" side: the branch you specified in the `merge` command.

In this case, **index.html** in Bob's repo looks like this:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset='UTF-8'>
    <title>Our Feline Friends</title>
    <link rel="stylesheet" href="CSS/site.css">
  </head>
  <body>
    <nav><a href="./index.html">home</a></nav>
    <h1>Our Feline Friends</h1>
    <img class="cat" src="Assets/bombay-cat-180x240.jpg">
    <footer><hr>Copyright (c) 2019 Contoso Cats</footer>
  </body>
</html>
```

Knowing this, let's resolve the merge by editing **index.html**. Because this is a quick fix, you will make the change directly in the "master" branch.

1. Open **index.html**, delete these three lines, and then save and close the file:

    ```html
    <<<<<<< HEAD
    =======
    >>>>>>> style-cat
    ```

    **index.html** now has two `<img>` elements: one for Bob's cat and one for Alice's.

    As an aside, some text editors feature Git integration and offer to help when they see text representing merge conflicts. For example, if you open **index.html** in Visual Studio Code, you'll see this:

    ![Resolving merge conflicts in Visual Studio Code](../media/resolve-conflict.png)

    _Resolving merge conflicts in Visual Studio Code_

    Clicking **Accept Both Changes** removes the lines around the `<img>` elements and leaves both elements intact.

1. Now commit the change:

    ```bash
    git add index.html
    git commit -a -m "Style Bob's cat"
    ```

    The `git add` command tells Git that the conflict in **index.html** has been resolved.

1. Push the changes to "master" on the remote:

    ```bash
    git push
    ```

Finish up by switching back to Alice, doing a `git pull`, opening Alice's **index.html**, and confirming that Alice sees two cats image tags, too.
