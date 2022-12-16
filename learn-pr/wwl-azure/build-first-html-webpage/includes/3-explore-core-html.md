Hypertext Markup Language, or HTML, is the core language used to create a web page. HTML is used to describe the information to display to the user. HTML tells a browser how to display text.

> [!NOTE]
> The word hypertext comes from having text on a page that when clicked or tapped brings the user to another page - links or hyperlinks.

## Introducing Tags and Elements

If you've ever had to format text like make it bold or enlarge the font, you may not have thought about what goes on "behind the scenes."

When you experience text on a web page, the browser does the work to format it using code. HTML code is behind what is displayed. The code tells the browser what to do to make the text appear the way it does.

As we learned in an earlier unit, when a web page has **bolded text**, the HTML code words that tell the browser to make the text bold are called **tags**. Tags surround the text that needs to be displayed in a specific way or *transformed*. Tags typically have a start and an end, with text between them.

A tag and any content between the open and close is called an **element**

- This is an open tag to make something bold: `<strong>`
- This is a closing tag to make something bold: `</strong>`
- This is an element: `<strong> Make me bold </strong>`

> [!IMPORTANT] 
> You will often hear developers use the terms tag and element interchangeably. While they do technically mean different things, in most conversation, the slight difference in meaning isn't important.

Headers are common elements that are numbered one through six, with one being the top of the hierarchy and six being the lowest. These are written as `h1` through `h6`. If you want to add a top-level heading to a page to display the word **Resume**, you could use:

```html
<h1>Resume</h1>
```

The following video demonstrates how HTML gets transformed by browsers into formatted information.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RE5d5qK]

## Learning How to Use Tags

There are many tags available for programmers to use. Knowing which ones are available and how they're used is called **syntax**. At this point, we won't get bogged down in the details. What's important is that you understand what a tag is and how it's used to make up an element.
