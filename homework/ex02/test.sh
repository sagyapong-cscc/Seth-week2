CONTAINER_NAME=web
DEBUG=
CURL_CMD="docker run -it --rm --name try --net=cscc-network curlimages/curl http://web"

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

debug "cleaning up"
cleanup $CONTAINER_NAME
docker volume rm cscc-storage
docker network rm cscc-network
docker pull curlimages/curl > pull.log

docker build -t ex0202setup . > build.log 2>&1

debug "creating network"
./network.sh

debug "creating volume"
./volume.sh

debug "setting up volume"
docker run --rm --name setup --mount source=cscc-storage,target=/data ex0202setup

debug "running container"
./run.sh


[[ $? -eq 0 ]] || fail "Couldn't run the docker container!!!"

set -i count=0
output=$($CURL_CMD 2>curl.log)
RC=$?
while [[ $RC -ne 0 ]]
do
  ((count++))
  [[ $count -gt 4 ]] && break
  sleep 3
  output=$($CURL_CMD 2>>curl.log)
  RC=$?
done

[[ $RC -eq 0 ]] || fail "Couldn't download html from http://web"

[[ "$output" =~ ^"YES!!!"* ]] || fail "Expected \"YES!!!\", got: $output"
cid=$(getid $CONTAINER_NAME)

docker stop $CONTAINER_NAME
cleanup $CONTAINER_NAME

echo "SUCCESS!!!"
