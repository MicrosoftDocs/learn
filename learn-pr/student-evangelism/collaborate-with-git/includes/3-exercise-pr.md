Right now there's nothing for Alice to pull because you haven't made any changes since she cloned the repo.

1. You can prove that with the following command, which responds `Already up-to-date`:

    ```bash
    git pull
    ```

## Make a change and submit a pull request

Alice starts working on the Web site. Her first decision is to change the site's background color. She experiments locally, and ultimately chooses her favorite shade of light blue.

1. Assume Alice's identity by executing the following commands:

    ```bash
    git config user.name Alice
    git config user.email alice@contoso.com
    ```

    These config settings are stored in the repo in **.git/config**, so you won't have to enter them again. Each time you `cd` into the "Alice" directory, you effectively assume Alice's identity.

1. Open **site.css** in the "Alice/CSS" directory:

    ```bash
    code CSS/site.css
    ```

1. Replace the second line in the file with this one to change the background color of the page to light blue:

    ```css
    body { font-family: serif; background-color: #F0FFF8; }
    ```

1. Save and close the file.

1. Now commit the change:

    ```bash
    git commit -a -m "Change background color to light blue"
    ```

1. Now, you must make a  pull request back to the original repo:

    ```bash
    git request-pull -p origin/master .
    ```

1. You should see an output like:

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

Because your project directory and the "Alice" directory are on the same computer, you can pull directly from the "Alice" directory. In real life, the "Alice" directory will be on Alice's computer. You solve this by setting up a *remote* using the `git remote` command and using that remote for pulls and pull requests. Since it's not practical to set up two machines to do this, we'll set up a remote that uses a local path name. In reality, you would use a network path or URL instead.

1. `cd` back to the project directory and use a `git remote` command to create a remote named "alice" that targets Alice's project directory:

    ```bash
    cd ../Cats
    git remote add alice ../Alice
    ```

1. Now execute a pull:

    ```bash
    git pull alice master
    ```

    Notice that you have to specify a branch, "master," in the pull command. You will learn in the next lesson how to fix that by setting an upstream URL.

1. You should see an output like this indicating success:

    ```output
    remote: Counting objects: 4, done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 4 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (4/4), done.
    From ../Alice
     * branch            master     -> FETCH_HEAD
     * [new branch]      master     -> alice/master
    Updating 2bf69ab..95bbc3b
    Fast-forward
     CSS/site.css | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    ```

The fun is just beginning! In the next lesson, you learn how to set up and use a shared repository, which makes collaborating simpler and more convenient.
