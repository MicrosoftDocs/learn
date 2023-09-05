The functionality of the front-end app is complete but it isn't engaging visually. Let's fix that. 

## Design systems for front-end apps

A design system is a collection of reusable components, guided by clear standards that can be assembled together to build any number of applications. Design systems are used to create consistent, high-quality user experiences. 

A design system specifies the look and feel of an application, and the way that users interact with it. They also provide a common language for designers and developers to communicate with each other.

Design systems are made up of many parts, some of which are:

* **Design Principles**: Ideas that guide the design of the site.
* **Brand Values**: Ideas that guide the overall design to create specific emotions for users.
* **Brand Style Guide**: Rules and guidelines for using the brand's visual identity.
* **Content Guidelines**: Rules and guidelines for writing content for the site.
* **Accessibility Guidelines**: Rules and guidelines for making the site accessible to all users.
* **Component Library**: A collection of reusable components for building applications.
* **Pattern Library**: A collection of components organized in specific ways such as the navigation bars, footer, and forms.
* **Icon Library**: A collection of icons for use in the site.
* **Design Tokens**: Names that represent hard-coded values for visual elements like spacing, color, and typography.

## Common front-end design systems

There are many front-end design systems available. Here are some of the most popular:

* [Material Design](https://material.io/)
* [Fluent UI](https://developer.microsoft.com/fluentui/)
* [Bootstrap](https://getbootstrap.com/)
* [Chakra UI](https://chakra-ui.com/)

Headless design systems are design systems that don't have a framework. 

* [Tailwind CSS](https://tailwindcss.com/)
* [Ant Design](https://ant.design/)
* [Bulma](https://bulma.io/)
* [Foundation](https://get.foundation/)

## Select a design system

When selecting a design system, consider the following:

* **Features**: What features does the design system provide? Does it provide the features you need?
* **Customization**: How customizable is the design system? Can you change the look and feel of the site?
* **Accessibility**: How accessible is the design system? Does it provide accessibility features?
* **Community**: How large is the community around the design system? How active is the community?
* **Support**: How much support is available for the design system? Is there a support team? Is there a paid support option?
* **Cost**: How much does the design system cost? Is it free? Is it a one-time cost? Is it a subscription?

Technical considerations include:

* **Framework**: What framework does the design system support? Does it support the framework you're using?
* **Modular**: How modular is the design system? Can you use only the features you need? Can it be optimized for treeshaking (including only used components in built artifacts) so you don't import unnecessary code?
* **Browser Support**: What browsers does the design system support? Does it support the browsers you need to support?
* **Performance**: How does the design system affect the performance of the site? Does it affect the performance of the site?
* **Size**: How large is the design system? Does it add a lot of size to the site? 
* **Dependencies**: What dependencies does the design system have? Does it have dependencies that you don't want to use?


## Using a design system

A design system is specified in the application with a combination of features, which interact together to create the look and feel of the site. Some of the common features are Cascading Style Sheets (CSS) along with prebuilt components and topography.  

Once you select your design system, add the required npm packages. Many design systems have a default style, so you can add the packages and see the changes immediately. You can change the style by adding your own CSS at any time. 

This typically means adding class names to your HTML elements and/or renaming the HTML elements to use the system's components. 

| Element | Origin|
|--|--|
| `<button>` | HTML |
| `<Button>`<br>`<PrimaryButton>` | Design system |

### CSS Styles

A style is defined with CSS syntax. It can appear in a *.css file, be transpiled into a *.css file (such as with SASS), or be defined in a JavaScript file (such as with styled-components). Styled components are a way to use CSS in JavaScript and are a popular way to use CSS in React.

| Style syntax| Location|
|--|--|
| `max-height: 100px;` | CSS file |
| `max-height: 100px;` | JavaScript file inline|
| `maxHeight: '100px'` | JavaScript file styled-components |

Modern CSS includes pre and post processors to make CSS easier to write and maintain. 

* **Preprocessors** add syntax and tools to make CSS more efficient and concise, powerful, and dynamic. 
* **Postprocessors** apply automation and repetition to optimize the final css output. 

### Using CSS in JavaScript

Historically CSS (.css) and JavaScript (.js) were separated. CSS was applied to HTML and JavaScript operated on the HTML using a name or ID or other query selector. Modern changes to front-end development moved CSS closer with new front-end frameworks, or even into the same file (.jsx). This change comes with pros and cons to consider for your own team and projects.

Pros of CSS in JavaScript: 

* **Management and maintainability**: The two main elements of the visual presentation are in the same folder or file. This works well for teams where the design and code of the project are intertwined with either close collaboration of roles, or roles that function in both design and code.
* **Theme and Style consistency**: Managing the design elements within the source code and framework structure allow you to use the design elements consistently. 
* **Dynamic styling**: By moving the design into the code, the design can depend on the result of the code. This allows for more concise code but may be more challenging for junior developers to onboard to the team. 

Cons of CSS in JavaScript:

* **Onboarding and migration**: Learning how to properly use CSS in JavaScript, not only for development, but also building the project takes time and may require tooling not yet provided by the design system itself.
* **Delivery**: The final compiled artifacts are larger than just their equivalent .css files and JavaScript served separately. The use of CSS in JavaScript and generation of the final website must both be completed with an understanding of how to provided for tree-shaking. 
* **Performance**: Frameworks which allow you to use CSS in JavaScript have to manage the DOM in order to apply, update, or remove styles. Using the DOM comes at a cost to the client rendering speed. 

### Component composibility

Design system components usually include a few categories of components which allow you to compose your own reusable components or component families:

* **Organization** components used to layout components such as container, box, grid.
* **Presentation** components include: 
    * **Input** such as button, text box, and sliders
    * **Data** such as table, list
    * **Feedback** such as alert, notification, progress
    * **Surfaces** such as Card, Accordion
    * **Navigation** such as breadcrumbs, menu, pagination, tabs

Use these components to build site-wide headers, footers, navigation, and forms.

### Prebuilt Components 

A component is a reusable piece of code that can be used to build elements sharing functionality and styling. Components can be used to build other components, and they can be used to build entire applications. Common components are buttons, forms, and navigation bars.

:::image type="content" source="../media/material-ui-buttons.png" alt-text="Image shows nine different buttons in sets of three with different design elements.":::

### Typography

Typography is the style and appearance of text. It includes font size, font weight, font color, and font family. Three common web types of typographies are: 

* **Serif Fonts**: These fonts have small lines or flourishes at the ends of each letter stroke. Examples of serif fonts include Times New Roman, Georgia, and Baskerville.
* **Sans-serif Fonts**: These fonts do not have any small lines or flourishes at the ends of each letter stroke. Examples of sans-serif fonts include Arial, Helvetica, and Verdana.
* **Display Fonts**: These fonts are typically used for headlines or titles and are often more decorative or stylized than serif or sans-serif fonts. Examples of display fonts include Brush Script, Lobster, and Impact.

:::image type="content" source="../media/common-typography-fonts.png" alt-text="Image shows three examples of the fonts, one with flourishs, one without flourishs, and one with every bold text. ":::

Because typography impacts both the size of the downloads in the client application, and the load time of the application, you should consider how to optimize the application:

* **Flash of Invisible Text** (FOIT) where the text is hidden until the font is loaded. If a font has not been loaded (FOIT), browsers can delay text rendering. 
* **Flash of Unstyled Text** (FOUT) uses the fallback system font initially and then upgrades to the web font when it loads.



### Icons

Icons are images that represent an object or action. They're used to communicate information quickly and clearly. Icons are often used in navigation bars and buttons. Icons from design systems allow you to quickly select from a series of icons that are consistent with the design system. 

:::image type="content" source="../media/material-ui-help-icon.png" alt-text="Image shows eight different icons with a question. ":::

## Apply a design system to your React app

Design systems can provide either default themes or custom themes. Because a theme is meant to apply to the entire site, you add it at the top HTML element. In Reacht, this is typically in main.jsx or index.jsx. The following example uses Material UI to add a default theme to the app.

:::code language="javascript" source="../code/with-components-with-style/main.jsx" highlight="4-6, 12,13,15":::

## Apply a design system to your React component

Let's apply a design system component to an HTML button. Replace the `button` element with the design system `Button`.

Include the component in your component's page: 

```javascript
import Button from '@mui/material/Button';
```

**Find your HTML button**:

```jsx
<button onClick={incrementCounter}>Increment</button>
```

**Replace with the design system `Button`**:

```jsx
<Button onClick={incrementCounter}>Increment</Button>
```

The `Button`, with default styling, is on the left and the `button` is on the right:

:::image type="content" source="../media/button-comparison.png" alt-text="The left button is a default styled button with a design system, showing a blue background, shading, and default topography. The button on the right is the standard HTML button with black text and a grey background. ":::
