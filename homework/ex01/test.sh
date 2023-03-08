CONTAINER_NAME=h2ex01
DEBUG=

function debug {
  [[ -n $DEBUG ]] && echo $*
}

function getid {
  echo $(docker ps -aq --filter name=$1 2>>err.log)
}

function fail {
  echo $*
  exit 1
}

function cleanup {
  container=$(getid $1)
  debug "container=$container, arg=$1"
  [[ -n $container ]] && docker rm -f $container 2>>err.log
}

echo "cleaning up - ignore messages about 'no such image'"
cleanup $CONTAINER_NAME
docker rmi cscc-httpd:0.0.1

debug "building image"
./build.sh > build.log

debug "running container"
docker run -d -p 9876:80 --name h2ex01 --rm cscc-httpd:0.0.1

[[ $? -eq 0 ]] || fail "Couldn't run the docker container!!!"

set -i count=0
output=$(curl http://localhost:9876 2>curl.log)
RC=$?
while [[ $RC -ne 0 ]]
do
  ((count++))
  [[ $count -gt 4 ]] && break
  sleep 3
  output=$(curl http://localhost:9876 2>>curl.log)
  RC=$?
done

[[ $RC -eq 0 ]] || fail "Couldn't download html from http://localhost:9876???"

[[ "$output" == "DEFAULT!!!" ]] || fail "Expected \"DEFAULT!!!\", got: $output"
cid=$(getid $CONTAINER_NAME)

build_os=$(docker inspect -f '{{ index .Config.Labels "build.environment.os.version" }}' h2ex01)
[[ "$build_os" == $(lsb_release -rs) ]] || fail "Expected build.environment.os.version: $(lsb_release -rs), actual: $build_os"

creator=$(docker inspect -f '{{ index .Config.Labels "creator" }}' h2ex01)
[[ "$creator" == "$USER" ]] || fail "Expected creator: $USER, actual: $creator"

docker stop $CONTAINER_NAME
cleanup $CONTAINER_NAME

echo "SUCCESS!!!"
