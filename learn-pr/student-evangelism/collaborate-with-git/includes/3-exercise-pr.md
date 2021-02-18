In the sandbox, make sure you’re still in the *Alice* directory, which is the top folder for Alice’s clone of the Cats repo. You can use the command `pwd` to verify your folder location.

```bash
pwd
```

Right now, there's nothing for Alice to pull because you haven't made any changes since she cloned the repo. You can prove that by using the following command, which responds `Already up-to-date`:

```bash
git pull
```

## Make a change and submit a pull request

Alice starts working on the website. Alice's first decision is to change the site's background color. Alice experiments locally, and ultimately chooses her favorite shade of light blue.

1. Set up an identity for Alice by running the following commands:

    ```bash
    git config user.name "Alice"
    git config user.email "alice@contoso.com"
    ```

    These `config` settings are stored in the repo in the *.git/config* file, so you won't have to enter them again. Each time you `cd` into the *Alice* directory, you effectively assume Alice's identity.

1. Open the *site.css* file in the *Alice/CSS* directory:

    ```bash
    code CSS/site.css
    ```

1. To change the background color of the page to light blue, replace the second line in the file with the following statement:

    ```css
    body { font-family: serif; background-color: #F0FFF8; }
    ```

1. Save and close the file.

1. Now, commit the change:

    ```bash
    git commit -a -m "Change background color to light blue"
    ```

1. Now, you must make a pull request back to the original repo:

    ```bash
    git request-pull -p origin/main .
    ```

1. You should see output similar to the following example:

    ```output
    The following changes since commit 2bf69ab0226d8d35efd1e92c83cd92c5cc09a7ae:

      Add simple HTML and stylesheet (2019-11-21 01:57:24 +0000)

    are available in the git repository at:

      .

    for you to fetch changes up to 95bbc3b6929953e9b04353920e97230b463022f0:

      Change background color to light blue (2019-11-21 02:33:48 +0000)

    ----------------------------------------------------------------
    Alice (1):
          Change background color to light blue

     CSS/site.css | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)

    diff --git a/CSS/site.css b/CSS/site.css
    index caefc86..86d41e8 100644
    --- a/CSS/site.css
    +++ b/CSS/site.css
    @@ -1,2 +1,2 @@
     h1, h2, h3, h4, h5, h6 { font-family: sans-serif; }
    -body { font-family: serif; }
    \ No newline at end of file
    +body { font-family: serif; background-color: #F0FFF8; }
    \ No newline at end of file
    ```

## Create a remote and complete the pull request

Because your project directory and the *Alice* directory are on the same computer, you can pull directly from the *Alice* directory. In real life, the *Alice* directory would be on Alice's computer. You solve this situation by setting up a *remote* by using the `git remote` command, and then use that remote for pull and push requests. Because it's not practical to set up two machines to do these steps, we'll set up a remote that uses a local path name. In reality, you would use a network path or URL instead.

1. Change back to the project directory (`cd`) and use the `git remote` command to create a remote named `remote-alice` that targets Alice's project directory:

    ```bash
    cd ../Cats
    git remote add remote-alice ../Alice
    ```

1. Now, execute a pull:

    ```bash
    git pull remote-alice main
    ```

    Notice that you have to specify a branch, `main`, in the pull command. You will learn in the next lesson how to set up an upstream URL for the branch.

1. You should see an output like this example, showing that you successfully completed the pull request:

    ```output
    remote: Counting objects: 4, done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 4 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (4/4), done.
    From ../Alice
     * branch            main     -> FETCH_HEAD
     * [new branch]      main     -> remote-alice/main
    Updating 2bf69ab..95bbc3b
    Fast-forward
     CSS/site.css | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    ```

The fun is just beginning! In the next lesson, you learn how to set up and use a shared repository, which makes collaborating simpler and more convenient.
