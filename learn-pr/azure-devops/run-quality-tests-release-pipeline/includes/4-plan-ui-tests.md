Amita is waiting for Andy to show up. He's going to help her write a UI test that will go into the pipeline. She scribbles in her notebook, crosses something out, mutters, and then starts tearing out the page. Andy walks in. "Hi," he says. "You don't look happy."

"I'm not. I'm worried. I'm trying to figure out how to write an automated test but I don't know where to start. I don't code. I feel like I'm obsolete."

"Wow," Andy says. "I really don't think it's that bad. For one thing, we'll always need someone who can keep the user's perspective in mind. There's no way to automate that. For another, no one starts out knowing how to do this. We were all beginners. Hopefully, I can make the learning process a bit easier.

"I thought the best way to start was to automate something you already do all the time. Pick a UI test you understand, let's walk through it and write down the steps, and then we'll figure out how to automate. Where do you want to start?"

Amita takes a deep breath. "Let's automate the modal test. When I click on certain things, like the **Download game** button for example, the main window should be disabled but visible. The modal window should be in front of it. Users have to interact with the modal window before they can return to the main window. 

"You're the boss," Andy says. You run the test and I'll write down the procedure.

"Until we had the pipeline," Amita says, I used to download the build and install it on my server but now I can use the CD pipeline test environment." 

From a Windows machine, Mara brings up the Chrome browser. She goes to the web app and verifies that the home page comes up. "OK," Andy says. What do you check next?"

"I check that when I click the **Download game** button, a modal window appears with a link to the game."

"OK, before you do that, and before you click on anything like a button or modal window, there's something I want you to do, which is to copy down the XPath path. XPath is a query language that lets us retrieve information about the HTML element. The procedure is simple.

-**NOTE-I guess some procedure (not mine, which is probably wrong) on how to do this should go somewhere?/**

1. Right click on the element, in this case the **Download game** button.
1. Select **Inspect** from the menu that appears.
1. In the text window, that opens up, you'll see some text that's highlighted.
1. Right click in that text.
1. In the menu, point to **Copy** and then select **Copy XPath**.
1. Paste the text into a doc somewhere. We'll use it later.

 ******************************************************************************

"Got it," Mara says. 

Here are the steps that comprise her modal test.

1. From a Windows machine, she brings up Chrome.
1. She goes to the web app and verifies that the home page comes up.
1. She verifies that the **Download game** button brings up the modal window containing the link to the game.
1. She verifies that clicking each of the four screenshot thumbnails brings up a full version of the screenshot in a modal window.
1. She verifies that clicking top player on the leaderboard brings up a modal window showing that player's profile.
1. She repeats the process on the Windows machine using Firefox and IE web browsers.

"Okay," Andy says. "I can see why this test takes so long and can be so frustrating. You're going to love automating it, I promise. Here's what we'll do."

1. Create an NUnit project that includes Selenium, along with the app sources. 
1. Add code that creates a web browser for Chrome, Firefox and IE.
1. Write a test case that uses automation to click the specified link and that verifies that the expected modal window appears.
1. Use the XPath data we saved to specify the parameters to the test case method. This creates a series of tests.
1. Configure the tests to run on Chrome, Firefox and IE.
1. Run the tests and watch each web browser come up automatically.
1. Watch as Selenium automatically runs through the series of tests for each browser.
1. See in the console window that all the tests pass.
1. Be excited at how quickly the tests ran.

****************NOTE--move to next page?*******************************
Amita is impressed and feels a bit excited about writing code to control her web browser. Perhaps Mara shows her some resources (tutorials, reference documentation) so Amita can continue writing tests. Amita can then write and verify additional tests and submit them to GitHub and have them run through the pipeline just like the developers.