To practice the work of Alice cloning a repo and making a pull request, we must first set up a repo for Alice to clone.

## Setup

Git is already installed for us in Azure Cloud Shell, so we can use Git in Cloud Shell to the right.

1. At the top right of the Cloud Shell window select the **More** icon (**...**), then select **Settings** > **Go to Classic version**.

1. Use the `mkdir` command to create a folder named *Cats*:

    ```bash
    mkdir Cats

    ```

1. Use the `cd` command to change to the project folder:

    ```bash
    cd Cats

    ```

1. Now, initialize the new repository and set the name of the default branch to `main`.

    If you're running Git version 2.28.0 or later, use the following commands:

    ```bash
    git init --initial-branch=main
    git init -b main

    ```

    For earlier versions of Git, use these commands:

    ```bash
    git init
    git checkout -b main

    ```

1. Configure Git by adding your credentials. Replace `<USER_NAME>` and `<USER_EMAIL>` with your own information (for example, "User Name" and "user-name@contoso.com").

    ```bash
    git config user.name "<USER_NAME>"
    git config user.email "<USER_EMAIL>"

    ```

1. Create some files by using the `touch` command, and then stage and commit the files by using Git:

    ```bash
    touch index.html
    mkdir CSS
    touch CSS/site.css
    git add .
    git commit -m "Create empty index.html, site.css files"

    ```

1. Add some HTML to your *index.html* file by using the Cloud Shell code editor, which you can open by using the `code` command at the terminal prompt:

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

1. Save the file and close the editor. You can select the ellipsis (**...**) in the right corner of the editor, or use the accelerator key (**Ctrl+S** on Windows and Linux, **Cmd+S** on macOS).

1. Change to the *CSS* directory and open *site.css* in the editor:

    ```bash
    cd CSS
    code site.css

    ```

1. Add the following CSS to *site.css*:

    ```css
    h1, h2, h3, h4, h5, h6 { font-family: sans-serif; }
    body { font-family: serif; }
    ```

    Then, save the file and close the editor.

1. Go back to the *Cats* directory.

    ```bash
    cd ..

    ```

1. Finally, commit your changes again:

    ```bash
    git add .
    git commit -m "Add simple HTML and stylesheet"

    ```

1. Quickly check your Git log to make sure everything looks good:

    ```bash
    git log --oneline

    ```

1. Check the output. You should see output like this example:

    ```output
    2bf69ab Add simple HTML and stylesheet
    bb371c8 Create empty index.html, site.css files
    ```

## Clone a repository

Now, let's assume the role of Alice and practice cloning a repository to collaborate on.

To simulate Alice cloning your repo onto their computer, you'll create a directory named *Alice* on your computer and clone your project directory into it. In real life, you would accomplish this collaboration by setting up a network share or a remote that's reachable by URL.

1. Create a directory named *Alice* to clone the repo into. It must *not* be a subdirectory of your project directory (*Cats*), so `cd` up again to the parent directory from your project directory to make *Alice* a sibling of the project directory. Then, `cd` into the *Alice* directory.

    ```bash
    cd ..
    mkdir Alice
    cd Alice

    ```

1. Now, use `git clone` to clone the repo that's in your project directory into the *Alice* directory. Be sure to include the period at the end of the command:

    ```bash
    git clone ../Cats .

    ```

    `../Cats` tells Git where to clone from and `.` tells Git where to clone to. In Unix, `.` refers to your current directory.

1. Check the output. Git should display this text to let you know that it worked:

    ```output
    Cloning into '.'...
    done.
    ```

A clone of the repo that's in your project directory is now in your *Alice* directory!
