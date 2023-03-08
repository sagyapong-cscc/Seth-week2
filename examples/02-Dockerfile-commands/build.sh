# The interesting thing here is we're passing a built-time argument using the "--build-arg" option
export COMMIT_ID=$(git rev-parse --short HEAD)
docker build --build-arg COMMIT_ID -t infra-example-02:1.0 .

