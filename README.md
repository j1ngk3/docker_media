# docker_media
Compose and Dockerfiles for standing up pirate tivo

The purpose of this repo is to automate the standing up of the services needed for running pirate_tivo at home.

Nearly all the docker-compose files in the subfolders are based on the
[linuxserver docker images](https://hub.docker.com/u/linuxserver/).  See their README's for detailed info.

Sonarr, Radarr, and calibre are making use of a modified version of the linuxserver images I've made 
[here](https://hub.docker.com/u/jingke/).  Sonarr and Radarr have the 
[sickbeard_mp4_automator](https://github.com/mdhiggins/sickbeard_mp4_automator) project added to the container for
automating the remuxing of files downloaded.  This is only needed if you would like to avoid
transcoding files.  See sickbeard_mp4_automator README for info.

Adding a .env file at the root allows you to set the environment variables needed by the compose file in a persistent manner.
See [here](https://docs.docker.com/compose/environment-variables/#the-env-file) for more info.  If you do this, you can start
the services up by running docker-compose up -d in the root directory of the project.

Required environment variables to set, with current set of images:

* CONFIG_DIR
* DOWNLOAD_DIR
* DATA_DIR
* PUID
* PGID
* TZ
* HOSTNAME
* EMAIL
* URL
* SUB
* INTERFACE

You can remove unneeded images by deleting their blocks from the main [docker-compose file](https://github.com/j1ngk3/docker_media/blob/master/docker-compose.yaml) and removing their reference from the letsencrypt block.

### .env Example to get up and running

```bash
git clone https://github.com/j1ngk3/docker_media.git
cd docker_media
echo -e "CONFIG_DIR=/config\nDOWNLOAD_DIR=/downloads\nDATA_DIR=/videos\nPUID=5000\nPGID=5000\nTZ=America/New_York\nHOSTNAME=example.home\nEMAIL=email@example.com\nURL=example.com\nSUB=www\nINTERFACE=vmbr0" >.env"
docker-compose up -d
```

The included watchtower image will keep your running containers up to date with the latest images on the docker hub automatically from then on.