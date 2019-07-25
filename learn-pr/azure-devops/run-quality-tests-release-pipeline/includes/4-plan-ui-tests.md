Note: This is the lead-in unit for the next part where you'll run Selenium UI tests. As a thought, perhaps Mara (or Andy) pair up with Amita.

Remember, Amita's background is with manual testing. Perhaps she's a bit nervous about writing code. Mara has her talk through her existing process, and then together they code up some tests that perform the same processes automatically.

Perhaps we also put Amita's mind at ease that she's not getting put out of a job due to automation. Time is required to create and maintain tests, and her skills in making the user experience great will always be needed.

Perhaps this is Amita's process:

1. She downloads the build and installs it in her test environment (this was recently replaced with the CD pipeline, which automatically deploys it to the test environment.)
1. From a Windows machine, she brings up Chrome (a typical user setup).
1. She goes to the web app and verifies the home page comes up.
1. She verifies that the **Download game** button brings up the modal window containing the link to the game. (perhaps show a screenshot of the web page showing where?)
1. She verifies that clicking each of the four screenshot thumbnails brings up a full version of the screenshot in a modal window. (perhaps show a screenshot of the web page showing where?)
1. She verifies that clicking top player on the leaderboard brings up a modal window showing that player's profile. (perhaps show a screenshot of the web page showing where?)
1. She repeats the process on the Windows machine using Firefox and IE web browsers. (and maybe on macOS as well, making it a 3x2 test matrix, which is tedious and takes lots of time to complete? )

Here are the steps they'll follow in the next part (the mapping):

* They go through the above process manually on Chrome.
  * Using Chrome's debugging tools, they identify and copy down the XPath path to each button Amita clicks on and the XPath path to the modal window that opens.
  * (we may need to talk more about what XPath is?)
  * (we'll add screenshots showing what Amita sees.)
* Create an NUnit project that includes Selenium alongside the app sources (just like they did with the unit test project in the earlier module.)
* They add setup code that creates a web browser driver for Chrome, Firefox, and IE.
* The write a test case method that uses automation that clicks the specified link and verifies that link brings up the expected modal window.
* They use the XPath paths they noted earlier to specify the parameters to the test case method, forming a series of test cases.
* The configure the tests to run on Chrome, Firefox, and then IE.
* They run the tests and watch each web browser come up automatically and watch Selenium control the web browser to run the tests.
* They see from the console window that the entire set up tests pass on each browser. They note how quickly it all ran!

Amita is impressed and feels a bit excited about writing code to control her web browser. Perhaps Mara shows her some resources (tutorials, reference documentation) so Amita can continue writing tests. Amita can then write and verify additional tests and submit them to GitHub and have them run through the pipeline just like the developers.