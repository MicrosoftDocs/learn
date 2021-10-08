1. Review repo and notice the website code is included, and the pipeline has a CI stage that builds the site into a binary.
1. Update the build stage to copy the binary to an artifact.
1. Update the pipeline's deployment stage to add an App Service deployment task that references the artifact and the website hostname from the Bicep deployment outputs.
1. Run the pipeline.
1. Test the website and notice it now loads a homepage.
1. Add a test case that illustrates that the products aren't included.