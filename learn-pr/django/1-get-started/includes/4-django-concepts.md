Now that Django is installed, let's examine some key concepts and discover the difference between a project and an app.


## Projects vs. apps

Project | App
--------|----------
There's only one project. | There can be many apps within the single project.
Contains the necessary settings or apps for a specific website. | Is a component of the larger website.
Projects aren't used in other projects. | Apps can be used across multiple projects.

## Views

Views are another component of Django apps that serve a specific function within the app. Views contain all the necessary code that will return a specific response when requested, such as a template or an image. They can even redirect to another page if the request doesn't follow the necessary logic within the function.

## URL mapping

URL mapping in Django is called `URLconf` and serves as a table of contents for your app. After a URL is requested, this module finds the appropriate link within the project and redirects the request over to the views file contained within the app. The view then processes the request and performs the necessary operations.

As you continue to learn and have more complex file structures, you'll add more views and URLs for your app. The `URLconf` function plays a key role because it allows for a simple way to manage and organize URLs within the application. It also provides greater freedom to change path roots without breaking the app.
