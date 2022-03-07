While Alice is working on CSS for the website, Bob is working away at home, blissfully unaware of the work Alice is doing. This arrangement is just fine because they're both using branches! Bob decides to make some changes of their own.

## Create a branch for Bob

1. Return to the *Bob* directory, and run the following command to create a branch named `add-cat`. Use the popular `checkout -b` option to create the branch and switch to it in a single command.

    ```bash
    cd ../Bob
    git checkout -b add-cat

    ```

1. Download the zip file that contains [some website resources](https://github.com/MicrosoftDocs/mslearn-branch-merge-git/raw/main/git-resources.zip). Then, unzip the resource files:

    ```bash
    wget https://github.com/MicrosoftDocs/mslearn-branch-merge-git/raw/main/git-resources.zip
    unzip git-resources.zip

    ```

1. Now, move the *bobcat2-317x240.jpg* file into Bob's *Assets* directory. Delete the other files. You'll download the files and use them again later.

    ```bash
    mv bobcat2-317x240.jpg Assets/bobcat2-317x240.jpg
    rm git-resources.zip
    rm bombay-cat-180x240.jpg

    ```

1. Next, open the *index.html* file and replace the line that says "Eventually we will put cat pictures here" with the following line:

    ```html
    <img src="Assets/bobcat2-317x240.jpg" />
    ```

1. Save the file, and close the editor.

1. You've made two changes to Bob's `add-cat` branch &mdash; you added one file and modified another. Run `git status` to double-check your changes:

    ```bash
    git status

    ```

1. Then, run the following commands to add the new file in the *Assets* directory to the index and commit all changes:

    ```bash
    git add .
    git commit -a -m "Add picture of Bob's cat"

    ```

1. Bob now does the same action that Alice did earlier. Bob switches back to the `main` branch, and executes a pull to see if anything has changed:

    ```bash
    git checkout main
    git pull

    ```

1. Check the output. This time, the output indicates that changes *have* been made to the `main` branch in the shared repo (the result of Alice's push). It also indicates that the changes pulled from `main` in the shared repo have been merged with `main` in Bob's repo:

    ```output
    remote: Counting objects: 4, done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 4 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (4/4), done.
    From D:/Labs/Git/Bob/../Shared
       e81ae09..1d2bfea  main     -> origin/main
    Updating e81ae09..1d2bfea
    Fast-forward
     Assets/site.css | 3 ++-
     1 file changed, 2 insertions(+), 1 deletion(-)
    ```

1. Next, Bob merges their branch into the `main` branch so that `main` in their repo will have their changes *and* Alice's changes. Then, Bob pushes `main` on their computer to the `main` branch in the shared repo:

    ```bash
    git merge add-cat --no-edit
    git push

    ```

Bob didn't use the `--ff-only` flag because they knew that `main` had changed. A fast-forward only merge would have failed.

## Sync the repos

At this point, Bob has an up-to-date repo, but Alice doesn't. Alice needs to do a `git pull` from the shared repo to make sure they have the latest and greatest version of the site.

Run the following commands to sync Alice's repo with the shared repo:

```bash
cd ../Alice
git pull

```

Take a moment to verify that Alice's repo and Bob's repo are synced. Each of the repos should have a JPG file in the *Assets* directory, and an `<img>` element declared in the *index.html* file. The *site.css* file in each repo's *Assets* folder should contain a line that defines a CSS style named *cat*. This style was added by Alice when they made their changes.

If you open *index.html* in a browser, you'll see this image:

:::image type="content" source="../media/first-cat.png" alt-text="Screenshot that shows cats on the website.":::

In the next lesson, you'll learn how to resolve merge conflicts, which occur when changes made by two or more developers overlap.
