This module has reviewed how data moves over the internet to individual devices. Using specific forms of identity like MAC addresses and IP addresses, computers and data can figure out where to go.

When you want to visit a specific website though, you don't have to know anything about IP or MAC addresses. You simply type in or tap a web address like www.microsoft.com and within seconds you're there. You have access to all the site's information.

## What's in a Name?

Web addresses like `azure.com` or `visualstudio.net` are written in a specific way. There's the beginning like `www` or `portal` or `mail`. There's a name like `microsoft` or `azure`. And there's a suffix like `.com` or `.net`. Like IP addresses, each of the sections are separated by a dot or period.

The last two parts of that address are the most important. You can type `www.microsoft.com` or just `microsoft.com` and both will take you to Microsoft's site. In this address, `microsoft.com` is called the site's "domain name". It is a special name that companies (and individuals) pay for. As long as the company continues to pay for it, they own it. No one else can use `microsoft.com` but Microsoft. The "domain" is the company's and tells the internet where to look for things like web pages, videos, and other files.

Many of us have gotten so used to typing in web addresses that we may not think much about them. But they do make up the internet's "address book," so understanding a bit of how it works can help you learn how networks work.

## A Big Address Book

When you type in a domain name, how does your browser know where to go? How does it know to pull up the web pages on servers for a particular company or individual?

Each router on the internet is assigned a special IP address so the internet knows where to find resources. The set of computers (called web servers) that run a company's website have routers with IP addresses. Thankfully, you don't have to know what those IP addresses are. You can simply type in `microsoft.com` and get to where you need to go.

![Diagram showing a lookup table, address book, phone book or similar idea of having to look something up.](../media/phone-book.jpeg)

This is because there's a big address book that links the domain name you type into your browser with the IP address of the company. This address book is called the Domain Name System, or DNS for short.

So when you type `microsoft.com`, it sends that "friendly name" to the DNS, which looks it up. It finds the IP address for Microsoft and sends your browser to the right site.

You may now see the power of these simple IDs called IP addresses. They help make most of what you do online work. Without them, the internet would not be possible.
