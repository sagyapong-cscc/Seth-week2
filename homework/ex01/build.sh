
# Note, you can save the outpu of bash shell commands to a variable using the $() syntax.  The following
# line saves the current Linux version to the BUILD_OS_VERSION variable:
BUILD_OS_VERSION=$(lsb_release -rs)

#Here is where you should put your 'docker build' command
docker help
