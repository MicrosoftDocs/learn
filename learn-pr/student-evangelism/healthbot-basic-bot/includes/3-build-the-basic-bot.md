We will be creating a basic informative bot in the first module. This unit introduces the user to some basic elements of the Microsoft HealthCare Bot platform. Everything in Microsoft Healthcare Bot can be built simply by dragging and dropping the scenario elements. Once you understand the practical use of each scenario, you can then design more complex applications. Here, we have explained a basic information bot which can be potentially deployed at the entrance of the hospital or healthcare organization to provide basic information to the user about the offered services.  

Without further delay let's start building our bot. In our introduction module we created a custom scenario. So let's continue from there.

Since our aim is to create an informative bot, lets first greet the user and take the input on what the user wants to do. We can do it using the " Prompt " block,

This is how a prompt block looks like,

:::image type="content" source="../media/3-prompt.png" alt-text="prompt":::

The healthcare bot uses JavaScript to implement some Scenario steps. Hence its recommended to know basic concepts of JavaScript. If not JavaScript, knowledge in any basic programming language will also help.  

**Display text:** The block display name. Give a suitable name. Since we are creating a greeting block, lets name it "Greeting". Give an apt name so that we can differentiate between the blocks.

**Variable:** As told earlier the healthcare bot uses some programming concepts. So here we need give the name of the variable to store the input from the user. Variable is simply a container which temporarily holds the data. Imagine any cold drink bottle, Initially it has cold drink with a label on top, after usage we can simply remove the label and fill some water in that, but the bottle is the same. The bottle here is the variable and the content inside the bottle is the data which can be anything. Remember it is case sensitive.

**Variable Type:** As we discussed before the bottle can hold any type of drink, similarly here the type can be anything. Some important data types are String, Number, Boolean, Time, Choice, Multi-choice, Attachment, Object. Since we are just asking the user for help, we have to provide all the required help that we can provide through the bot. Since it has many options, choose multiple choice.

**Choices Array:** As the name suggests, it is an array of choices or multi-choices. Provide the required choices.
Array is a systematic collection of like objects.

**Show Choices as:** This is the way we want the GUI to look like. Let's simply choose button.
Depending on the Variable type the upcoming boxes should be changed. The rest will be set to default.

:::image type="content" source="../media/3-greetings.png" alt-text="3-b":::

Fill it as shown above and close it. Congratulations! You have now completed the first step! Now lets head to the next step.

Once the user inputs the data now, we have to move as per the choices he has entered! Which means we are branching from this point. So, which is the block we are going to use? Yes, you guessed it right! It's the "Branch" Block. Without further delay let's just drag a block and drop it on the canvas!

**JavaScript Boolean Expression:**  This is a field which recognizes the command. We know that the counting in computer starts from 0 index. So 0 is the first position in computer. If we choose the option 1 in the array, then it corresponds to the 0th index. We will have to feed this with a simple line of code as shown below,

```javascript
scenario.help.index == 0
```

This is the way we call the objects.  

**Syntax:**  "[name].[variable name].[index] == [index position]"_

Since the first branch is for the first object of the array we have to branch the first object to one side and the rest of the objects to the other side. That's why we have taken 0th index. Note the usage of ' = = '  and not ' = '. The latter is for assigning a value whereas the former is to check the value.

This is how our first branch block should look like.

:::image type="content" source="../media/3-first-branch.png" alt-text="3-c":::

 Once this is done now connect the two blocks. It should look something like this,

:::image type="content" source="../media/3-connected-blocks.png" alt-text="3-d":::

We have two paths now.

* If the condition is true i.e., Yes
* If the condition is false i.e., No

Let's now do the first path i.e., the Yes path.

Well since our first option said "Services" if the user clicks on Services, we have to display the available services. Once the user selects service he wants just simple show a data related to that. You are free to continue the process and make the bot even more interactive. But the scope of this unit is to just introduce you to the bot interface. So, we keep it simple.

So now we have to display the services to the user and also take an input. Which block do we use? Yes, you got it right it's the "Prompt" block again.

Drag a prompt block and fill it as shown below,

:::image type="content" source="../media/3-services-list.png" alt-text="3-e":::

 We have already gone through the parameter details.

As you can see, we have many services which Contoso hospital offers. So there are multiple branching now. In such cases we use the block called as "Switch"

Go ahead and drag the switch block to the canvas. It looks something like this,

:::image type="content" source="../media/3-switch.png" alt-text="3-f":::

This is like the classic switch case we use in any programming language. If the option matches then it flows through that. If it doesn't then it enters the default value.

:::image type="content" source="../media/3-switch-details.png" alt-text="3-g":::

Fill it as shown above. The variable name goes in the brackets after the $ sign the "." Refers to the call. The provide all the choices we have in switch cases box.

Now connect them as shown!  

:::image type="content" source="../media/3-connect-services.png" alt-text="3-h":::

Now lets assume the user selects any service we can simply provide the information to the user. Which is basically giving an output or in other words display information, To do this we use the "Statement" block.

Go ahead and drag a statement block and drop it on the canvas. It should look something like this.

:::image type="content" source="../media/3-statement.png" alt-text="3-i":::

Display Text:  It is the information we want to display to the user. So give it accordingly and leave the rest as it is.

Fill it as shown below,

:::image type="content" source="../media/3-pharmacy-statement.png" alt-text="3-j":::

Click on OK and then connect it. It should now look something similar,

:::image type="content" source="../media/3-connect-pharmacy.png" alt-text="3-k":::

Fill the other switch cases with statement blocks.

:::image type="content" source="../media/3-emergency-statement.png" alt-text="3-l":::

After filling everything it should look something like this.

:::image type="content" source="../media/3-connected-all-services.png" alt-text="3-m":::

Now let's go back to the first branching we had. If the user chooses other option apart from the Services, The it's the "No" path.

The next thing we had in the list was the departments and More info.

Let's configure the bot for the next branching.

We know that is its Yes its department and if it's a No then More info. Unlike the previous step where we had two option inside "No" path. Its directly branching here So drag a "Branch" block and configure it as shown,

:::image type="content" source="../media/3-departments.png" alt-text="3-n":::

Then connect it as shown,

:::image type="content" source="../media/3-connect-departments.png" alt-text="3-o":::

For the Departments follow the same as we did in services with switch case. It should look like this.

:::image type="content" source="../media/3-departments-details.png" alt-text="3-p":::

Now drag the switch block and configure it as shown.

:::image type="content" source="../media/3-departments-switch.png" alt-text="3-q":::

Now add the statement blocks as we did previously,

:::image type="content" source="../media/3-cardiologist.png" alt-text="3-r":::

Since we the More info is just a simple statement we want to display, Lets use a statement block. Finally the bot should look something like this,

:::image type="content" source="../media/3-connected-all-departments.png" alt-text="3-s":::

Well congratulations! You have finally completed the bot ! Now save it and run the bot. The Web chat v4 will help you to test the bot!
