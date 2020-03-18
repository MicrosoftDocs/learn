# Introduction

The file system is an important part of many applications. This means working with files, directories but also dealing with different access levels and things like streams and processes.

Working with files is in Node.js a synchronous or an asynchronous process. Node.js is single threaded which means if we need to carry things out in parallel we need an approach that supports it. That approach is the callback pattern.

Streams is a topic that is not unique to Node.js but is core concept that is almost everywhere. With Streams we are able to work with data whether we are trying to open up a file or transferring data from one network point to another. Learning to leverage streams can make your app really responsive and will ensure that consumption of resources like CPU and memory stays at a minimum.

Processes is an interesting topic in Node.js. Working with processes means we spawn up new shells, run a command and listen to the output. We can also create processes capable of communicating with one another.

## Learning Objectives

In this module, you will:

- Work with file paths
- Learn how to work with files in an asynchronous and synchronous way
- Understand Streams and learn to leverage them to make your apps more performant
- Explore processes and learn the different ways we can work with them.
