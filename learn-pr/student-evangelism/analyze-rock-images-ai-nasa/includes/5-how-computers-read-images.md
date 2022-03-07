Now that we have our data cleaned and separated, you might wonder how the computer reads these images.

> _Hint: &nbsp;Computers can't read images the same way humans do_.

If you know something about developing for computers, you probably know computers read data in *binary* format. The data is represented as a long series of ones and zeroes like 101011001110001010111, and so on.

So, how can a computer read a complex image as only a series of ones and zeroes?

If you zoom in on the data in an image, you'll discover the picture in the photo is represented in the image file as *pixels*. Each pixel is a specific color that has a unique code. After the computer converts a photo into an image with these codes, it can read and decipher the binary pixel data.

Here's an example that shows how a computer transforms a photo into a series of numbers in an image file:

:::image type="content" alt-text="Photo of the head of Abraham Lincoln." source="../media/lincoln.png" loc-scope="Azure":::

:::image type="content" alt-text="Three images that show pixelation, pixelation with a number overlay, and only numbers that represent a digital photo of Abraham Lincoln." source="../media/pixels.png" loc-scope="Azure":::
