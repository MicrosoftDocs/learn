Now that you've seen the basic components of a dev container configuration, let's see how you can customize them further.

## What is port forwarding?

Containers are isolated environments, so if you want to access a server, service, or other resource inside your container, you'll need to forward the port to your host. You can either configure your container to always expose these ports or just forward them temporarily.

## How do we forward ports in containers?

### Always forward a port

You can specify a list of ports you always want to forward when attaching or opening a folder in container by using the forwardPorts property in devcontainer.json.

To build on our previous `devcontainer.json`, we could forward port 3000:

```json
{
    "build": { "dockerFile": "Dockerfile" },
    "forwardPorts": [ 3000 ]
}
```

### Temporarily forward a port

If you need to access a port that you didn't add to `devcontainer.json` or publish in your Docker Compose file, you can temporarily forward a new port for the duration of the session by running the Forward a Port command from the Command Palette (F1).