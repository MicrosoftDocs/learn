Now that the key Python libraries are   imported, the next step is to import the data of existing rock images that we'll use to teach our computer to recognize different types of rocks.

But before we import images, it's important to learn about some steps in the AI process: cleaning and separating data. It's important to complete the steps of cleaning and separating data to ensure that the computer can accurately classify the rock images.

## Clean data

When we clean data, we look at all the data and ensure that it's complete and uniform. In our rock example, many of the image files have different sizes. To clean this data, we must  resize every image file, so they are the same size. Other examples of cleaning data include filling in missing columns of a spreadsheet if there is no data recorded for that cell or deleting certain rows of data that have incorrect data.

## Separate data

To program AI, we must first give the computer lots of data and tell it what that data represents. This process is called training. The goal is to see whether the computer can classify the new data that you give it; that is called testing. NASA gave us a substantial amount of data about different rock types, so another step we must take is to tell the computer which data we are going to use to train the AI program. We'll also tell it which data we'll u se to test the AI program. To separate data, all we do is randomly separate it into two groups: a training group and a testing group. The ratio of how much data goes into each group can vary. In our example, we'll train with 80% of the data and test with 20% of the data.
