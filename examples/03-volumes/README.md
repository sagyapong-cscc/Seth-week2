# Docker volumes

Docker containers normally "communicate" with the external world in one of two ways:

+ Over the network (i.e. as a server listening on a port)
+ Through the file system (as text files, databases, etc.)

## Reading mounted volumes
Recall that [example 2](../02-Dockerfile-commands) built the `infra-example-02:1.0` image, and that image dumped the contents of the file `/data/internal/hello.txt` that was built into the image from the [hello.txt](../02-Dockerfile-commands/content/hello.txt) file in the example.

However, what if I didn't want to use _that_ version of `hello.txt` and instead wanted to provide
my own?  The answer to that is to use volume mounts to "inject" an alternate directory into the
container at startup.  To do so, you can use the `-v` option (alternatively `--volume`, or the `--mount` option).

For example, let's run example 2 using the [other-content](other-content) as `/data/internal` in 
the container instead of the default contents: 
`docker run --rm -v $PWD/other-content:/data/internal infra-example-02:1.0`

```
[jschmersal1@WFIL011 03-volumes]$ docker run --rm -v $PWD/other-content:/data/internal infra-example-02:1.0
This is an alternate world!
```

Note that it has instead displayed the contents of [other-content/hello.txt](other-content/hello.txt)!

As a bit of an aside, let's see how permissions work between the container and the host.  To do 
so, mark the [private-content/hello.txt](private-content/hello.txt) file so that only you have
access to the file: `chmod 700 private-content/hello.txt`

Recall that the [Dockerfile](../02-Dockerfile-commands/Dockerfile) for example 2 specified that
the docker should run as the `cscc` user.  If that's the case, and if docker can correctly figure
out file permissions, passing the [private-content](private-content) directory as the mounted
volume on container startup should provide some type of error when running the container, rather
than displaying its [hello.txt](private-content/hello.txt).  Let's see:
```
[jschmersal1@WFIL011 03-volumes]$ docker run --rm -v $PWD/private-content:/data/internal infra-example-02:1.0
cat: /data/internal/hello.txt: Permission denied
```
Perfect!

## Writing volumes
Let's build another docker image.  Looking at its [Dockerfile](Dockerfile), you can see that when 
run it appends the current date information to the `/data/run-history.txt` file.  Let's build the
image by running `./build.sh`
```
[jschmersal1@WFIL011 03-volumes]$ ./build.sh 
Sending build context to Docker daemon  35.33kB
Step 1/3 : FROM alpine
 ---> a24bb4013296
Step 2/3 : RUN mkdir /data
 ---> Running in dc29e31cb596
Removing intermediate container dc29e31cb596
 ---> 5065123560ca
Step 3/3 : CMD echo $(date) >> /data/run-history.txt
 ---> Running in 3c6a118e8a1b
Removing intermediate container 3c6a118e8a1b
 ---> a32513272f53
Successfully built a32513272f53
Successfully tagged infra-example-03:3.0
```

Now let's run the docker image: `docker run --name ex3 infra-example-03:3.0`
```
[jschmersal1@WFIL011 03-volumes]$ docker run --name ex3 infra-example-03:3.0
[jschmersal1@WFIL011 03-volumes]$
```

Hmm.. I'm not seeing anything.  

Note, however, that we didn't run with the `--rm` flag, so the container should still be around.
Let's see:
```
[jschmersal1@WFIL011 03-volumes]$ docker ps -a
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS                      PORTS               NAMES
4541fc52c115        infra-example-03:3.0   "/bin/sh -c 'echo $(…"   47 seconds ago      Exited (0) 46 seconds ago                       ex3
```
Yes, the ex3 container is there, but exited.  Docker has a command, `docker diff`, that lets you
see how the container's filesystem has changed.  For this container, you see:
```
[jschmersal1@WFIL011 03-volumes]$ docker diff ex3
C /data
A /data/run-history.txt
```

However, this is not super useful.  I can restart the container and it will continue using that 
internal file system, but I can't access it (easily) from the host.  Imagine if this were a 
database server container.  You would want to be able to make it durable, take snapshots, backups,
etc.  The answer is to volume mount your own file system contents into the container at startup.

### External binds

What if we run it again, but instead pass it a directory from our host?  Let's try it.

+ First, create an empty directory: `mkdir output`
+ Now let's run the docker a couple times passing `output` as the volume it writes to: `docker run --rm -v $PWD/output:/data infra-example-03:3.0`
```
[jschmersal1@WFIL011 03-volumes]$ docker run --rm -v $PWD/output:/data infra-example-03:3.0
[jschmersal1@WFIL011 03-volumes]$ docker run --rm -v $PWD/output:/data infra-example-03:3.0
```
+ Did you notice that [output/run-history.txt](output/run-history.txt) exists now? What is it's content?
```
[jschmersal1@WFIL011 03-volumes]$ cat output/run-history.txt 
Tue Jul 28 19:09:32 UTC 2020
Tue Jul 28 19:09:34 UTC 2020
```

### Summary
The example here shows the start of storage volumes in Docker.  It is a fairly complex topic, however.  This example demonstrated "Bind Mounts", where the volume mounted into the container is a local file system on the host.  Docker has a richer volume environment, [Docker volumes](https://docs.docker.com/storage/volumes/#create-and-manage-volumes), that lets users create volumes independent of containers, and allows for off-host volumes (e.g. storage backed by AWS).
