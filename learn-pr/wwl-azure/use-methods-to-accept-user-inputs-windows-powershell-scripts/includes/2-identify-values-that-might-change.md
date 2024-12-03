When you first create a script, it's usually to meet a need at a specific point in time. For example, you might need to find all the Active Directory Domain Services (AD DS) user accounts that haven't signed in to the domain for 60 days. Another example is that you might need to determine which of your domain controllers have a specific event in the event logs in the previous 30 days.

Over time, you'll likely find that you need to use variations of your scripts. For example, you might need to find computer accounts that haven't signed in for 30 days or find specific events in the event logs of servers other than your domain controllers.

In these examples, there are items in the script that are changing. The first and simplest way to address this is to put values that are likely to change in a variable. By placing that variable at the beginning of the script where it's easily accessible, you make it easier to modify the script. However, this still requires modification of the script.

In an environment where many administrators share a common set of scripts, it's better not to modify scripts that'll go through an approval process. If scripts are digitally signed, each modification requires that the script be signed again. It's preferable to accept user input for values that change, rather than modify scripts.

