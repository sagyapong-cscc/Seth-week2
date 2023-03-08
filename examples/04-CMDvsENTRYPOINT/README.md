In this example, we'll walk through a demonstration of the difference between CMD and ENTRYPOINT

* cd into the CMD directory and build and run the Dockerfile inside

``` docker build .
docker images 
docker run [image name] 
```

* Your container should print out Hello World
* Now try:

```
docker run [image name] "ls"
```

Since we are using CMD, you will see that the echo command has been overridden by the parameter ls at runtime.


* cd into the ENTRYPOINT directory and build and run the Dockerfile inside

``` docker build .
docker images 
docker run [image name] 
```

* Your container should print out Hello World
* Now try:

```
docker run [image name] "ls"
```

Since we are using ENTRYPOINT, you will see that the echo command has NOT been overridden by the parameter ls at runtime, but instead the command was appended with the string "ls"
