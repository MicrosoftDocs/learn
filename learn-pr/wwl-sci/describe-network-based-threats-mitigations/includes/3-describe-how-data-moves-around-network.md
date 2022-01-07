A network exists when you have two or more devices that share data. As you saw in the previous unit, a network is composed of many different physical parts that work together to ensure your data gets to where it's needed. This transmission of data across a network is enabled by a suite of communication protocols, often referred to as TCP/IP. It's named after the two main protocols: Transmission Control Protocol (TCP), which handles the connection between two devices, and Internet Protocol (IP), which is responsible for routing information across the network.

Every network on the planet shares and moves data every second of the day. This data comes in every shape and size, from a simple message to images, and even the movies that are streamed to your home.

### The datagram or packet

Networks exist to help make device-to-device or system-to-system communication easier. Whatever the size of data, it all needs to be broken down into tiny, uniform chunks. These chunks are called datagrams but are also more commonly known as packets.

Imagine that you want to stream a movie to your device. Given the enormous size of the data involved, the streaming server can't give you the whole movie in one go. Instead, the movie is broken up into billions of packets. Each packet contains a small part of the movie, which is then sent to your device. Your device has to wait until enough packets have been received before you can start watching the movie. In the background, the server continues to send a steady stream of packets to your device just ahead of what's being displayed. If your network speed slows down, then the packets may not reach you in time. The picture you see might become distorted or blocky and there may be gaps in the sound.

### IP addresses

When you want to send a letter to a friend, you'll first write it out before putting it in an envelope. Next you'll write your friend's address on the envelope before posting it. The postal service collects the letter, and through various sorting offices, eventually delivers it.

Networks operate in a similar manner. The message is contained in the packet, like an envelope. Then the sender and recipient addresses are added to the packet.

The primary function of the Internet Protocol (IP) is to ensure that every device on a network can be uniquely identified. Before a packet is sent across the network, it must be told the IP address of where it's going, and the IP address of where it's come from.

There are presently two standards of IP address: the IPv4 and the IPv6. The details are beyond the scope of this module, but the most common type of IP address, and the one you may be familiar with, is IPv4. This is made up of four groups of digits separated by a dot, for example: 127.100.0.1.  

#### DNS

Just like every device on a network needs a unique IP address, every public facing website has its own IP address. You could use the IP address to visit your favorite online retail store, bank, or streaming video service. But with so many websites available, that would be difficult to remember. Instead, you type the name of the service you're looking for into your browser and it takes you to the website you want. This is all thanks to the domain name service or DNS.

The DNS holds a table that has the name of the website, for instance [microsoft.com](https://microsoft.com/), which maps to its corresponding IP address. Your browser uses this to find the actual website in much the same way as you might use a phone book to find a telephone number.

:::image type="content" source="../media/dns-lookup-table.png" alt-text="Diagram that shows a simplified representation of a DNS lookup table, where the domain microsoft.com has been found and gives the corresponding IP address.":::

Each time your device connects to the internet, it uses a local DNS server to find the name of the website you're looking for. If the DNS can’t find the site, it checks other DNS servers. If the site can't be found, or the request times out, you'll get an message you've probably encountered before: the 404 page not found error.

### Routing

When the IP addresses have been added to the packet, it's ready to be transmitted across the network. If the IP address exists on your network, the packet is sent directly to the device. However, if the IP address is outside of your network, it will need to go via a router. A router is a physical device that connects one network to another.

Using our letter scenario, if your friend was only a few streets away, you might decide to deliver the message by hand. Your friend is within your local network.

However, if your friend is in a different city or country/region, you'll need to post the letter and let the mail service deliver it. In this instance, the postal service is the router. It takes the message from your network, then finds the best route to get it to your friend's network for delivery.

### Video animation

In this short two-minute video, you'll see how everyday activities form networks, from speaking with your friends on the phone, to sharing emails. Then we'll look at the way messages are broken down into packets that can be sent across the network. Finally, you'll see how each packet of a message is routed across the internet to get to its recipient.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RWP56O]
