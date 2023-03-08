# This is a pretty simple build script.  It uses the docker CLI to build a docker image.  The only parameter
# that we pass to it is "-t" to specify a "name:tag" to give the built image.  Note the "." at the end.  That
# tells docker where to find the information to build the image, and by default docker looks for a Dockerfile
# in the provided directory
docker build -t infra-example-01:0.1 .

# Note that most docker builds are more involved.  Run 'docker build --help' to see the kinds of options you
# can specify.

# Also note that frequently shell scripts aren't used to build docker images.  Since docker exposes its access
# to the daemon as an API, many build tools have plugins or integration with docker that let you build images in
# that tool.  For example, if you have a java-based project and are using maven as your build tool, you can use
# the [docker-maven-plugin](https://github.com/fabric8io/docker-maven-plugin) to build, run, and test your docker
# images as part of your build pipeline.
