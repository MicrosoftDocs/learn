Let's explore how you can use code suggestions from GitHub Copilot. In this exercise, you add animations with live suggestions and use a prompt to customize scroll behavior from an already existing JavaScript template repository. With GitHub Copilot, you can quickly work with a real-life JavaScript situation.

## JavaScript portfolio

Whether you're a student, recent graduate, or an experienced professional, your portfolio is your personal space to showcase your skills and experience.

Having a portfolio provides credibility and notoriety to the experience you're mentioning in your resume when applying for jobs. Whether you're a Data Scientist, UX Designer, or a Front-end developer. A strong online presence can help you get a job and be discovered!

>[!Note]
> For this exercise, use the [Codespace with the preconfigured environment](https://codespaces.new/MicrosoftDocs/mslearn-copilot-codespaces-javascript?quickstart=1&azure-portal=true) in your browser.

## Customize your JavaScript portfolio

In this template portfolio, we have a React based web application ready for you to easily customize and deploy using only your web browser.

Before starting, you can customize the portfolio with your own links. Go to `src/App.jsx` and update the `siteProps` with your information. The `siteProps` variable is a JavaScript object that holds key value pairs used to customize the site, it should look like this:

```javascript
const siteProps = {
  name: "Alexandrie Grenier",
  title: "Web Designer & Content Creator",
  email: "alex@example.com",
  gitHub: "microsoft",
  instagram: "microsoft",
  linkedIn: "satyanadella",
  medium: "",
  twitter: "microsoft",
  youTube: "Code",
};
```

## Animate your social media icons with a prompt

An animation can make the social media section more eye-catching. Ask Copilot’s help to animate the icons. Write the following prompt in the `src/styles.css` file:

```css
/* add an amazing animation to the social icons */
```

The suggestion from Copilot should look similar to the following:

```css
img.socialIcon:hover {
  animation: bounce 0.5s;
  animation-iteration-count: infinite;
}

@keyframes bounce {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1);
  }
}
```

Accept the suggestion by pressing the tab key. If you don't receive the exact same suggestion, then you can either experiment with the suggestion provided or keep typing the CSS code until it matches.

Your site should already be running in your Codespace, and the change will reload onto the page automatically. To see them, hover over one of your social media icons in the footer to see the magic!

Congratulations, through the exercise, you haven't only used Copilot to generate code but also done it in an interactive and fun way! You can use GitHub Copilot to not only generate code, but write documentation, test your applications and more.

When you've finished the exercise in GitHub, return here for:
> [!div class="checklist"]
> * A quick knowledge check
> * A summary of what you've learned
> * A badge for completing this module
