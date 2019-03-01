The goal of this exercise is to:

* Identify an open source package that you want to (or currently) use in your app.
* Access package and license ratings through the pipeline.
* Verify that these ratings meet your organization's requirements.

It's TBD what tooling we use here - ideally something that's well-known/accepted in the industry, is free and easy to set up, and integrates well with our tooling. The JTA calls out Black Duck and White Source.

I'm thinking we go the path where the reference app already uses the OSS component. But that makes the narrative a bit tricky - what if the component greatly fails to meet requirements? Then our suggestion would be to quickly pull it out and find a new one, write your own, or submit a fix to the authors.

Alternatively, we can consider creating a pipeline just to get the license ratings for the component and then assess whether that component would be a good fit for our app given corporate standards.