In this exercise, you'll connect to Vision on Edge solution through web application. Firstly, you'll add a camera that streams out the video. Then you'll capture images and tag objects. Finally, you'll deploy your solution, which will identify the gaps in the shelf.

## Add a camera

1. Open your browser, connect to **http://<replace_your_public_ip_address>:8181**. 

2. When you connect to Vision on Edge solution, click on **Home** page.

   [![The illustration shows edge solution.](../media/vision-on-edge.png)](../media/vision-on-edge.png#lightbox)

## Capture the images and tag objects

1. In this step, you'll manually capture your own images. To do that, firstly you'll add a camera.

2. Navigate to **Cameras** page and add a camera.

3. Fill the required information:

   - Camera name: Give a name to your camera
   - RTSP URL: Replace it with **rtsp://rtspsim:554/media/<replace_video_name>**
   - Location: Create a location or choose an existing one
   
   [![The illustration shows how to add camera.](../media/add-camera.png)](../media/add-camera.png#lightbox)

4. To capture images from your video stream, navigate to the **Images** page and click on Capture from camera.

   [![The illustration shows images page.](../media/images-page.png)](../media/images-page.png#lightbox)

5. You'll see that the video will start to be displayed. When you see the gap on the shelf, capture the image. Continue adding more images to improve your model. It's recommended to capture at least 15 images. Click on **Done** when you finish.

   [![The illustration shows how to capture images.](../media/capture-image.png)](../media/capture-image.png#lightbox)   

6. Navigate to the **Objects** page and add an object to tag your image. In this example, we want to add a gap object.

   [![The illustration shows how to add an object.](../media/add-object.png)](../media/add-object.png#lightbox)

7. Go back to **Images**. Click on one of the images and drag a box around the object(in this case, gap) you want to tag and select gap object. Repeat the same step for all images and click **Done** when you finish.

   [![The illustration shows tag an object.](../media/tag-object.png)](../media/tag-object.png#lightbox)

8. You'll see that all the images you captured are tagged with gap objects.

   [![The illustration shows tagged images.](../media/tagged-images.png)](../media/tagged-images.png#lightbox)

## Create a solution deployment

1. Navigate the **Deployment** page.

2. To deploy a task, fill the required information:

   - Give a name to your deployment
   - Choose Model
   - Select Camera
   - Select Objects

3. Click **Deploy**.

   [![The illustration shows how to deploy a task for your solution.](../media/deploy-task.png)](../media/deploy-task.png#lightbox)

4. You'll see that the gaps will be identified in the video stream.
