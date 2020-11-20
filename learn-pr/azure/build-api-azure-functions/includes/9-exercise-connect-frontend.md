In this exercise, you'll point the frontend project at the newly created API to see the Product Manager application come to life.

## Connect the front-end web application

1. Open the `frontend/index.js` file.

1. On the second line of the file, set the `API` variable to "http://localhost:7071/api".

   ```javascript
   const API = "http://localhost:7071/api";
   ```

1. The front-end app should still be running in a browser tab on port 5000. Refresh the page.

1. The app loads in the data from the API.

   :::image type="content" source="../media/working-application.png" alt-text="Screenshot of web browser displaying the Products Manager application shown populated with data." loc-scope="other":::

1. To ensure that all endpoints work, try creating, updating, and deleting products.

That app looks good. It looks **very** good. None of it would be possible without your brilliant API. Ready to test what you've learned?
