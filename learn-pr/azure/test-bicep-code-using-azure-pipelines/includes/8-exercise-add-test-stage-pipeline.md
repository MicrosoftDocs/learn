    1. Update the pipeline YAML file to add a new test stage after the deployment stage.
        1. Now the stages will be: Validate > Preview > Deploy > Test
        1. Ensure the test will fail.
    1. Run the pipeline and observe the failed test.
    1. Fix the test.
    1. Run the pipeline again and observe the successful deployment.