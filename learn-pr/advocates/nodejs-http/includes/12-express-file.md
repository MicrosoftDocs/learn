A form is usually how a user is able to enter data into a web application. So far you've seen how simple data like text can be entered and submitted. Another common form of input is a file. 

To support uploading files, the following actions needs to be taken:

- **Configure form**, a form needs to be configured so that it can submit a file
- **Add file input control**, an input control needs to be added to support selecting a file from the users file system.
- **Configure the Express app**, Express does support receiving a file through the use a third-party library.

## Configure the Form

The form element has an attribute `enctype`. This needs to be set to the value `multipart/form-data`. This will instruct the Browser to serialize a file so it can be transmitted to a backend. If this attribute is not set correctly the file will not be sent upon submitting the form.

## File input control

You need to an input element to your form. The input element has the following markup `<input type="file">` and needs to be placed inside of the form tag element. This will render as input field and a button. When the button is clicked on the element, it will open a dialog window that let's the user choose a file from their file system. This control can be configured in various ways. For example, it can be configured to limit what file extensions to accept as files the user can upload. Some browsers also support the upload of multiple files or a directory of files.

## Submitting and receiving the file

Let's go through a file submitting scenario and explain the different steps that take place.

1. The user interacts with the file input element and selects a file
2. The user presses the submit button and the form, with the file, is submitted
3. The file is transmitted as a stream of data. The file is sent as a header, body, and footer. Here's what a file transmission can look like submitting a simple text field and a text file.

   ```output
   file ------WebKitFormBoundaryR7uA4A5kM5HaftWi
   Content-Disposition: form-data; name="name"

   my name
   ------WebKitFormBoundaryR7uA4A5kM5HaftWi
   Content-Disposition: form-data; name="file"; filename="test.txt"
   Content-Type: text/plain

   Here is a simple file
   ------WebKitFormBoundaryR7uA4A5kM5HaftWi--
   ```

   Above you can see how there are two sections of data, one section for your text field and its value:

   ```output
   file ------WebKitFormBoundaryR7uA4A5kM5HaftWi
   Content-Disposition: form-data; name="name"

   my name
   ```

   The other section is for the file itself:

   ```output
   ------WebKitFormBoundaryR7uA4A5kM5HaftWi
   Content-Disposition: form-data; name="file"; filename="test.txt"
   Content-Type: text/plain

   Here is a simple file
   ------WebKitFormBoundaryR7uA4A5kM5HaftWi--
   ```

   Note above how this contains a header section telling you what input field, an extra header attribute like `filename` and lastly the entire file content.
  
Even though the above is readable and you could probably parse it - you don't want to deal with files this way. The Express framework deals with things on a higher level. You learned in the previous unit how Express can parse a submitted form for you. Express can be made to do the file parsing as well. This is not a built-in functionality however. You can add this capability by downloading a third-party library called `multer`. `multer` deals with parsing the above so all you need to do is instruct `multer` where to store the file and under what name. 
