# This Dockerfile builds a very basic docker image.  As you can see, lines starting with #
# are considered comments and ignored when building the image.

# The first command in your Dockerfile is almost always FROM.  FROM dictates what image should
# be the starting point for building your image.  In this example, we'll use the basic alpine image
# that is a bare-bones Linux Distro for Docker
FROM alpine:3

# Almost all images have the CMD instruction.  This tells the image what to run when someone starts the
# container (more on this later).  There are three forms of CMD:
# 1) The exec form (format as an array of strings passed to the exec system command):
CMD ["echo", "Hello, world!"]

# 2) The shell form (sent as a string to be interpreted by the shell):
# CMD echo "Hello, world!"

# 3) The parameter form (used in conjunction with ENTRYPOINT as default parameters to the image)
# ENTRYPOINT ["echo"]
# CMD ["Hello, world!"]

# See https://docs.docker.com/engine/reference/builder/#cmd for more

