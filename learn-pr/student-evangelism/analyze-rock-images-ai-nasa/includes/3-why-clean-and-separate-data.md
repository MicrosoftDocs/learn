The next step is to import the data of existing rock images that we'll use to teach our computer to recognize different types of rocks.

Before we import images, we need to review two critical steps in the AI process: cleaning and separating data. It's important to complete these steps to ensure the computer can accurately classify the rock images.


## Clean data

To clean our data, we need to make sure it's complete and uniform. In our rock example, many image files have different sizes. For a clean set, we need to resize every image file so they're all same size. We might have to fill in cells where data is missing, and delete rows with incorrect data.


## Separate data

To program AI, first we give the computer lots of data and tell it what the data represents. This process is called *training*. After we train the computer, we *test* the computer to see if it can classify new data we input.

NASA provided a large amount of data about different rock types. We need to tell the computer which data to use for training and which to use for testing. To do the separation, we randomly distribute the data into these two groups. The ratio of how much data goes into each group can vary. In our example, we'll train with 80% of the data and test with 20% of the data.
