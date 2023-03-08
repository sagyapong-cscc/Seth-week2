# More Dockerfile commands.  For more reference, see https://docs.docker.com/engine/reference/builder/
FROM ubuntu

# LABEL is a useful command for adding on-demand label (name/value pair metadata) that you can later interrogate your 
# images and containers for using 'docker inspect'.  Labels are frequently used for information like maintainer, git
# commit information, email addresses, etc.
# ARG means the Dockerfile is expecting that variable to be supplied as a build-time argument using the --build-arg
# flag.
ARG COMMIT_ID
LABEL version="1.0" 
LABEL git.commit.id=${COMMIT_ID}

# RUN is very common.  It's used to run a shell command as part of the docker build
# this one adds a "cscc" user
RUN useradd -ms /bin/bash cscc

# USER specifies the user the container should run as (defaults to "root").  Note you need to have the user
# added for this to make sense
USER cscc

# ADD adds files from your build context.  The build context is passed as part of the "docker build" command, and
# is frequently the same directory the build script is in
ADD content/* /data/internal/

CMD ["cat", "/data/internal/hello.txt"]
