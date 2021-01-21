To practice Alice cloning a repo and making a pull request, we must first set up a repo for Alice to clone.

## Setup

Git is already installed for us in Azure Cloud Shell, so we can use Git in Cloud Shell to the right.

1. Create a folder named "Cats" by typing `mkdir Cats`.

    ```bash
    mkdir Cats
    ```

1. `cd` to the project folder:

    ```bash
    cd Cats
    ```

1. Then execute a `git init` command to initialize the repository:

    ```bash
    git init
    ```

1. Configure Git by adding your credentials, replacing `<USER_NAME>` and `<USER_EMAIL>` with your own information (for example, "Shana" and "shana@email.com")

    ```bash
    git config user.name "<USER_NAME>"
    git config user.email "<USER_EMAIL>"
    ```

1. Create some files with the Linux `touch` command, then stage them and commit using Git:

    ```bash
    touch index.html
    mkdir CSS
    touch CSS/site.css
    git add .
    git commit -m "Create empty index.html, site.css files"
    ```

1. Now add some HTML to your file using Cloud Shell's code editor, which you can open with the `code` command. Open **index.html** in the online editor by typing `code index.html` at the terminal prompt:

    ```bash
    code index.html
    ```

1. Paste in this HTML code:

    ```html
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset='UTF-8'>
        <title>Our Feline Friends</title>
        <link rel="stylesheet" href="CSS/site.css">
      </head>
      <body>
        <h1>Our Feline Friends</h1>
        <p>Eventually we will put cat pictures here.</p>
        <hr>
      </body>
    </html>
    ```

1. Save and close the file. You can click the ellipse "..." in the right corner of the cloud editor, or use the accelerator key (Ctrl+S on Windows and Linux, Cmd+S on macOS).

1. Change directories to the **CSS** directory and open **site.css** in the editor:

    ```bash
    cd CSS
    code site.css
    ```

1. Add the following CSS to it:

    ```css
    h1, h2, h3, h4, h5, h6 { font-family: sans-serif; }
    body { font-family: serif; }
    ```

1. Save and close the file. Navigate back up to the **Cats** directory.

    ```bash
    cd ..
    ```

1. Finally, commit our changes again:

    ```bash
    git add .
    git commit -m "Add simple HTML and stylesheet"
    ```

1. Quickly check our Git log to make sure everything looks good:

    ```bash
    git log --oneline
    ```

1. You should see an output like:

    ```output
    2bf69ab Add simple HTML and stylesheet
    bb371c8 Create empty index.html, site.css files
    ```

## Clone a repository

Now, let's pretend we're Alice and practice cloning a repository to collaborate on.

To simulate Alice cloning your repo onto her computer, you'll create a directory named "Alice" on your computer and clone your project directory into there. In real life, you would accomplish this collaboration by setting up a network share or a remote reachable by URL.

1. Create a directory named "Alice" to clone the repo into. It must *not* be a subdirectory of your project directory (**Cats**), so `cd` up again to the parent directory from your project directory to make "Alice" a sibling of the project directory. Then `cd` into the "Alice" directory:

    ```bash
    cd ..
    mkdir Alice
    cd Alice
    ```

1. Now use `git clone` to clone the repo in your project directory into the "Alice" directory, and be sure to include the period at the end of the command:

    ```bash
    git clone ../Cats .
    ```

    `../Cats` tells Git where to clone from and `.` tells Git where to clone to. In Unix, `.` refers to your current directory.

1. Git should output this text to let you know it worked:

    ```output
    Cloning into '.'...
    done.
    ```

A clone of the repo in your project directory now lives in your "Alice" directory!
