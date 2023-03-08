# Dockerfile commands

Let's investigate some more [Dockerfile](Dockerfile) commands.  Please review your 
[Dockerfile](Dockerfile) and [build.sh](build.sh), then build your image:

```
[jschmersal1@WFIL011 02-Dockerfile-commands]$ ./build.sh 
Sending build context to Docker daemon  24.06kB
Step 1/8 : FROM ubuntu
latest: Pulling from library/ubuntu
3ff22d22a855: Pull complete 
e7cb79d19722: Pull complete 
323d0d660b6a: Pull complete 
b7f616834fd0: Pull complete 
Digest: sha256:5d1d5407f353843ecf8b16524bc5565aa332e9e6a1297c73a92d3e754b8a636d
Status: Downloaded newer image for ubuntu:latest
 ---> 1e4467b07108
Step 2/8 : ARG COMMIT_ID
 ---> Running in 95c78837d536
Removing intermediate container 95c78837d536
 ---> 346eea16c490
Step 3/8 : LABEL version="1.0"
 ---> Running in bb9c8ddfe91e
Removing intermediate container bb9c8ddfe91e
 ---> 5a71f2747c4e
Step 4/8 : LABEL git.commit.id=${COMMIT_ID}
 ---> Running in d098a527f1e2
Removing intermediate container d098a527f1e2
 ---> 72c8deda6dca
Step 5/8 : RUN useradd -ms /bin/bash cscc
 ---> Running in fa4b488d7913
Removing intermediate container fa4b488d7913
 ---> c6736a78cb1c
Step 6/8 : USER cscc
 ---> Running in 2cc616840c5d
Removing intermediate container 2cc616840c5d
 ---> d5d43cd982cd
Step 7/8 : ADD content/* /data/internal/
 ---> 7fc35e0b7bc2
Step 8/8 : CMD ["cat", "/data/internal/hello.txt"]
 ---> Running in ec3fd7f205bb
Removing intermediate container ec3fd7f205bb
 ---> 786bc2ce99c4
Successfully built 786bc2ce99c4
Successfully tagged infra-example-02:1.0
```

Now, try to run your newly built image with `docker run --rm infra-example-02:1.0`
```
[jschmersal1@WFIL011 02-Dockerfile-commands]$ docker run --rm infra-example-02:1.0 
Yo, world!
```

Success!

One thing to note is that the docker image is dumping the contents of its internal 
`/data/internal/hello.txt` file, which is created at image time with the contents of the [contents](contents) directory.  We will revisit this example when discussing volumes.
