The questions in this Knowledge Check relate to the workflows shown in the following illustrations.

### Social media workflow

![An illustration of a social-media monitoring workflow. This workflow triggers when a user posts a new tweet that mentions a specific product. It sends the text of the tweet through Text Analytics to determine sentiment. If the sentiment score is greater than 0.7, then a row containing the tweet is added to a database. If the tweet is rated less than 0.7, an email will be sent to customer support.](../media-drafts/3-sm-workflow.png)

### Book approval workflow

![An illustration of a book approval workflow. This workflow triggers when an author adds a new file is to Dropbox. Next, Twilio sends a text message to the author letting them know the submission was received. After that, an email is sent to the editor asking them to review the submission. Next, there is a switch statement that branches based on the editor’s response to the proposal. There are three branches that can run depending on the editor’s response. Each branch is labeled with a number. If number one occurs, an email is sent to the author. If number two, occurs and email is sent to the author, the original file is copied to an approved folder in Dropbox, and the original file in Dropbox is deleted. If number 3 occurs, an email is sent to the author and file is deleted in Dropbox.](../media-drafts/3-ba-workflow.png)

### Email attachment processing workflow

![An illustration of an email attachment processing workflow. This workflow is triggered when a new email arrives. Next, there is a *if* statement that checks if the email has an attachment. If there are no attachments on the email, the workflow ends. If there are attachments, the workflow creates a Blob for the email body. Next, a *foreach* loop creates a blob for every attachment. Finally, an email is sent for review.](../media-drafts/3-ep-workflow.png)

Each question will ask you to evaluate one of the workflows to find the correct answer.