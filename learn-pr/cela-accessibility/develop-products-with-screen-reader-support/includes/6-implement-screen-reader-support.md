There are three general approaches to implementing accessibility.

- Semantic (intrinsic) controls
- Custom controls
- Alternate controls

Let's elaborate on each of these approaches.

## Semantic (intrinsic) controls

First, use semantic controls and let the foundation handle most of the work for you. Intrinsic controls are built-in HTML elements like buttons, links, and form fields that come with inherent accessibility features. For example, using a **\<button>** tag instead of a styled **\<div>** ensures that the button is accessible by default, with the name coming from the tag contents and the role being "button." Here are some considerations for common intrinsic controls:

### Static text (\<span>)

Ensure that static text is meaningful and provides context. In this example of static text in HTML, the name is the content of the tag, and the role is text. 

```
<span>Office privacy settings give you control over your experience and data.</span>

Name   Office privacy settings give you control over your experience and data.
Role     text
```

### Image (\<img>)

For an image, use the **\<img>** tag. In the example, the name comes from the **alt** attribute, and the role is image. Use the **alt** attribute to provide a text alternative for images.


```
<img src="SmartArt2.png" alt="Alternating Hexagons">

Name   Alternating Hexagons
Role     image
```

### Button (\<button>)

For a button, use the **\<button>** tag or input **type=button**. This is much better than using a division and adding styling and event handlers to make it look and act like a button. Use a button to tag and style it the way you want to use CSS. Ensure buttons have descriptive text to convey their purpose. In the example, the name comes from the tag contents, and the role is button. 

```
<button>End Session</button> 

Name   End Session
Role     button
```

### Link (\<a>)

To create a link, use the **\<a>** tag instead of a **\<span>** with styling and event handlers. In the example, the name of the link comes from the content within the tag, and its role is link. Links also have a value, which is the URL specified in the **href** attribute. Use descriptive link text to indicate the link's destination. Generally, it's not advisable to use the URL as the link's name or display text because URLs can be long and may not clearly indicate the link's purpose. Avoid using empty links; if a link has no content, it's better to use a button instead.


```
<a href=”https://support.microsoft.com/en-us/office/6f7772b2-2f33-4bd2-8ca7-dae3b2b3ef25”>Learn more about accessibility in PowerPoint</a>

Name   Learn more about accessibility in PowerPoint
Role     Link
Value   https://support.microsoft.com/en-us/office/6f7772b2-2f33-4bd2-8ca7-dae3b2b3ef25
```

In Windows Narrator, some additional information about an element isn't read even at the highest verbosity level. This includes the URL for a hyperlink, which is part of this additional information. By default, this setting is off, so the URL isn't read. However, after turning on the setting, the URL will be read. This setting also controls the reading of descriptions and help text.

### Checkbox (\<input type="checkbox">)

For checkboxes, use **\<input type="checkbox">** and use a label tag for the label. In the example, the name comes from the content of the label tag, and the role comes from the type attribute. Each input type has its own role, such as radio, text, etc. The checkbox also has a value. It comes from the checked attribute. 


```
<label for=”checkboxId”>Always Use Subtitles</label>
<input type=”checkbox” id=”checkboxId” checked>


Name   Always Use Subtitles
Role     checkbox
Value   ToggleState_On
```

## Custom controls

If semantic/intrinsic controls don't meet your needs, you may need to implement custom controls. Many web developers have learned that they can add styling and event handlers to a **\<div>** to make it look and act the way they want, creating custom controls in this way. However, additional work is needed to make these custom controls accessible. They must be operable with both the keyboard and the mouse, and semantic information must be exposed to properly represent them in the accessibility tree.

Screen reader users use the control type to determine how to interact with a specific control. Custom controls should only be used as a last resort and if the control type isn't mappable to existing known controls, help text, or other information should be provided to guide keyboard users on how to interact with the control.

In 2014, the W3C published the Accessible Rich Internet Applications (ARIA) standard, which allows web developers to provide the necessary semantics for accessible custom controls. For example, if you have an SVG graphic that you want to serve as a toggle button, you can add an **aria-label** attribute to specify a name and **role="button"** to define its role in the accessibility tree. Additionally, you can use the **aria-pressed** attribute to specify the toggle state. <br>


```
<svg role=”button” aria-label=”Bullets” aria-pressed=”true”
	tabindex=”0” xmlns=”http://www.w3.org/2000/svg” width=”32”
	height=”32” viewBox=”0,0,2048,2048”>
		<!-- paths -->
	</svg>

Name    Bullets
Role      button
Value    ToggleState_On
```

### Resources

- [ARIA and UI automation in Microsoft Edge](/microsoft-edge/accessibility/build/aria-and-ui-automation) 
- [WAI-ARIA Overview](https://www.w3.org/WAI/standards-guidelines/aria/) 
- [ARIA Authoring Practices Guide](https://www.w3.org/WAI/ARIA/apg/) 

## Alternate controls

In rare cases, you might need to create an alternate representation, but this should be a last resort. This involves creating separate elements for what is rendered on the page versus what is exposed in the accessibility tree for screen readers. For example, you might use** aria-hidden="true"** to hide an element from the accessibility tree while still displaying it on the page.

```
<!- - visible on page, but not to screen reader  - - >
<div aria-hidden=”true”>
</div>

<!- - visible to screen reader, but not on page  - - >
,div class=”srOnly” role=”menu” aria-label=”More options”>
</div>
```

Always strive to create a harmonious experience between the rendered content and the screen reader experience, as some screen reader users have some sight and use it together with the screen reader, or seek assistance from sighted colleagues occasionally.

To make an element not visible on the page but still included in the accessibility tree, you can use CSS techniques like positioning the element off-screen or clipping it. However, using **display: none** or **visibility: hidden** won't work, as browsers exclude these elements from the accessibility tree. It's important to properly specify the name, role, and value of elements to ensure they're accessible. 

### Name

The name can be defined using attributes like **aria-labelledby**, **aria-label**, the content of a **\<label>** tag, or the **alt** attribute if it's an **\<img>** or **input type="image"**. You can also use the content of the tag, the **title** attribute, the **aria-describedby** attribute, or the **aria-description** attribute. The last three are fallback options if none of the others are specified. This gives the priority order for calculating the name.

- A good name for an element should ideally use the visible label. For example, a spin control for setting the height of a row in a table should use "table row height" rather than just "height" to provide more context. 
- Always include the visible label in the name to ensure consistency between the screen and the screen reader. 
- Avoid including the control type (like "spin control") in the name, as this is expressed in the role. 
- Keep names short to maintain efficiency for screen reader users and expose the range of allowed values in other properties.
- For images, avoid using irrelevant details in the alt text. Instead, provide contextually relevant descriptions, like "Person presenting at a podium with captions on the screen." 
- If an image isn't important to the understanding of the content, use **alt=""** to exclude it from the accessibility tree, but never omit the alt attribute entirely. 

### Role

The role of an element is determined by the **role** attribute if specified. It's determined by the **type** attribute if it isn't specified and you're using an **\<input>** tag. For other types of tags (**\<img>, \<a>, \<button>**, etc.), it's determined by the type of tag. 

### Value

The value refers to properties like **aria-checked**, **aria-pressed**, **aria-expanded**, **aria-selected**, and **aria-disabled**, depending on the control type. For **\<input>** tags, the checked or disabled attribute is used, and for links using **\<a>** tag, the **href** attribute is used.

Properly defining these properties ensures that assistive technologies can accurately interpret and interact with the elements.

### Resource

[CSS in Action: Invisible Content Just for Screen Reader Users](https://webaim.org/techniques/css/invisiblecontent/) 

## Specifying language

To ensure our apps are accessible to users worldwide, we localize them in multiple languages. This includes localizing all names exposed to the screen reader, which should be fetched from localized resources. Screen readers can read text in various languages, but the app must specify the language of each element using the **lang** attribute. Set the language for the entire page using the **lang** attribute of the HTML tag. Then, specify the language for individual elements where the language differs from the parent. This ensures that screen readers pronounce text correctly. Since the **lang** is inherited from the parent, you only need to do this on tags where you're using a different language than the parent. So, if the whole user experience is in the same language, you only need to specify it once in the HTML tag. 

```
<p lang="en-us">This is English text</p>
<p lang="fr-fr">C'est Français texte</p>
<p lang="zh-cn">&#36825;&#26159;&#20013;&#25991;&#30430;</p>

Specify the lang attribute on the <html> tag
Specify the lang attribute on any tag that uses a different language than its parent
Narrator reads the text in each language properly
If lang attribute is specified
And Text-to-Speech is installed for that language
```

Two (2) things need to be in place for Narrator to read the text in the proper language: the **lang** attribute and the user must install text-to-speech for those languages. Typically, they would have done that for the languages that they work with, but when you test these scenarios, make sure you install text-to-speech for those languages first. Properly specifying the language helps screen readers provide accurate and efficient navigation for users.