# Creating custom container images

## Manual image creation

```
docker run -it nginx bash
```

```
<update the default page>
```

```
docker ls -a
```

```
docker capture <container> nginx-custom
```

```
docker images
```

```
docker run -d -p 8080 nginx-custom
```

## Automated image creaton

Create a file named `Dockerfile` and enter the folloing text.

```
FROM nginx

RUN

ETC..
```

```
docker build -t nginx-custom-dockerfile
```

```
docker images
```

```
docker run -d -p 8080 nginx-custom-dockerfile
```