In an earlier unit, you learned that getting that text message to your phone involves a lot of identities. Here's what's involved so far:

1.  The MAC address of your friend's mobile phone
2.  The IP address of your friend's mobile phone
3.  The MAC address of your mobile phone
4.  The IP address of your mobile phone

As you may notice, there are a couple of problems that still need to be solved. When your friend sends you a message, their home network's router knows that the message is coming from their phone. This is done by looking at a group of the device's MAC address and the IP address the router assigned it. Then what? How does it leave their subnet and get to yours?

## IP Addresses All the Way Down

In order for the data to leave their subnet and get to yours, it has to travel through a bunch of other public but secure subnets. Your home network can't just talk to your device on your subnet. It has to talk to computers on the internet. Your network router faces inside toward your home devices and outside toward the internet. It "routes" the data between computers on your home subnet and the internet. That's where it gets its name.

:::image type="content" source="../media/internet-protocol-address-32318598.jpeg" alt-text="Diagram showing concept of router assigning IP Addresses.":::


In order to face outside toward the internet, it also has to have a unique ID. Your router itself, being a mini computer, has a MAC address all its own. But it also has an IP address that is shown to the internet. This IP address is given by your internet company. *This* IP address can't be shared with any other device on the internet, so your neighbor's router has to have a different IP address than yours. If they had the same IP address, the computers on the internet would get confused and not know which router to send the data to.

## The Big Picture

So, now you have a better picture of how those text messages get from your phone to your friend's phone, and back. The computers that control the internet see that your friend's home router and your home router have unique identifiers, so they can find the individual routers among the millions on the internet. Once the data finds its way to your router, your home network knows what to do with it and gets it to your individual device using the unique IDs your device was assigned.

Of course, there are a lot of other complex processes that are going on to ensure that the message is sent to you securely and doesn't get lost along the way. This is a first step toward laying out how something as simple as a text message can make it thousands of miles across wires and radio signals to reach your phone.
