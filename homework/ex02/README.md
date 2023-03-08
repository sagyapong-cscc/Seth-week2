In this exercise you will create networks and volumes, and you will make a docker container that makes use of both.

For this exercise, you will need to: 
* [Create a docker volume](https://docs.docker.com/engine/reference/commandline/volume_create/), named `cscc-storage`, with a label called `usage` that has a value of `ex02`.  It is OK for the volume to have no other configuration (i.e. use the default `overlay` volume driver). The command to create the volume should be recorded in [volume.sh](volume.sh)
* [Create a network](https://docs.docker.com/engine/reference/commandline/network_create/),  named `cscc-network`.  The `cscc-network` should be a `bridge` network (i.e. using the `bridge` driver).  It is OK for the network to have no other configuration.  The command to create the network should be recorded in [network.sh](network.sh) 
* In [run.sh], record a command that will create and run a docker container with the following requirements:
  * The image used should be `httpd`, with the `2.4` tag
  * The container should be `detached`
  * The container should be removed automatically when stopped
  * The container should be named `web`
  * You should [mount](https://docs.docker.com/storage/volumes/) the `cscc-storage` volume to `/usr/local/apache2/htdocs/` inside the container
  * You should use the `cscc-network` network as the network (using the `--net` option) for the `web` container

_Hint_: Read through the [httpd docker image](https://hub.docker.com/_/httpd) page and you will see that the default location apache looks for HTML content to serve is in `/usr/local/apache2/htdocs/`

To verify your answer, you can run `./test.sh`.  If everything works you will see `SUCCESS!!!`
printed to your terminal.

Note:  You should NOT modify the Dockerfile or /html directory, these are included as a test construct.
