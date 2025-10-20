In the prior exercise, you applied style to elements such as `html` and `h1`. You frequently need to be a little narrower in applying style.

In this exercise, you set the style for the social media and experience sections and links on the page.

## Applying style to classes and IDs

You start by setting the style for the social media and experience sections.

1. Return to the vscode.dev window you used in the previous exercise.
2. Inside **index.html**, notice the `section` element with the ID of **social-media** at line 10; you apply style to this section to set the color to blue.
3. At the end of **style.css**, add the following CSS to set the color for the **social-media** element:

    ```css
    #social-media {
        color: blue;
    }
    ```

4. The page updates, setting the content in the social media section to blue.
5. Inside **index.html**, notice the two sections at lines 28 and 32 with the class **experience**; you apply style to these sections to italicize the font.
6. At the end of **style.css**, add the following CSS to modify the font for the elements with the **experience** class:

    ```css
    .experience {
        font-style: italic;
    }
    ```

7. The page updates, setting the font inside experience to italicized.

## Using pseudo-classes to set link style

Many web developers change the color and style of hyperlinks on a page. You set the color for links to be green and highlight links when a user hovers over them.

1. At the end of **style.css**, add the following CSS to set links to always be green:

    ```css
    a:visited {
        color: green;
    }

    a:link {
        color: green;
    }
    ```

2. The page updates to show links as green.
3. Add the following CSS to the end of **style.css** to highlight links as they're being hovered over:

    ```css
    a:hover {
        background-color: yellow;
    }
    ```

4. Hover over the links on the page and notice the links are highlighted.

## Review

The following screenshot shows the results of the CSS you applied. You used classes, IDs, and pseudo-classes to apply styles to specific elements and logical groups of elements.

:::image type="content" source="../media/selectors-final.png" alt-text="Screenshot of browser render of the C S S applied to the H T M L code.":::
