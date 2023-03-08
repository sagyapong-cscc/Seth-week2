For this exercise, you will need to modify the [Dockerfile](Dockerfile) in this directory, and the
[build.sh](build.sh) build script also in this directory to build an image that satisfies the following requirements:
* The image should derive from the apache [httpd docker image](https://hub.docker.com/_/httpd) (please use version 2.4)
* The image should be named `cscc-httpd`
* The image should be tagged with a version of `0.0.1`
* The image should be labeled with a label `creator` the value of which is the value of the builtin `USER` environment variable at the time of the build
* The image should be labeled with a label `build.environment.os.version` the value of which is the value of the `lsb_release -rs` command (see [build.sh](build.sh) for a pointer)
* The image should advertise (with [EXPOSE](https://docs.docker.com/engine/reference/builder/#expose) the fact that it listens on port 80
* When run without any volume mounts, the default HTML it should serve is the contents of [default-index.html](html/default-index.html) (which can be found in the `html` directory)

_Hint_: Read through the [httpd docker image](https://hub.docker.com/_/httpd) page and you will see that the default location apache looks for HTML content to serve is in `/usr/local/apache2/htdocs/`

To verify your answer, you can run `./test.sh`.  If everything works you will see `SUCCESS!!!`
printed to your terminal.
