# Building docker images

It's time to try building our own docker images.  Let's start with a simple build using a basic [Dockerfile](Dockerfile).  Review the [Dockerfile](Dockerfile), then review the [build.sh](build.sh) build script.  Finally, run the [build.sh](build.sh) in your terminal window (in this directory).

**You may need to use chmod +x build.sh to make the script executable**

```
[jschmersal1@WFIL011 01-build]$ ./build.sh 
Sending build context to Docker daemon  25.09kB
Step 1/2 : FROM alpine:3
3: Pulling from library/alpine
df20fa9351a1: Pull complete 
Digest: sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321
Status: Downloaded newer image for alpine:3
 ---> a24bb4013296
Step 2/2 : CMD ["echo", "Hello, world!"]
 ---> Running in 33932bf0e32b
Removing intermediate container 33932bf0e32b
 ---> fad54f3e4981
Successfully built fad54f3e4981
Successfully tagged infra-example-01:0.1
```

Now, try to run your newly built image with `docker run infra-example-01:0.1`
```
[jschmersal1@WFIL011 01-build]$ docker run infra-example-01:0.1
Hello, world!
```

Success!

Now, comment out the `CMD` instruction in your [Dockerfile](Dockerfile) and uncomment the
second `CMD`. Build and run your docker image.

Finally, comment out this `CMD` instruction and uncomment the last configuration (`CMD` and
`ENTRYPOINT`).  Build and run your docker image.  Now try running `docker run infra-example-01:0.1 Purple`.  Do you see anything different?  What's happening?  What happens if you run that with either of the two prior `CMD` versions?
