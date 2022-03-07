Content moderation is a process that involves simple steps. Reviewing, monitoring, and interpretation of content before it is displayed or released for general consumption is a form of moderation. Having a large amount of content to moderate can be time consuming. Using a service, such as Content Moderator, you can automate much of this process and set up the need for human review as appropriate.

The Content Moderator service is an API that is powered by artificial intelligence, and runs on Azure. The service is capable of scanning text, image, and video content for potential risky, offensive, or undesirable aspects. It will apply content flags automatically but also integrates with the Review tool. The Review tool is an online moderator environment that is used to facilitate human review of flagged content.

## The APIs

There are different types of APIs available in Content Moderator. The following table describes each of the current APIs.

| API | Functionality |
| --- | --- |
| Text Moderation | Scans text for offensive, sexually explicit or suggestive, profanity, and personal data aspect |
| Image Moderation | Scans images determine if they contain adult or racy content. It can also scan text in the image using Optical Character Recognition (OCR) and can detect faces in an image as well. |
| Video Moderation | Scans for adult or racy content in video files. The API will return time markers where the content was found. |
| Custom Term Lists | Scans text for a list of terms that you have created. You can use the list to block or allow content based on your organization's content policies. |
| Custom Image Lists | Scans images against your custom image lists. You can use the list to filter out commonly recurring content that you don't want to classify again. |

## Content review

Automated content moderation may still require validation. You may also decide that you want to monitor how the service is performing in the moderation tasks. The Content Moderator service also supports a set of review APIs. Using the review APIs, you can bring a human reviewer into the workflow. Humans will interact with the service through the review tool, a web-based interface that hosts the content reviews that human moderators can process and monitor.