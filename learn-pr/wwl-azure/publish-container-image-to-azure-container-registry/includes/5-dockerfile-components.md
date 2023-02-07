
If you want to create a custom container you will need to understand the elements of a Dockerfile. A Dockerfile is a text file that contains the instructions we use to build and run a Docker image.  The following aspects of the image are defined:

* The base or parent image we use to create the new image
* Commands to update the base OS and install additional software
* Build artifacts to include, such as a developed application
* Services to expose, such a storage and network configuration
* Command to run when the container is launched

Let's map these aspects to an example Dockerfile. Suppose we're creating a Docker image for an ASP.NET Core website. The Dockerfile may look like the following example.

```bash
# Step 1: Specify the parent image for the new image
FROM ubuntu:18.04

# Step 2: Update OS packages and install additional software
RUN apt -y update &&  apt install -y wget nginx software-properties-common apt-transport-https \
	&& wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
	&& dpkg -i packages-microsoft-prod.deb \
	&& add-apt-repository universe \
	&& apt -y update \
	&& apt install -y dotnet-sdk-3.0

# Step 3: Start Nginx environment
CMD service nginx start

# Step 4: Configure Nginx environment
COPY ./default /etc/nginx/sites-available/default

# STEP 5: Configure work directory
WORKDIR /app

# STEP 6: Copy website code to container
COPY ./website/. .

# STEP 7: Configure network requirements
EXPOSE 80:8080

# STEP 8: Define the entry point of the process that runs in the container
ENTRYPOINT ["dotnet", "website.dll"]
```

We're not going to cover the Dockerfile file specification here or the detail of each command in our above example. However, notice that there are several commands in this file that allow us to manipulate the structure of the image.

Each of these steps creates a cached container image as we build the final container image. These temporary images are layered on top of the previous and presented as single image once all steps complete.

Finally, notice the last step, step 8. The `ENTRYPOINT` in the file indicates which process will execute once we run a container from an image.

## Additional resources

* Dockerfile reference
    * [https://docs.docker.com/engine/reference/builder/](https://docs.docker.com/engine/reference/builder/)
