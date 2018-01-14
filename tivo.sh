#!/bin/bash

function usage()
{
cat <<-EOF
usage: `basename $0` [OPTIONS]

OPTIONS:
  -h --help   Show this message
  -c --config Configuration Directory (required)
  -d --download Download Directory (required)
  -a --data Data Directory (required)
  -u --puid UserID
  -g --pgid GroupID
  -t --tz Timezone Information 

EXAMPLE:

  $(basename $0) -c /data/config -d /data/downloads -a /mnt

EOF
}

OPTS=`getopt -o hc:d:a:u:g:t: --long help,config:,download:,data:,puid:,pgid:,tz: -n 'tivo.sh' -- "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$OPTS"

#Set defaults
export CONFIG_DIR=${CONFIG_DIR}
export DOWNLOAD_DIR=${DOWNLOAD_DIR}
export DATA_DIR=${DATA_DIR}
export PUID=$(id -u)
export PGID=$(id -g)
export TZ=$(cat /etc/timezone)

# Collect script options
while true; do
    case "$1" in
        -h|--help) # Show help
            usage
            exit 1
            ;;
        -c|--config)
            case "$2" in
                "") shift 2 ;;
                *)  export CONFIG_DIR=$2; shift 2 ;;
            esac ;;
        -d|--download) 
            case "$2" in
                "") shift 2 ;;
                *)  export DOWNLOAD_DIR=$2; shift 2 ;;
            esac ;;
        -a|--data) 
            case "$2" in
                "") shift 2 ;;
                *)  export DATA_DIR=$2; shift 2 ;;
            esac ;;
        -u|--puid) 
            case "$2" in
                "") shift 2 ;;
                *)  export PUID=$2; shift 2 ;;
            esac ;;
        -g|--pgid) 
            case "$2" in
                "") shift 2 ;;
                *)  export PGID=$2; shift 2 ;;
            esac ;;
        -t|--tz)
            case "$2" in
                "")  shift 2 ;;
                *)  export TZ=$2; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "Internal error!"; exit 1 ;;
    esac
done

# Check for required options
if [ -z ${CONFIG_DIR} ] ; then
    usage
    exit 1
fi

if [ -z ${DOWNLOAD_DIR} ] ; then
    usage
    exit 1
fi

if [ -z ${DATA_DIR} ] ; then
    usage
    exit 1
fi

if [ -z ${PUID} ] ; then
    usage
    exit 1
fi

if [ -z ${PGID} ] ; then
    usage
    exit 1
fi

if [ -z ${TZ} ] ; then
    usage
    exit 1
fi
docker-compose down
docker-compose up -d 
