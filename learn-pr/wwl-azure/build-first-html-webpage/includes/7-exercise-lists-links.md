In this exercise, you'll add the rest of the information to your resume. You'll include your email address, social media links, and list of experience. The exercise will use generic text, but you should feel free to customize the content to match your details.

## Add Your Email Address and Social Media

Let's start by adding your email address and social media links to your resume.

1. Return to the browser window with vscode.dev.

>[!NOTE]
>If you closed your browser or CodeSwing, follow these steps to reopen your CodeSwing project.
>1. Open [vscode.dev](https://vscode.dev). If you already have your html file open and just need to reopen CodeSwing, skip to step 6.
>1. Select **Open Folder**.
>1. Navigate to the **resume** folder you created earlier and select **Select Folder**.
>1. When prompted to **Let site view files**, select **View Files**.
>1. In the Explorer pane on the left, select the **index.html** file.
>1. Press Ctrl + Shift + P on Windows or Linux or Cmd + Shift + P on Mac.
>1. In the box that appears at the top, type **codeswing: open swing** and press enter or return on your keyboard.
>1. When prompted, select the **resume** folder you selected earlier.

2. Inside **index.html**, and below the comment that reads `<!-- email address -->`, add the following HTML to add a link to your email, replacing **your-email@example.com** with your email address:

    ```html
    <a href="mailto:your-email@example.com">your-email@example.com</a>
    ```

3. The page automatically updates with your email address.
4. Below the comment that reads `<!-- social media -->`, add the following HTML to create the list:

    ```html
    <ul>
        <li><a href="https://github.com/microsoft>">GitHub</a></li>
        <li><a href="https://www.linkedin.com/company/microsoft>">LinkedIn</a></li>
        <li><a href="https://twitter.com/microsoft>">Twitter</a></li>
    </ul>
    ```

5. The page will update to display the list of social media accounts you add.

## Adding Education and Experience

With the contact information added, you'll now finish adding to your resume by including education and other experience.

1. Inside **index.html**, below the comment that reads `<!-- education -->`, add the following HTML for your education information:

    ```html
    <h3>School name</h3>
    <h4>Major</h4>
    <ul>
        <li>GPA: 4.0</li>
        <li>Years attended</li>
    </ul>
    ```

1. Below the comment that reads `<!-- experience -->`, add the following HTML for your experience:

    ```html
    <h3>Company name</h3>
    <h4>Title</h4>
    <h4>Dates</h4>
    <ul>
        <li>Cool accomplishment</li>
        <li>Cool accomplishment</li>
    </ul>

    <h3>Cool hackathon</h3>
    <h4>Project title</h4>
    <h4>Dates</h4>
    <ul>
        <li>Cool accomplishment</li>
        <li>Cool accomplishment</li>
    </ul>
    ```

1. The window updates with your new information.
