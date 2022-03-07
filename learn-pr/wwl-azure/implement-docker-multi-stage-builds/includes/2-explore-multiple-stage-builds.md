It's essential when building images to keep the image size as small as possible.

Every extra instruction that is added to the Dockerfile adds what is referred to as a **layer**.

Each layer often contains artifacts not needed in the final image and should be cleaned up before moving to the next layer. Doing it has been tricky.

Docker 17.05 added a new feature that allowed the creation of multi-stage builds.

It helps with optimizing the files, improves their readability, and makes them easier to maintain.

With multi-stage builds, you use multiple FROM statements in your Dockerfile. Each FROM instruction starts a new stage.

The stages are numbered in order, starting with stage 0.

Note how each stage has been named (or aliased) by using an **AS** clause to make the file easier to maintain without constantly changing numbers that reference.

Each FROM instruction can have a different parent (that is, base). It allows the developer to control what is copied from one stage to another and avoids intermediate images.

Another advantage of named stages is that they're easier to refer to in external commands.

For example, not all stages need to be built each time. You can see that in the following Docker CLI command:

```
$ docker build --target publish -t gregsimages/popkorn:latest .

```

The **--target** option tells **docker build** that it needs to create an image up to the target of publishing, one of the named stages.
